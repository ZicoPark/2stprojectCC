package kr.co.cc.message.controller;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
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
	
	// 보낸 쪽지함 이동
	@RequestMapping(value="/msSendList.go")
	public String msSendList(Model model) {
		logger.info("sendList call");
		ArrayList<MessageDTO> sendList = service.sendList();
		model.addAttribute("list", sendList);
		return "msSendList";
	}	
	
}
