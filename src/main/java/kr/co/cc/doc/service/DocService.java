package kr.co.cc.doc.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.doc.dao.DocDAO;
import kr.co.cc.doc.dto.ApprovalDTO;
import kr.co.cc.doc.dto.DocFormDTO;
import kr.co.cc.doc.dto.MemberDTO;

@Service
@MapperScan(value={"kr.co.cc.doc.dao"})
public class DocService {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private final DocDAO dao;
	
	public DocService(DocDAO dao){
		this.dao = dao;
	}


	public ModelAndView docWriteForm() {
		ModelAndView mav = new ModelAndView("docWriteForm");
		
		// 기안문 양식 불러오기
		ArrayList<DocFormDTO> docFormList = docFormCall();
		mav.addObject("docFormList", docFormList);
		
		// 결재 종류 불러오기
		ArrayList<ApprovalDTO> approvalKindList = approvalKindCall();
		// 기안은 제외(기안자가 나 자신이니까)
		approvalKindList.remove(0);
		mav.addObject("approvalKindList", approvalKindList);
		
		// 결재자 선택하기 위해 직원 리스트 불러오기
		ArrayList<MemberDTO> memberList = memberListCall();
		mav.addObject("memberList", memberList);
		
		return mav;
	}
	
	public ArrayList<DocFormDTO> docFormCall() {

		return dao.docFormCall();
	}

	public ArrayList<ApprovalDTO> approvalKindCall() {

		return dao.approvalKindCall();
	}

	public ArrayList<MemberDTO> memberListCall() {
		
		return dao.memberListCall();
	}

	public MemberDTO getMemberInfo(String loginId) {
		
		return dao.getMemberInfo(loginId);
	}

	public void docWrite(HashMap<String, String> params, 
			ArrayList<HashMap<String, String>> approvalList,
			MultipartFile[] attachment) {

		
		
	}

	
}
