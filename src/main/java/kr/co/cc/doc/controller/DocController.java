package kr.co.cc.doc.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.doc.dto.DocFormDTO;
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
	@RequestMapping(value="/docWriteForm.go")
	public ModelAndView docWriteForm() {
		
		return new ModelAndView("docWriteForm");
	}
	
	// 기안문 양식 불러오기
	@RequestMapping(value="/docFormCall.ajax")
	@ResponseBody
	public HashMap<String, Object> docFormCall(){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<DocFormDTO> docFormList = service.docFormCall();
		
		logger.info("docFormList : "+docFormList);
		
		map.put("docFormList", docFormList);
		
		return map;
	}
	
}
