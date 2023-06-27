package kr.co.cc.doc.controller;

import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

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

		ArrayList<String[]> approvalList = new ArrayList<String[]>();
		// 결재선 정렬 로직 // HashMap을 쓰면 뒤죽박죽 되어서 List에 String 2개짜리 배열 이용함.
		for(int i=0;i<approvalVariable.length;i++) {
			
			String[] approvalStr = new String[2];
			
			approvalStr[0] = approvalVariable[i];
			approvalStr[1] = approvalPerson[i];
			approvalList.add(approvalStr);
			logger.info("list0 :"+approvalList.get(i)[0]);
			logger.info("list1 :"+approvalList.get(i)[1]);
			
		}
		
		return service.docWrite(params, approvalList, attachment, session);
	}
	
	@RequestMapping(value="/tempDocList.go")
	public ModelAndView tempDocList(HttpSession session) {
		
		return service.tempDocList(session);
	}
	
	@RequestMapping(value="/tempDocUpdateForm.go")
	public ModelAndView tempDocUpdateForm(@RequestParam String id) {
		
		return service.tempDocUpdateForm(id);
	}
	
	@RequestMapping(value="/attachmentDownload.do")
	public ResponseEntity<Resource> attachmentDownload(@RequestParam String oriFileName, @RequestParam String newFileName) {
		
		return service.attachmentDownload(oriFileName, newFileName);
	}
}
