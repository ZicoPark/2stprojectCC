package kr.co.cc.message.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.message.dto.MessageDTO;
import kr.co.cc.message.service.MessageService;

@Controller
public class MessageController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MessageService service;
	
	// 쪽지 작성 페이지 이동
	@RequestMapping(value="/msWrite.go")
	public ModelAndView msWriteForm() {
		
		return new ModelAndView("compose");
	}
	

	
	// 쪽지 상세보기
	@RequestMapping(value="/msdetail.do")
	public ModelAndView msdetail(String id) {
		return service.msdetail(id);
	}
	
	// 보낸 쪽지함 이동
	@RequestMapping(value="/msSendList.go")
	public String msSendList(Model model) {
		logger.info("sendList call");
		ArrayList<MessageDTO> sendList = service.sendList();
		
		model.addAttribute("list", sendList);
		return "msSendList";
	}	
	
	@RequestMapping(value="/search.do", method= {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView search(@RequestParam HashMap<String, String>params) {
		logger.info("search params : "+params);
		
		return service.search(params);
		
	}

	// 받은 쪽지함 이동
	@RequestMapping(value="/msReceiveList.go")
	public String msReceiveList(Model model) {
		logger.info("sendList call");
		ArrayList<MessageDTO> receiveList = service.receiveList();
		
		model.addAttribute("list", receiveList);
		return "msReceiveList";
	}	

	
}
