package kr.co.cc.doc.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

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
	
	public String docFormUpdate(String oriDocForm, String oriString, String newString) {
		
		StringBuffer sb = new StringBuffer(oriDocForm);
		String newDocForm = sb.replace(sb.indexOf(oriString), (sb.indexOf(oriString)+oriString.length()), newString).toString();
		
		return newDocForm;
	}

	public ModelAndView docWrite(HashMap<String, String> params, 
			ArrayList<HashMap<String, String>> approvalList,
			MultipartFile[] attachment, HttpSession session) {

		DocDTO dto = new DocDTO();
		dto.setSubject(params.get("subject"));
		dto.setContent(params.get("content"));
		dto.setStatus(1); // 1 : 정상
		dto.setDocFormId(Integer.parseInt(params.get("docFormId"))); // 기안문서 양식 id
		
		// 세션에서 기안자 정보 모두 가져오기
		String loginId = (String) session.getAttribute("loginId");
		MemberDTO memberInfo = dao.getMemberInfo(loginId);
		
		dto.setMemberId(memberInfo.getId()); // 세션에서 기안자 id 가져와 넣기
		dto.setDeptName(memberInfo.getDeptName());
		dto.setJobName(memberInfo.getJobName());
		
		dto.setPublicRange(params.get("publicRange"));
		
		logger.info("params : "+params);
		
		int id = dao.docWrite(dto);
		logger.info("doc insert idx : "+id);
		
		if(id==1) {// 업로드된 doc이 1이라면
			for (MultipartFile file : attachment) {
				logger.info("업로드할 file 있나요? :"+!file.isEmpty());
				
				attachmentSave(id, file, "전자문서첨부파일");
				
				try {// 쓰레드 0.001초 지연으로 중복파일명 막자
					Thread.sleep(1);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				
			}
		}
		
		return null;
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
			
			dao.attachmentSave(oriFileName, newFileName, id, cls);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
	}

	
}
