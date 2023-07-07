package kr.co.cc.notice.controller;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.co.cc.notice.dto.NoticeDTO;
import kr.co.cc.notice.service.NoticeService;


@Controller
public class NoticeController {

	Logger logger = LoggerFactory.getLogger(getClass());
	   @Autowired NoticeService service;
	   
		@GetMapping(value="/notice.go")
		public String nlist(Model model) {
			
			ArrayList<NoticeDTO> list = service.nlist();
		    model.addAttribute("list", list);
			
			return "noticeList";
		}	
		

}

