package kr.co.cc.doc.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.doc.dto.ApprovalDTO;
import kr.co.cc.doc.dto.DocFormDTO;
import kr.co.cc.doc.dto.MemberDTO;
import kr.co.cc.doc.service.DocService;

@Controller
public class DocController {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	// 의존성 생성자 주입
	private final DocService service;
	
	public DocController(DocService service) {
		this.service = service;
	}
	
	// 기안문 작성 폼으로 이동
	@RequestMapping(value="/docWriteForm.do")
	public ModelAndView docWriteForm(HttpSession session) {
		
		return service.docWriteForm(session);
	}
	
	@RequestMapping(value="/docWrite.do")
	public ModelAndView docWrite(MultipartFile[] attachment, HttpSession session,
			@RequestParam String[] approvalVariable, @RequestParam String[] approvalPerson, 
			@RequestParam HashMap<String, String> params) {
		
		HashMap<String, String> map = new HashMap<String, String>();
		ArrayList<HashMap<String, String>> approvalList = new ArrayList<HashMap<String,String>>();
		
		// 결재선 정렬 로직
		for(int i=0;i<approvalVariable.length;i++) {
			map.put(approvalVariable[i], approvalPerson[i]);
			approvalList.add(map);
		}
		
		return service.docWrite(params, approvalList, attachment, session);
	}
	
	
}
