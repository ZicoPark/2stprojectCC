package kr.co.cc.doc.service;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.cc.alarm.config.WebSocketHandler;
import kr.co.cc.doc.dao.DocDAO;
import kr.co.cc.doc.dto.ApprovalDTO;
import kr.co.cc.doc.dto.AttachmentDTO;
import kr.co.cc.doc.dto.DocDTO;
import kr.co.cc.doc.dto.DocFormDTO;
import kr.co.cc.doc.dto.MemberDTO;

@Service
@MapperScan(value={"kr.co.cc.doc.dao"})
@Transactional
public class DocService {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	@Value("${spring.servlet.multipart.location}") private String attachmentRoot;
	
	private final DocDAO dao;
	private WebSocketHandler handler = null;
	
	public DocService(DocDAO dao, WebSocketHandler handler){
		this.dao = dao;
		this.handler = handler;
	}

	public ModelAndView docWriteForm(HttpSession session) {
		
		ModelAndView mav = new ModelAndView("/doc/docWriteForm");
		
		// 결재 종류 불러오기
		ArrayList<ApprovalDTO> approvalKindList = dao.getApprovalList();
		// 기안은 제외(기안자가 나 자신이니까)
		approvalKindList.remove(0);
		mav.addObject("approvalKindList", approvalKindList);
		
		// 결재자 선택하기 위해 직원 리스트 불러오기
		ArrayList<HashMap<String, String>> memberList = dao.getMemberList();
		mav.addObject("memberList", memberList);
		
		// 기안문 양식 불러오기
		ArrayList<DocFormDTO> docFormList = dao.getDocFormList();
		
		// 기안문 양식에 세션 아이디의 이름과 부서 붙이기
		// 기안자의 정보를 모두 불러오기
		String loginId = (String) session.getAttribute("id");
		MemberDTO memberInfo = dao.getMemberInfo(loginId);
		
		String name = memberInfo.getName();
		HashMap<String, String> deptMap = dao.getDeptMap(memberInfo.getDept_id());
		String deptName = deptMap.get("name");
		
		ArrayList<DocFormDTO> newDocFormList = new ArrayList<DocFormDTO>();
		
		for (DocFormDTO docForm : docFormList) {
			String oriContent = docForm.getContent();
			String nameWritedContent = docFormUpdate(oriContent, "<span id=\"docFormCreateMemberName\" style=\"font-size: 16px; text-align: left; font-style: italic; color: rgb(255, 0, 0)\">(기안자 자동 입력)</span>", "<span id=\"docFormCreateMemberName\" style=\"font-size: 16px; text-align: left;\">"+name+"</span>");
			String deptWritedContent = docFormUpdate(nameWritedContent, "<span id=\"docFormCreateDeptName\" style=\"font-size: 16px; text-align: left; font-style: italic; color: rgb(255, 0, 0)\">(소속 자동 입력)</span>", "<span id=\"docFormCreateDeptName\" style=\"font-size: 16px; text-align: left;\">"+deptName+"</span>");
			docForm.setContent(deptWritedContent);
			newDocFormList.add(docForm);
		}
		
		mav.addObject("docFormList", newDocFormList);
		
		return mav;
	}

	// 결재문서 양식에 수정할 때 쓰는 메서드
	public String docFormUpdate(String oriDocForm, String oriString, String newString) {
		
		StringBuffer sb = new StringBuffer(oriDocForm);
		String newDocForm = sb.replace(sb.indexOf(oriString), (sb.indexOf(oriString)+oriString.length()), newString).toString();
		
		return newDocForm;
	}

	public ModelAndView docWrite(HashMap<String, String> params, 
			ArrayList<String[]> approvalList,
			MultipartFile[] attachment, HttpSession session) {

		// dto 만들어서 받아온 전자정보 문서를 넣는다.
		DocDTO dto = new DocDTO();
		dto.setSubject(params.get("subject"));
		dto.setContent(params.get("content"));
		
		int status = Integer.parseInt(params.get("status"));
		dto.setStatus(status); // 1 : 정상 2 : 임시저장
		dto.setDoc_form_id(params.get("docFormId")); // 기안문서 양식 id
		
		// 세션에서 기안자 정보 모두 가져오기
		String loginId = (String) session.getAttribute("id");
		MemberDTO memberInfo = dao.getMemberInfo(loginId);
		
		dto.setMember_id(memberInfo.getId());
		dto.setDept_id(memberInfo.getDept_id());
		
		HashMap<String, String> jobLevelMap = dao.getJobLevelMap(memberInfo.getJob_level_id());
		HashMap<String, String> deptMap; // approval 테이블 insert 할 때 씀.
		
		String jobLevelName = jobLevelMap.get("name");
		dto.setJob_level_name(jobLevelName);
		
		dto.setPublic_range(params.get("publicRange"));
		
		logger.info("params : "+params);
		
		String docId = UUID.randomUUID().toString();
		dto.setId(docId); // uuid를 자바에서 생성해서 doc의 PK 값으로 쓴다. // 얘가 문서번호임.
		
		int row = dao.docWrite(dto); // 완성된 문서를 데이터베이스에 등록한다.
		
		logger.info("inserted doc row : "+row);	
		logger.info("docId : "+docId);
		
		if(row==1) { // 업로드된 doc이 1이라면
						
			for (MultipartFile file : attachment) {
				
				logger.info("업로드할 file 있나요? :"+!file.isEmpty());
				
				if(!file.isEmpty()) {
					attachmentSave(docId, file, "전자문서첨부파일");
				}
				
				try { // 쓰레드 0.001초 지연으로 중복파일명 막자
					Thread.sleep(1);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				
			}
			
		}	
		
		// 방금 등록한 문서의 정보를 가져온다.
		DocDTO docDTO = dao.getWritedDoc(docId);
		
		// 등록된 문서의 본문을 넣는다.
		String oriWritedContent = docDTO.getContent();
		
		// 문서번호에 고유의 문서번호를 넣는다.
		String idWritedContent = docFormUpdate(oriWritedContent, "<span id=\"docFormIssuedNumber\" style=\"font-size: 16px; text-align: left; font-style: italic; color: rgb(255, 0, 0);\">(문서번호 자동 입력)", "<span id=\"docFormIssuedNumber\" style=\"font-size: 16px; text-align: left;\">"+docId);
		
		// 상태가 1 : 정상결재요청, 2 : 임시저장이면 이동페이지를 다르게 조정해서 보낸다.
		ModelAndView mav = new ModelAndView();
		if(status==2) {
			// 임시저장 시에는 결재선은 저장하지 않는다.
			// 임시저장 시에는 결재선 렌더링 하지 않음.
			// 임시저장 시에는 도장 안넣음.
			dao.docWriteETC(docId, idWritedContent);
			
			// 임시저장함으로 보낸다.
			mav.setViewName("redirect:/tempDocList.go");
			
		}else {
			
			// 결재선을 확인하여 도장찍는 위치에 칸을 렌더링한다.
			String lineWritedContent;
			String kianSignWritedContent;
			String approvalLinePriority;
			String approvalLineName;
			String approvalLineMemberId;
			
			String oriLine = 
					"<div class=\"flex-container\" style=\"display: flex;\">\r\n" + 
					"<div style=\"width:100px; float:left;\">\r\n" + 
					"<div class=\"approvalName \" style=\"width:100px; height:25px; border:1px solid black; font-size: 16px; text-align : center; background-color:lightgray;\">기안</div>\r\n" + 
					"<div class=\"approvalSign \" style=\"width:100px; height:75px; border:1px solid black; font-size: 16px; color: rgb(255, 0, 0); font-style: italic; text-align : center;\">(기안 서명)</div>\r\n" + 
					"<div class=\"approvalDate \" style=\"width:100px; height:25px; border:1px solid black; font-size: 16px; color: rgb(255, 0, 0); font-style: italic; text-align : center;\">(결재일)</div>\r\n" + 
					"</div>";

			String newLine = oriLine;
			
				for(int i = 0;i<approvalList.size();i++) { // 화면 상 윗 결재선부터 풀 예정
					
					approvalLinePriority = approvalList.get(i)[0];
					approvalLineName = dao.getApprovalName(approvalLinePriority); // 결재종류의 이름 가져오기
					approvalLineMemberId = approvalList.get(i)[1];
					newLine += 
							"\r\n<div style=\"width:100px; float:left;\">\r\n" + 
							"<div class=\"approvalName "+approvalLineMemberId+"\" style=\"width:100px; height:25px; border:1px solid black; font-size: 16px; text-align : center; background-color:lightgray;\">"+approvalLineName+"</div>\r\n" + 
							"<div class=\"approvalSign "+approvalLineMemberId+"\" style=\"width:100px; height:75px; border:1px solid black; font-size: 16px; color: rgb(255, 0, 0); font-style: italic; text-align : center;\">("+approvalLineName+" 서명)</div>\r\n" + 
							"<div class=\"approvalDate "+approvalLineMemberId+"\" style=\"width:100px; height:25px; border:1px solid black; font-size: 16px; color: rgb(255, 0, 0); font-style: italic; text-align : center;\">(결재일)</div>\r\n" + 
							"</div>";

				}
			
				lineWritedContent = docFormUpdate(idWritedContent, oriLine, newLine);
				
				// 기안일자에 등록날짜를 넣는다.
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String createDate = sdf.format(docDTO.getCreate_at());
				String dateWritedContent = docFormUpdate(lineWritedContent, "<span id=\"docFormCreateDate\" style=\"font-size: 16px; text-align: left; font-style: italic; color: rgb(255, 0, 0)\">(기안일자 자동 입력)</span>", "<span id=\"docFormCreateDate\" style=\"font-size: 16px; text-align: left;\">"+createDate+"</span>");
				logger.info("docDTO.getCreate_at() :"+docDTO.getCreate_at());
				String simpleCreateDate = createDate.substring(0, 10);
				String lineDateWritedContent = docFormUpdate(dateWritedContent, "<div class=\"approvalDate \" style=\"width:100px; height:25px; border:1px solid black; font-size: 16px; color: rgb(255, 0, 0); font-style: italic; text-align : center;\">(결재일)</div>", "<div class=\"approvalDate \" style=\"width:100px; height:25px; border:1px solid black; font-size: 16px; text-align : center;\">"+simpleCreateDate+"</div>");
				logger.info("simpleCreateDate :"+simpleCreateDate);
				
				// 결재선 라인을 렌더링 한 후, 우선 기안자의 도장 이미지를 가져온다.
				String memberStampBase64;
				String fileName = getMemberSignFilePath(memberInfo.getId());
				String kianSign = "<div class=\"approvalSign \" style=\"width:100px; height:75px; border:1px solid black; font-size: 16px; text-align : center;\"><span style=\"width:100px; height:100px; border:1px solid white; font-weight: bold; font-size:20px; text-align:center;\">"+memberInfo.getName()+"</span>"; // 서명이미지 파일이 없으면 그냥 멤버 이름을 넣기 때문에 멤버 이름으로 초기화한다.
				logger.info("fileName : "+fileName); // 서명이미지가 없으면 null이 출력된다.
				
				if(fileName!=null) { 
					// 서명이미지 파일이 있으면 멤버의 이미지파일을 가져와 base64로 인코딩해서 넣는다.
					try {
						byte[] src = FileUtils.readFileToByteArray(new File(attachmentRoot+"/"+fileName));
						memberStampBase64 = Base64.getEncoder().encodeToString(src);
						kianSign = "<div class=\"approvalSign \" style=\"width:100px; height:75px; border:1px solid black; font-size: 16px; text-align : center;\"><img src=\"data:image/png;base64,"+memberStampBase64+"\" style=\"max-width: 100%;\" />"+"<span style=\"width:100px; height:100px; border:1px solid white; font-size:16px; text-align:center;\">"+memberInfo.getName()+"</span>";
					} catch (IOException e) {
						e.printStackTrace();
					}
					
				}
				
				kianSignWritedContent = docFormUpdate(lineDateWritedContent, "<div class=\"approvalSign \" style=\"width:100px; height:75px; border:1px solid black; font-size: 16px; color: rgb(255, 0, 0); font-style: italic; text-align : center;\">(기안 서명)", kianSign);
	
			dao.docWriteETC(docId, kianSignWritedContent);
			
			// status가 1일때는 결재요청함으로 보낸다.
			mav.setViewName("redirect:/requestDocList.go");
			
			// 정상결재요청 시에는 결재선을 저장한다.
			HashMap<String, Object> docStatusMap = new HashMap<String, Object>();
			
			String approvalPriority;
			String approvalId;
			String approvalMemberId;
			MemberDTO approvalMemberInfo;
			
			int orderRank = 0; // 결재순서는 0부터 시작
			
			for(int i = 0;i<approvalList.size();i++) {
				
				approvalPriority = approvalList.get(i)[0];
				approvalId = dao.getApprovalId(approvalPriority);
				approvalMemberId = approvalList.get(i)[1];
				approvalMemberInfo = dao.getMemberInfo(approvalMemberId);
				
				docStatusMap.put("doc_id", docId);
				docStatusMap.put("member_id", approvalMemberId);
				
				jobLevelMap = dao.getJobLevelMap(approvalMemberInfo.getJob_level_id());
				docStatusMap.put("job_name", jobLevelMap.get("name"));
				
				deptMap = dao.getDeptMap(approvalMemberInfo.getDept_id());
				docStatusMap.put("dept_name", deptMap.get("name"));
				docStatusMap.put("approval_id", approvalId);
				docStatusMap.put("order_rank", orderRank);
				
				dao.approvalWrite(docStatusMap);
				
				if(orderRank==0) { // 지금 결재요청한 문서의 첫 결재자가 0순위라면 알림 테이블에 등록하자.
					docNotice(memberInfo.getId(), approvalMemberId, "전자결재", docId);
					
					// docNotice 메서드가 실행될때는 알림을 보내기 위해 아래의 메서드를 실행한다.
					handler.sendAlarm("알림이 왔습니다");
				}
				
				orderRank++; // 0순위를 저장 후 결재순위가 1씩 증가함.
				
			}
			
		}
		
		return mav;
	}

	public void docNotice(String sendId, String receiveId, String type, String identifyValue) {
		// 순서대로 보내는 아이디, 받는 아이디, 알림유형, 구분번호
		
		dao.docNotice(sendId, receiveId, type, identifyValue);
	}

	private void attachmentSave(String identifyValue, MultipartFile file, String classification) {

		String oriFileName = file.getOriginalFilename();
		String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
		String attachmentId = UUID.randomUUID() + ext;
		logger.info("파일 업로드 : "+oriFileName+"=>"+attachmentId+"으로 변경될 예정");
		
		try {
			byte[] bytes = file.getBytes();
			Path path = Paths.get(attachmentRoot+"/"+attachmentId);
			Files.write(path, bytes);
			logger.info(attachmentId+" upload 디렉토리에 저장 완료 !");
			
			dao.attachmentSave(attachmentId, oriFileName, classification, identifyValue);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	public String getMemberSignFilePath(String memberId) {
		
		String fileName = dao.getMemberSignFilePath(memberId);
		
		return fileName;
	}

	public ModelAndView tempDocList(HttpSession session) {
		
		ModelAndView mav = new ModelAndView("/doc/tempDocList");
		
		int status = 2; // 1: 정상결재요청 2: 임시저장
		String loginId = (String) session.getAttribute("id");
		
		ArrayList<DocDTO> tempDocList = dao.getDocList(loginId, status);
		
		mav.addObject("list", tempDocList);
		
		return mav;
	}

	public ModelAndView tempDocUpdateForm(String docId) {

		ModelAndView mav = new ModelAndView("/doc/tempDocUpdateForm");
			
		// 결재 종류 불러오기
		ArrayList<ApprovalDTO> approvalKindList = dao.getApprovalList();
		// 기안은 제외(기안자가 나 자신이니까)
		approvalKindList.remove(0);
		mav.addObject("approvalKindList", approvalKindList);
		
		// 결재자 선택하기 위해 직원 리스트 불러오기
		ArrayList<HashMap<String, String>> memberList = dao.getMemberList();
		mav.addObject("memberList", memberList);
		
		// 임시저장된 문서의 정보 불러오기
		DocDTO docDTO = dao.getWritedDoc(docId);
		mav.addObject("docDTO", docDTO);
		
		// 기안자 이름 불러오기
		MemberDTO memberDTO = dao.getMemberInfo(docDTO.getMember_id());
		mav.addObject("memberName", memberDTO.getName());
		
		// 문서종류 불러오기
		DocFormDTO docFormDTO = dao.getDocForm(docDTO.getDoc_form_id());
		mav.addObject("docFormName", docFormDTO.getName());
		
		// 임시저장된 문서의 첨부파일 불러오기
		ArrayList<AttachmentDTO> attachmentList = dao.getAttachmentList(docId);
		mav.addObject("attachmentList", attachmentList);
		
		return mav;
	}
	
	public ModelAndView tempDocDelete(String docId) {
		
		// 문서를 삭제한 후 임시저장함으로 보낸다.
		ModelAndView mav = new ModelAndView("redirect:/tempDocList.go");
		
		// 첨부파일이 있는 경우가 있으니 첨부파일 목록을 가져온다.
		ArrayList<AttachmentDTO> attachmentList = dao.getAttachmentList(docId);
		String attachmentId;
		int row = 0;
		
		// 첨부파일이 있다면? 1. 데이터베이스에서 삭제한다.
		if(attachmentList.size()>0) {
			
			for (AttachmentDTO attachmentDTO : attachmentList) {
				
				attachmentId = attachmentDTO.getId();
				row = dao.docAttachmentDelete(attachmentId);
				
				if(row==1) {
					// 2. 실제 파일을 삭제한다.
					fileDelete(attachmentId);
				}
				
			}
			
		}
		
		// 작업이 끝나면 문서를 삭제한다.
		row = dao.docDelete(docId);
		logger.info("deleted doc row : "+row);
		
		return mav;
	}

	// 첨부파일을 다운로드하는 메서드
	public ResponseEntity<Resource> docAttachmentDownload(String oriFileName, String attachmentId) {

		Resource body = new FileSystemResource(attachmentRoot+"/"+attachmentId);
		
		HttpHeaders headers = new HttpHeaders();
		
		String fileName = "다운로드_"+oriFileName;
		
		try {
			fileName = URLEncoder.encode(fileName, "UTF-8");
			headers.add("content-type", "application/octet-stream");
			headers.add("content-disposition", "attachment;fileName=\""+fileName+"\"");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<Resource>(body, headers, HttpStatus.OK);
	}

	// 파일명을 DB에서 지우는 메서드, 이후 실제 파일을 지우는 fileDelete 메서드를 실행한다.
	public ModelAndView docAttachmentDelete(String docId, String attachmentId) {
		
		ModelAndView mav = new ModelAndView("redirect:/tempDocUpdateForm.go?id="+docId);
		
		int row = dao.docAttachmentDelete(attachmentId);
		
		if(row==1){ // 삭제된 DB 상의 파일명이 1개라면 실제 파일 지우는 메서드를 실행한다.
			
			fileDelete(attachmentId);
			
		}
		
		return mav;
	}
	
	// 파일을 지우는 메서드
	private void fileDelete(String newFileName) {
		
		File file = new File(attachmentRoot+"/"+newFileName);
		
		if(file.exists()) {
			file.delete();
		}
		
	}

	// 임시저장한 문서를 결재요청하는 메서드
	public ModelAndView docUpdate(HashMap<String, String> params, 
			ArrayList<String[]> approvalList,
			MultipartFile[] attachment, HttpSession session) {
		
		// params : id, subject, publicRange, afterContent, status
		logger.info("update hashmap : "+params);
		
		// 업데이트에 따른 파일 저장에 쓸 row 변수 선언.
		int row = 0;
		
		// 세션에서 기안자 정보 모두 가져오기
		String loginId = (String) session.getAttribute("id");
		MemberDTO memberInfo = dao.getMemberInfo(loginId);

		// 최초 임시저장 시에 DB create_date에 데이터가 입력되었음.
		// 결재요청 했을 때 새로 create_date를 입력해야 함.
		long currentTime = System.currentTimeMillis();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
		String docUpdateTime = sdf.format(new Date(currentTime));

		logger.info("docUpdateTime : "+docUpdateTime);
		
		params.put("docUpdateTime", docUpdateTime);
		
		ModelAndView mav = new ModelAndView("redirect:/tempDocList.go");
		
		// 다시 임시저장을 눌렀을 때 status = 2 일 때
		if(params.get("status").equals("2")) {
			
			// DB에 수정된 문서를 업데이트한다.
			row = dao.docUpdate(params);
			
		}else {
			// 결재요청을 했을 때 status = 1 일 때
			
			// 업데이트 시간을 문서에 렌더링해야 함.
			String dateWritedContent = docFormUpdate(params.get("afterContent"), "<span id=\"docFormCreateDate\" style=\"font-size: 16px; text-align: left; font-style: italic; color: rgb(255, 0, 0)\">(기안일자 자동 입력)</span>", "<span id=\"docFormCreateDate\" style=\"font-size: 16px; text-align: left;\">"+docUpdateTime.substring(0, 19)+"</span>");
			
			// 결재선을 확인하여 도장찍는 위치에 칸을 렌더링한다.
			
			String approvalLinePriority;
			String approvalLineName;
			String approvalLineMemberId;
			
			String oriLine = 
					"<div class=\"flex-container\" style=\"display: flex;\">\r\n" + 
					"<div style=\"width:100px; float:left;\">\r\n" + 
					"<div class=\"approvalName \" style=\"width:100px; height:25px; border:1px solid black; font-size: 16px; text-align : center; background-color:lightgray;\">기안</div>\r\n" + 
					"<div class=\"approvalSign \" style=\"width:100px; height:75px; border:1px solid black; font-size: 16px; color: rgb(255, 0, 0); font-style: italic; text-align : center;\">(기안 서명)</div>\r\n" + 
					"<div class=\"approvalDate \" style=\"width:100px; height:25px; border:1px solid black; font-size: 16px; color: rgb(255, 0, 0); font-style: italic; text-align : center;\">(결재일)</div>\r\n" + 
					"</div>";

			String newLine = oriLine;
			
				for(int i = 0;i<approvalList.size();i++) { // 화면 상 윗 결재선부터 풀 예정
					
					approvalLinePriority = approvalList.get(i)[0];
					approvalLineName = dao.getApprovalName(approvalLinePriority); // 결재종류의 이름 가져오기
					approvalLineMemberId = approvalList.get(i)[1];
					newLine += 
							"\r\n<div style=\"width:100px; float:left;\">\r\n" + 
							"<div class=\"approvalName "+approvalLineMemberId+"\" style=\"width:100px; height:25px; border:1px solid black; font-size: 16px; text-align : center; background-color:lightgray;\">"+approvalLineName+"</div>\r\n" + 
							"<div class=\"approvalSign "+approvalLineMemberId+"\" style=\"width:100px; height:75px; border:1px solid black; font-size: 16px; color: rgb(255, 0, 0); font-style: italic; text-align : center;\">("+approvalLineName+" 서명)</div>\r\n" + 
							"<div class=\"approvalDate "+approvalLineMemberId+"\" style=\"width:100px; height:25px; border:1px solid black; font-size: 16px; color: rgb(255, 0, 0); font-style: italic; text-align : center;\">(결재일)</div>\r\n" + 
							"</div>";

				}
			
				String lineDocForm = docFormUpdate(dateWritedContent, oriLine, newLine);
				
				// 결재선 결재일에 시간 넣어야 함.
				String simpleUpdateDate = docUpdateTime.substring(0, 10);
				String lineDateWritedContent = docFormUpdate(lineDocForm, "<div class=\"approvalDate \" style=\"width:100px; height:25px; border:1px solid black; font-size: 16px; color: rgb(255, 0, 0); font-style: italic; text-align : center;\">(결재일)</div>", "<div class=\"approvalDate \" style=\"width:100px; height:25px; border:1px solid black; font-size: 16px; text-align : center;\">"+simpleUpdateDate+"</div>");
				
				// 결재선 라인을 렌더링 한 후, 우선 기안자의 도장 이미지를 가져온다.
				String memberStampBase64;
				String fileName = getMemberSignFilePath(memberInfo.getId());
				String kianSign = "<div class=\"approvalSign \" style=\"width:100px; height:75px; border:1px solid black; font-size: 16px; text-align : center;\"><span style=\"width:100px; height:100px; border:1px solid white; font-weight: bold; font-size:20px; text-align:center;\">"+memberInfo.getName()+"</span>"; // 서명이미지 파일이 없으면 그냥 멤버 이름을 넣기 때문에 멤버 이름으로 초기화한다.
				logger.info("fileName : "+fileName); // 서명이미지가 없으면 null이 출력된다.
				
				if(fileName!=null) { 
					// 서명이미지 파일이 있으면 멤버의 이미지파일을 가져와 base64로 인코딩해서 넣는다.
					try {
						byte[] src = FileUtils.readFileToByteArray(new File(attachmentRoot+"/"+fileName));
						memberStampBase64 = Base64.getEncoder().encodeToString(src);
						kianSign = "<div class=\"approvalSign \" style=\"width:100px; height:75px; border:1px solid black; font-size: 16px; text-align : center;\"><img src=\"data:image/png;base64,"+memberStampBase64+"\" style=\"max-width: 100%;\" />"+"<span style=\"width:100px; height:100px; border:1px solid white; font-size:16px; text-align:center;\">"+memberInfo.getName()+"</span>";
					} catch (IOException e) {
						e.printStackTrace();
					}
					
				}
				
			String kianSignDocForm = docFormUpdate(lineDateWritedContent, "<div class=\"approvalSign \" style=\"width:100px; height:75px; border:1px solid black; font-size: 16px; color: rgb(255, 0, 0); font-style: italic; text-align : center;\">(기안 서명)", kianSign);
			
			params.put("afterContent", kianSignDocForm);
			
			// DB에 수정된 문서를 업데이트한다.
			row = dao.docUpdate(params);
			
			// status가 1일때는 결재요청함으로 보낸다.
			mav.setViewName("redirect:/requestDocList.go");
			
			// 정상결재요청 시에는 결재선을 저장한다.
			HashMap<String, Object> docStatusMap = new HashMap<String, Object>();
			
			String approvalPriority;
			String approvalId;
			String approvalMemberId;
			MemberDTO approvalMemberInfo;
			
			int orderRank = 0; // 결재순서는 0부터 시작
			
			HashMap<String, String> jobLevelMap;
			HashMap<String, String> deptMap;
			
			for(int i = 0;i<approvalList.size();i++) {
				
				approvalPriority = approvalList.get(i)[0];
				approvalId = dao.getApprovalId(approvalPriority);
				approvalMemberId = approvalList.get(i)[1];
				approvalMemberInfo = dao.getMemberInfo(approvalMemberId);
				
				docStatusMap.put("doc_id", params.get("id"));
				docStatusMap.put("member_id", approvalMemberId);
				
				jobLevelMap = dao.getJobLevelMap(approvalMemberInfo.getJob_level_id());
				docStatusMap.put("job_name", jobLevelMap.get("name"));
				
				deptMap = dao.getDeptMap(approvalMemberInfo.getDept_id());
				docStatusMap.put("dept_name", deptMap.get("name"));
				docStatusMap.put("approval_id", approvalId);
				docStatusMap.put("order_rank", orderRank);
				
				dao.approvalWrite(docStatusMap);
				
				if(orderRank==0) { // 지금 결재요청한 문서의 첫 결재자가 0순위라면 알림 테이블에 등록하자.
					docNotice(memberInfo.getId(), approvalMemberId, "전자결재", params.get("id"));
					
					// docNotice 메서드가 실행될때는 알림을 보내기 위해 아래의 메서드를 실행한다.
					handler.sendAlarm("알림이 왔습니다");
				}
				
				orderRank++; // 0순위를 저장 후 결재순위가 1씩 증가함.
				
			}
			
		}
		
		// 업데이트 후에 파일을 확인 후 업로드한다.
		if(row==1) { // 업데이트된 doc이 1이라면
			
			for (MultipartFile file : attachment) {
				
				logger.info("업로드할 file 있나요? :"+!file.isEmpty());
				
				if(!file.isEmpty()) {
					attachmentSave(params.get("id"), file, "전자문서첨부파일");
				}
				
				try { // 쓰레드 0.001초 지연으로 중복파일명 막자
					Thread.sleep(1);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				
			}
			
		}

		return mav;
	}

	public ModelAndView requestDocList(HttpSession session) {
		
		ModelAndView mav = new ModelAndView("/doc/requestDocList");
		
		String loginId = (String) session.getAttribute("id");
		
		ArrayList<HashMap<String, String>> requestDocList = dao.getRequestDocList(loginId);
		
//		logger.info("requestDocList : "+requestDocList);
		
		mav.addObject("list", requestDocList);
		
		return mav;
	}

	public ModelAndView requestDocDetail(String docId) {
		
		ModelAndView mav = new ModelAndView("/doc/requestDocDetail");
		
		// 문서의 정보 불러오기
		HashMap<String, String> doc = dao.requestDocDetail(docId);
		mav.addObject("doc", doc);
		
		// 문서의 결재 정보를 불러오기
		ArrayList<HashMap<String, String>> docStatusList = dao.getDocStatusList(docId);
		mav.addObject("docStatusList", docStatusList);
		
		// 문서의 첨부파일 불러오기
		ArrayList<AttachmentDTO> attachmentList = dao.getAttachmentList(docId);
		mav.addObject("attachmentList", attachmentList);
		
		logger.info("doc : "+doc);
		
		return mav;
	}
	
	public HashMap<String, Object> docWithdraw(String docId) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		// 회수기능을 위해 order_rank가 0인 결재자의 읽음 여부를 withdrawChk라는 이름으로 가져온다.
		// 최초 결재자의 읽음 여부 체크
		String firstReadChk = dao.getFirstReadChk(docId);
		
		if(firstReadChk.equals("1")) {
			// 첫번째 결재자가 읽었을 때
			
			String msg = "첫번째 결재자가 읽은 문서는 회수가 불가능합니다.";
			map.put("msg", msg);
			
		}else {
			// 첫번째 결재자가 읽지 않았을 때 테이블 결재선 삭제, 문서 도장라인 삭제한다.
			HashMap<String, String> docMap = new HashMap<String, String>();
			docMap.put("id", docId);
			
			// 테이블 결재선부터 삭제한다.
			int deleteRow = dao.docStatusDelete(docId);
			
			if(deleteRow>0) {
				
				// 해당 문서를 불러온다.
				DocDTO docDTO = dao.getWritedDoc(docId);
				logger.info("doc content : "+docDTO.getContent());
				
				String oriContent = docDTO.getContent();
				
				// 결재선 도장 라인 잘라서 가져온다.
				String oriLine = oriContent.substring(oriContent.indexOf("<div class=\"flex-container\" style=\"display: flex;\">"), oriContent.indexOf("<p style=\"text-align: center; \">"));
				logger.info("oriLine : "+oriLine);
				
				// 기본값 도장 라인으로 대체한다.
				String newLine = 
						"<div class=\"flex-container\" style=\"display: flex;\">\r\n" + 
						"<div style=\"width:100px; float:left;\">\r\n" + 
						"<div class=\"approvalName \" style=\"width:100px; height:25px; border:1px solid black; font-size: 16px; text-align : center; background-color:lightgray;\">기안</div>\r\n" + 
						"<div class=\"approvalSign \" style=\"width:100px; height:75px; border:1px solid black; font-size: 16px; color: rgb(255, 0, 0); font-style: italic; text-align : center;\">(기안 서명)</div>\r\n" + 
						"<div class=\"approvalDate \" style=\"width:100px; height:25px; border:1px solid black; font-size: 16px; color: rgb(255, 0, 0); font-style: italic; text-align : center;\">(결재일)</div>\r\n" + 
						"</div>\r\n" + 
						"</div>";
				
				String lineWritedContent = docFormUpdate(oriContent, oriLine, newLine);
				
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String createDate = sdf.format(docDTO.getCreate_at());
				
				String dateInitializedContent = docFormUpdate(lineWritedContent, "<span id=\"docFormCreateDate\" style=\"font-size: 16px; text-align: left;\">"+createDate, "<span id=\"docFormCreateDate\" style=\"font-size: 16px; text-align: left; font-style: italic; color: rgb(255, 0, 0)\">(기안일자 자동 입력)");
				
				docMap.put("afterContent", dateInitializedContent);
				docMap.put("status", "2");
				
				int updateRow = dao.docUpdate(docMap);
				
				if(updateRow>0) {
					String msg = updateRow+"개의 문서가 정상적으로 회수되었습니다. 임시저장함으로 이동합니다.";
					map.put("msg", msg);
					map.put("updateRow", updateRow);
				}
				
			}

		}
		
		return map;
	}

	public ModelAndView requestDocWaitList(HttpSession session) {
		
		ModelAndView mav = new ModelAndView("/doc/requestDocWaitList");
		
		String loginId = (String) session.getAttribute("id");
		
		ArrayList<HashMap<String, String>> requestDocWaitList = dao.requestDocWaitList(loginId);
		mav.addObject("list", requestDocWaitList);
		
		return mav;
	}

	public ModelAndView requestDocWaitDetail(String docId, String type, HttpSession session) {
		
		ModelAndView mav = new ModelAndView("/doc/requestDocWaitDetail");
		
		String loginId = (String) session.getAttribute("id");
		
		// 진입했을 때 읽음표시 업데이트
		dao.readCheckUpdate(docId, loginId);
		
		// 진입했을 때 알림을 통해서 온 거면(type="alarm") notice 테이블에서 status를 1로 바꿈
		if(type.equals("alarm")) {
			dao.changeNoticeStatus(loginId, "전자결재", docId);
		}
		// 진입했을 때 읽은날짜 업데이트 - 처음 읽었을 때 한 번만 업데이트 되어야 함.
		long currentTimeMillis = System.currentTimeMillis();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
		String currentTime = sdf.format(new Date(currentTimeMillis));
		
		dao.readTimeUpdate(docId, loginId, currentTime);
		
		// 문서의 정보 불러오기
		HashMap<String, String> docMap = dao.requestDocDetail(docId);
		mav.addObject("doc", docMap);
		
		// 문서의 결재 정보를 불러오기
		ArrayList<HashMap<String, String>> docStatusList = dao.getDocStatusList(docId);
		mav.addObject("docStatusList", docStatusList);
		
		// 문서의 첨부파일 불러오기
		ArrayList<AttachmentDTO> attachmentList = dao.getAttachmentList(docId);
		mav.addObject("attachmentList", attachmentList);
		
		return mav;
	}

	public ModelAndView requestDocApproval(HashMap<String, String> params, HttpSession session) {

		ModelAndView mav = new ModelAndView("redirect:/requestDocWaitList.go");
		
		// params에 결재자의 loginId를 넣기
		String loginId = (String) session.getAttribute("id");
		params.put("loginId", loginId);
		
		// 결재자의 모든 정보를 가져오기
		MemberDTO memberInfo = dao.getMemberInfo(loginId);
		
		// params에 결재 시간을 넣기
		long currentTimeMillis = System.currentTimeMillis();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
		String currentTime = sdf.format(new Date(currentTimeMillis));
		params.put("currentTime", currentTime);
		
		// 결재자의 결재 종류 불러오기
		ApprovalDTO approvalDTO = dao.getApprovalDTO(params);
		
		// 문서의 정보 불러오기
		DocDTO docDTO = dao.getWritedDoc(params.get("docId"));
		
		// 결재자의 도장 찍기
		String memberStampBase64;
		String fileName;
		String kianSign;
		if(params.get("chooseApproval").equals("1")) {
			// 결재자가 결재 했을 경우에는 서명이미지를 넣는 작업을 수행한다.
			
			// 서명이미지 파일이 없으면 그냥 멤버 이름을 넣기 때문에 멤버 이름으로 초기화한다.
			kianSign = "<span style=\"width:100px; height:100px; border:1px solid white; font-weight: bold; font-size:20px; text-align:center;\">"+memberInfo.getName()+"</span>";
			
			// 서명이미지 파일의 이름을 DB에서 불러온다.
			fileName = getMemberSignFilePath(memberInfo.getId());
			logger.info("fileName : "+fileName); // 서명이미지가 없으면 null이 출력된다.
			
			if(fileName!=null) { 
				// 서명이미지 파일이 있으면 멤버의 이미지파일을 가져와 base64로 인코딩해서 넣는다.
				try {
					byte[] src = FileUtils.readFileToByteArray(new File(attachmentRoot+"/"+fileName));
					memberStampBase64 = Base64.getEncoder().encodeToString(src);
					kianSign = "<img src=\"data:image/png;base64,"+memberStampBase64+"\" style=\"max-width: 100%;\" />"+"<span style=\"width:100px; height:100px; border:1px solid white; font-size:16px; text-align:center;\">"+memberInfo.getName()+"</span>";
				} catch (IOException e) {
					e.printStackTrace();
				}
				
			}
			
		}else {
			// 결재자가 반려했을 때(2)는 결재선 도장 칸에 반려라는 문구를 넣는다.
			kianSign = "<span style=\"width:100px; height:100px; border:1px solid white; font-weight: bold; font-size:20px; text-align:center;\">"+"반려"+"</span>";
		}
		
		String oriContent = docDTO.getContent();
		
		String oriLine = 
				"<div class=\"approvalSign "+loginId+"\" style=\"width:100px; height:75px; border:1px solid black; font-size: 16px; color: rgb(255, 0, 0); font-style: italic; text-align : center;\">("+approvalDTO.getName()+" 서명)</div>";
		String newLine = 
				"<div class=\"approvalSign "+loginId+"\" style=\"width:100px; height:75px; border:1px solid black; font-size: 16px; text-align : center;\">"+kianSign+"</div>";
		
		String signWritedContent = docFormUpdate(oriContent, oriLine, newLine);
		
		// 결재일자 넣기
		oriLine = "<div class=\"approvalDate "+loginId+"\" style=\"width:100px; height:25px; border:1px solid black; font-size: 16px; color: rgb(255, 0, 0); font-style: italic; text-align : center;\">(결재일)</div>";
		newLine = "<div class=\"approvalDate "+loginId+"\" style=\"width:100px; height:25px; border:1px solid black; font-size: 16px; text-align : center;\">"+currentTime.substring(0, 10)+"</div>";
		
		String dateWritedContent = docFormUpdate(signWritedContent, oriLine, newLine);
		
		dao.docWriteETC(params.get("docId"), dateWritedContent);
		
		// 마지막으로 doc_status 테이블에 update를 한다.
		dao.requestDocApproval(params);	
		
		// 다음 타자에게 결재 알림을 보낸다.
		int nextApprovalMemberRow = dao.getNextApprovalMemberRow(params.get("docId"));
		
		if(nextApprovalMemberRow>0) {
			String nextApprovalMemberId = dao.getNextApprovalMemberId(params.get("docId"));
			logger.info("nextApprovalMemberId : "+nextApprovalMemberId);
			docNotice(docDTO.getMember_id(), nextApprovalMemberId, "전자결재", params.get("docId"));
			
			// docNotice 메서드가 실행될때는 알림을 보내기 위해 아래의 메서드를 실행한다.
			handler.sendAlarm("알림이 왔습니다");
		}

		return mav;
	}

	public ModelAndView objectionDocList(HttpSession session) {

		ModelAndView mav = new ModelAndView("/doc/objectionDocList");
		
		String loginId = (String) session.getAttribute("id");
		
		ArrayList<HashMap<String, String>> objectionDocList = dao.getObjectionDocList(loginId);

		mav.addObject("list", objectionDocList);
		
		return mav;
	}

	public ModelAndView objectionDocDetail(String docId, HttpSession session) {

		ModelAndView mav = new ModelAndView("/doc/objectionDocDetail");
		
		// 문서의 정보 불러오기
		HashMap<String, String> docMap = dao.objectionDocDetail(docId);
		mav.addObject("doc", docMap);
		
		// 문서의 결재 정보를 불러오기
		ArrayList<HashMap<String, String>> docStatusList = dao.getDocStatusList(docId);
		mav.addObject("docStatusList", docStatusList);
		
		// 문서의 첨부파일 불러오기
		ArrayList<AttachmentDTO> attachmentList = dao.getAttachmentList(docId);
		mav.addObject("attachmentList", attachmentList);
		
		return mav;
	}
	
	public ModelAndView objectionDocBlind(String docId, HttpSession session) {

		ModelAndView mav = new ModelAndView("redirect:/objectionDocList.go");
		String loginId = (String) session.getAttribute("id");
		
		int row = dao.objectionDocBlind(docId, loginId);
		logger.info("writed row : "+row);
		
		return mav;
	}

	public HashMap<String, Object> rewriteDoc(HashMap<String, String> params, HttpSession session) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		// prevDocId, subject, content
		
		// 세션에서 기안자 정보 모두 가져오기
		String loginId = (String) session.getAttribute("id");
		MemberDTO memberInfo = dao.getMemberInfo(loginId);
		
		// 이전 문서의 정보를 가져온다.
		DocDTO prevDocDTO = dao.getWritedDoc(params.get("prevDocId"));
		
		// dto 만들어서 받아온 전자정보 문서를 넣는다.
		DocDTO dto = new DocDTO();
		
		dto.setSubject(prevDocDTO.getSubject());
		dto.setDoc_form_id(prevDocDTO.getDoc_form_id());
		dto.setPublic_range(prevDocDTO.getPublic_range());
		
		dto.setStatus(2); // 2 : 임시저장
		
		dto.setMember_id(memberInfo.getId());
		dto.setDept_id(memberInfo.getDept_id());
		
		HashMap<String, String> jobLevelMap = dao.getJobLevelMap(memberInfo.getJob_level_id());
		dto.setJob_level_name(jobLevelMap.get("name"));
		
		String docId = UUID.randomUUID().toString();
		dto.setId(docId); // uuid를 자바에서 생성해서 doc의 PK 값으로 쓴다. // 얘가 문서번호임.
		
		// 임시저장으로 연결되기 위해서는 새 양식에 docId, deptName, name이랑 제목, 내용이 들어가야 한다.
		String defaultContent = dao.getDefaultDocForm(prevDocDTO.getDoc_form_id());
		String defaultDocPart = defaultContent.substring(defaultContent.indexOf("<thead id=\"docFormContent\">")-1);
		
		String memberName = memberInfo.getName();
		
		HashMap<String, String> deptMap = dao.getDeptMap(memberInfo.getDept_id());
		String deptName = deptMap.get("name");
		
		String nameWritedContent = docFormUpdate(defaultContent, "<span id=\"docFormCreateMemberName\" style=\"font-size: 16px; text-align: left; font-style: italic; color: rgb(255, 0, 0)\">(기안자 자동 입력)</span>", "<span id=\"docFormCreateMemberName\" style=\"font-size: 16px; text-align: left;\">"+memberName+"</span>");
		String deptWritedContent = docFormUpdate(nameWritedContent, "<span id=\"docFormCreateDeptName\" style=\"font-size: 16px; text-align: left; font-style: italic; color: rgb(255, 0, 0)\">(소속 자동 입력)</span>", "<span id=\"docFormCreateDeptName\" style=\"font-size: 16px; text-align: left;\">"+deptName+"</span>");
		String subjectWritedContent = docFormUpdate(deptWritedContent, "<span id=\"docFormSubject\" style=\"font-size: 16px; text-align: left;\">제목을 입력하세요.</span>", "<span id=\"docFormSubject\" style=\"font-size: 16px; text-align: left;\">"+prevDocDTO.getSubject()+"</span>");
		String docIdWritedContent = docFormUpdate(subjectWritedContent, "<span id=\"docFormIssuedNumber\" style=\"font-size: 16px; text-align: left; font-style: italic; color: rgb(255, 0, 0);\">(문서번호 자동 입력)", "<span id=\"docFormIssuedNumber\" style=\"font-size: 16px; text-align: left;\">"+docId);
		
		String prevDocContent = params.get("content");
		String prevDocPart = prevDocContent.substring(prevDocContent.indexOf("<thead id=\"docFormContent\">")-1);
		
		String contentWritedContent = docFormUpdate(docIdWritedContent, defaultDocPart, prevDocPart);
		dto.setContent(contentWritedContent);

		int row = dao.docWrite(dto); // 완성된 문서를 데이터베이스에 등록한다.
		logger.info("writed row : "+row);
		
		map.put("docId", docId);
		
		return map;
	}

	public ModelAndView completeDocList(HttpSession session) {
		
		ModelAndView mav = new ModelAndView("/doc/completeDocList");
		String loginId = (String) session.getAttribute("id");
		
		ArrayList<HashMap<String, String>> docList = dao.getCompleteDocList(loginId);
		
		mav.addObject("list", docList);
		
		return mav;
	}

	public ModelAndView completeDocDetail(String docId, HttpSession session) {

		ModelAndView mav = new ModelAndView("/doc/completeDocDetail");
		String loginId = (String) session.getAttribute("id");
		
		// 문서의 정보 불러오기
		HashMap<String, String> docMap = dao.completeDocDetail(docId, loginId);
		mav.addObject("doc", docMap);
		
		// 문서의 결재 정보를 불러오기
		ArrayList<HashMap<String, String>> docStatusList = dao.getDocStatusList(docId);
		mav.addObject("docStatusList", docStatusList);
		
		// 문서의 첨부파일 불러오기
		ArrayList<AttachmentDTO> attachmentList = dao.getAttachmentList(docId);
		mav.addObject("attachmentList", attachmentList);
		
		return mav;
	}

	public ModelAndView registeredDocList(String flag, HttpSession session) {

		ModelAndView mav = new ModelAndView("/doc/registeredDocList");

		// 세션에서 로그인 정보 모두 가져오기
		String loginId = (String) session.getAttribute("id");
		MemberDTO memberInfo = dao.getMemberInfo(loginId);
		
		ArrayList<HashMap<String, String>> deptList = dao.getDeptList();
		mav.addObject("deptList", deptList);
		
		if(flag.equals("default")) {
			// flag = default 첫 진입때는 자신의 부서에 따라서 보여주는 등록문서함을 다르게 한다.
			String deptId = memberInfo.getDept_id();
			mav.addObject("deptId", deptId);
		}else {
			// flag = doc_dept_id 비공개문서를 열람하다가 실패했을때 redirect되는데 이때는 선택문서함 기준으로 보여준다.
			mav.addObject("deptId", flag);
		}
		
		return mav;
	}

	public HashMap<String, Object> registeredDocListCall(HashMap<String, String> params, HttpSession session) {

		HashMap<String, Object> map = new HashMap<String, Object>();
		
		// 세션에서 로그인 id 값을 가져오기
		String loginId = (String) session.getAttribute("id");

		// params에서 값 꺼내오기
		String deptId = params.get("deptId");
		String opt = params.get("opt");
		String text = params.get("text");
		
		logger.info("deptId : "+deptId+"opt : "+opt+"text : "+text);
		
		// 페이징 관련
		int page = Integer.parseInt(params.get("page"));
		int cnt = 10;
		
		int offset = cnt*(page-1);
		
		int total = dao.totalCount(deptId, opt, text);
		int range = total%cnt == 0 ? total/cnt : (total/cnt)+1;
		if(total==0) {
			range = 1;
		}
		
		logger.info("page :"+page);
		logger.info("전체 게시물 수 :"+total);
		logger.info("total%cnt :"+total%cnt);
		logger.info("총 페이지 수 :"+range);
		
		page = page > range ? range : page;
		map.put("currPage", page);
		map.put("pages", range);
		
		ArrayList<HashMap<String, String>> docList = dao.getRegisteredDocList(loginId, deptId, opt, text, cnt, offset);
		map.put("docList", docList);
		
		return map;
	}

	public ModelAndView registeredDocDetail(String docId, HttpSession session, RedirectAttributes ra) {

		ModelAndView mav = new ModelAndView("/doc/registeredDocDetail");
		String loginId = (String) session.getAttribute("id");
		
		// 문서의 정보 불러오기
		HashMap<String, String> docMap = dao.registeredDocDetail(docId);
		mav.addObject("doc", docMap);
		
		// 세션에서 로그인한 사람의 정보 모두 가져오기
		MemberDTO memberInfo = dao.getMemberInfo(loginId);		
		
		// 문서의 결재 정보를 불러오기
		ArrayList<HashMap<String, String>> docStatusList = dao.getDocStatusList(docId);
		mav.addObject("docStatusList", docStatusList);
		
		// 문서의 첨부파일 불러오기
		ArrayList<AttachmentDTO> attachmentList = dao.getAttachmentList(docId);
		mav.addObject("attachmentList", attachmentList);
		
		if(docMap.get("public_range").equals("all")) {
			// 문서의 공개범위가 all 일 때 - 그대로 실행

		}else {
			// 문서의 공개범위가 dept 일 때
			
			if(docMap.get("dept_id").equals(memberInfo.getDept_id())) {
				// 문서의 생산부서와 로그인 멤버의 부서가 같을 때
				
			}else {
				// 문서의 생산부서와 로그인 멤버의 부서가 다를 때
				mav = new ModelAndView("redirect:/registeredDocList.go?flag="+docMap.get("dept_id"));
				ra.addFlashAttribute("msg", "접근 권한이 없습니다.");
			}
			
		}
		
		return mav;
	}

}
