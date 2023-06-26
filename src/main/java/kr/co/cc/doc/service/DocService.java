package kr.co.cc.doc.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.doc.dao.DocDAO;
import kr.co.cc.doc.dto.ApprovalDTO;
import kr.co.cc.doc.dto.DocDTO;
import kr.co.cc.doc.dto.DocFormDTO;
import kr.co.cc.doc.dto.MemberDTO;

@Service
@MapperScan(value={"kr.co.cc.doc.dao"})
public class DocService {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	@Value("${spring.servlet.multipart.location}") private String attachmentRoot;
	
	private final DocDAO dao;
	
	public DocService(DocDAO dao){
		this.dao = dao;
	}

	public ModelAndView docWriteForm(HttpSession session) {
		ModelAndView mav = new ModelAndView("docWriteForm");
		
		// 결재 종류 불러오기
		ArrayList<ApprovalDTO> approvalKindList = dao.approvalKindCall();
		// 기안은 제외(기안자가 나 자신이니까)
		approvalKindList.remove(0);
		mav.addObject("approvalKindList", approvalKindList);
		
		// 결재자 선택하기 위해 직원 리스트 불러오기
		ArrayList<MemberDTO> memberList = dao.memberListCall();
		mav.addObject("memberList", memberList);
		
		// 기안문 양식 불러오기
		ArrayList<DocFormDTO> oriDocFormList = dao.docFormCall();
		
		// 기안문 양식에 세션 아이디의 이름과 부서 붙이기
		String loginId = (String) session.getAttribute("loginId");
		MemberDTO memberInfo = dao.getMemberInfo(loginId);
		
		String name = memberInfo.getName();
		String deptName = memberInfo.getDeptName();

		ArrayList<DocFormDTO> newDocFormList = new ArrayList<DocFormDTO>();
		String oriDocForm;
		String newDocForm_name;
		String newDocForm_deptName;
		
		for (DocFormDTO docForm : oriDocFormList) {
			oriDocForm = docForm.getContent();
			newDocForm_name = docFormUpdate(oriDocForm, "(기안자 자동 입력)", name);
			newDocForm_deptName = docFormUpdate(newDocForm_name, "(소속 자동 입력)", deptName);
			docForm.setContent(newDocForm_deptName);
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
		dto.setDocFormId(Integer.parseInt(params.get("docFormId"))); // 기안문서 양식 id
		
		// 세션에서 기안자 정보 모두 가져오기
		String loginId = (String) session.getAttribute("loginId");
		MemberDTO memberInfo = dao.getMemberInfo(loginId);
		
		dto.setMemberId(memberInfo.getId());
		dto.setDeptName(memberInfo.getDeptName());
		dto.setJobName(memberInfo.getJobName());
		
		dto.setPublicRange(params.get("publicRange"));
		
		logger.info("params : "+params);
		
		// 상태가 1 : 정상결재요청 이라면?
		if(status==1) {
			
			// 결재선을 확인하여 도장찍는 위치에 칸을 렌더링하자
			String oriDocForm = dto.getContent(); // 작성이 끝난 기안문 양식을 저장한다.
			String lineDocForm;
			String kianSignDocForm;
			String approvalId;
			String approvalName;
			String approvalMemberId;
			
			String oriLine = 
					"<div class=\"flex-container\" style=\"display: flex;\">\r\n" + 
					"<div style=\"width:100px float:left;\">\r\n" + 
					"<div style=\"width:100px; height:25px; border:1px solid black; font-size: 16px; text-align : center; background-color:lightgray;\">기안</div>\r\n" + 
					"<div style=\"width:100px; height:100px; border:1px solid black; font-size: 16px; color: rgb(255, 0, 0); font-style: italic; text-align : center;\">(기안 서명)</div>\r\n" + 
					"</div>";
			String newLine = oriLine;
			
				for(int i = 0;i<approvalList.size();i++) { // 화면 상 윗 결재선부터 풀 예정
					
					approvalId = approvalList.get(i)[0];
					approvalName = dao.getApprovalName(approvalId); // 결재종류의 이름 가져오기
					approvalMemberId = approvalList.get(i)[1];
					newLine += 
							"<div style=\"width:100px float:left;\">\r\n" + 
							"<div style=\"width:100px; height:25px; border:1px solid black; font-size: 16px; text-align : center; background-color:lightgray;\">"+approvalName+"</div>\r\n" + 
							"<div style=\"width:100px; height:100px; border:1px solid black; font-size: 16px; color: rgb(255, 0, 0); font-style: italic; text-align : center;\" id=\""+approvalMemberId+"\">("+approvalName+" 서명)</div>\r\n" + 
							"</div>";

				}
			
				lineDocForm = docFormUpdate(oriDocForm, oriLine, newLine);
				
				// 결재선 라인을 렌더링 한 후, 우선 기안자의 도장 이미지를 가져온다.
				String memberStampBase64;
				String fileName = getMemberSignFilePath(memberInfo.getId());
				String kianSign = memberInfo.getName(); // 서명이미지 파일이 없으면 그냥 멤버 이름을 넣기 때문에 멤버 이름으로 초기화한다.
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
				
				kianSignDocForm = docFormUpdate(lineDocForm, "(기안 서명)", kianSign);
				
				dto.setContent(kianSignDocForm);
				
		}
		
		int row = dao.docWrite(dto); // 완성된 문서를 데이터베이스에 등록한다.
		logger.info("inserted doc row : "+row);
		
		int id = dto.getId(); // 문서번호
		
		if(row==1) {// 업로드된 doc이 1이라면
						
			for (MultipartFile file : attachment) {
				
				logger.info("업로드할 file 있나요? :"+!file.isEmpty());
				
				if(!file.isEmpty()) {
					attachmentSave(id, file, "전자문서첨부파일");
				}
				
				try { // 쓰레드 0.001초 지연으로 중복파일명 막자
					Thread.sleep(1);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				
			}
			
		}
		
		// status에 따라서 문서번호(1, 2)와 기안일자(1)를 업데이트한다.
		DocDTO writedContentDTO = dao.getWritedDOC(id);
		String oriWritedContent = writedContentDTO.getContent();
		String idWritedContent = docFormUpdate(oriWritedContent, "(문서번호 자동 입력)", Integer.toString(id));
		
		// 상태가 1 : 정상결재요청, 2 : 임시저장이면 이동페이지를 다르게 조정해서 보낸다.
		ModelAndView mav = new ModelAndView();
		if(status==1) {
			// 결재요청함으로 보낸다.
			mav.setViewName("docApprovalWaitList");
			
			// 정상결재요청 시에는 결재선을 저장한다.
			HashMap<String, Object> docStatusMap = new HashMap<String, Object>();
			
			String approvalId;
			String approvalMemberId;
			MemberDTO approvalMemberInfo;
			int orderRank = 0; // 결재순서는 0부터 시작
			int approval = 0; // 0 : 미결재, 1 : 결재, 2 : 반려
			int readChk = 0; // 0 안읽음, 1 : 읽음
			
				for(int i = 0;i<approvalList.size();i++) {
					
					approvalId = approvalList.get(i)[0];
					approvalMemberId = approvalList.get(i)[1];
					approvalMemberInfo = dao.getMemberInfo(approvalMemberId);
					
					docStatusMap.put("id", id);
					docStatusMap.put("member_id", approvalMemberId);
					docStatusMap.put("job_name", approvalMemberInfo.getJobName());
					docStatusMap.put("dept_name", approvalMemberInfo.getDeptName());
					docStatusMap.put("approval_code", approvalId);
					docStatusMap.put("order_rank", orderRank);
					docStatusMap.put("approval", approval);
					docStatusMap.put("read_chk", readChk);
					
					dao.approvalWrite(docStatusMap);
					
					if(orderRank==0) { // 지금 결재요청한 문서의 첫 결재자가 0순위라면 알림 테이블에 등록하자.
						docNotice(memberInfo.getId(), approvalMemberId, "전자결재", 0, id);
					}
					
					orderRank++; // 0순위를 저장 후 결재순위가 1씩 증가함.
				}
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			String createDate = sdf.format(writedContentDTO.getCreateDate());
			String dateWritedContent = docFormUpdate(idWritedContent, "(기안일자 자동 입력)", createDate);
				
			dao.docWriteETC(id, dateWritedContent);
			
		}else {
			// 임시저장함으로 보낸다.
			mav.setViewName("redirect:/tempDocList.go");
			
			// 임시저장 시에는 결재선은 저장하지 않는다.
			// 임시저장 시에는 결재선 렌더링 하지 않음.
			// 임시저장 시에는 도장 안넣음.
			
			dao.docWriteETC(id, idWritedContent);
			
		}
		
		return mav;
	}

	public void docNotice(String sendId, String receiveId, String type, int status, int identifyValue) {
		// 순서대로 보내는 아이디, 받는 아이디, 알림유형, 확인상태(0), 구분번호
		
		dao.docNotice(sendId, receiveId, type, status, identifyValue);
	}

	public void attachmentSave(int id, MultipartFile file, String cls) {

		String oriFileName = file.getOriginalFilename();
		String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
		String newFileName = System.currentTimeMillis() + ext;
		logger.info("파일 업로드 : "+oriFileName+"=>"+newFileName+"으로 변경될 예정");
		
		try {
			byte[] bytes = file.getBytes();
			Path path = Paths.get(attachmentRoot+"/"+newFileName);
			Files.write(path, bytes);
			logger.info(newFileName+" upload 디렉토리에 저장 완료 !");
			
			dao.attachmentSave(oriFileName, newFileName, cls, id);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	public String getMemberSignFilePath(String memberId) {
		
		String fileName = dao.getMemberSignFilePath(memberId);
		
		return fileName;
	}

	public ModelAndView tempDocList(HttpSession session) {
		
		ModelAndView mav = new ModelAndView("tempDocList");
		
		int status = 2; // 1: 정상결재요청 2: 임시저장
		String loginId = (String) session.getAttribute("loginId");
		
		ArrayList<DocDTO> list = dao.tempDocList(loginId, status);
		
		mav.addObject("list", list);
		
		return mav;
	}

	public ModelAndView tempDocDetail(String id) {

		ModelAndView mav = new ModelAndView("tempDocDetail");
		DocDTO dto = dao.tempDocDetail(id);
		
		mav.addObject("dto", dto);
		
		return mav;
	}


}
