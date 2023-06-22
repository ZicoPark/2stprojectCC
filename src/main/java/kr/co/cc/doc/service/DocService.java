package kr.co.cc.doc.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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
