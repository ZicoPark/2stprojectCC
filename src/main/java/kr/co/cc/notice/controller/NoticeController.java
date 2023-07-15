package kr.co.cc.notice.controller;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
		
		 @RequestMapping(value="/nonReadAlarm.ajax", method=RequestMethod.POST)
		   @ResponseBody
		   public ArrayList<NoticeDTO> nonReadAlarm(@RequestParam String loginId) {
			   logger.info("nonReadAlarm 통신");
		      return service.nonReadAlarm(loginId);
		   }
		  
		   @RequestMapping(value="/readAlarm.ajax", method=RequestMethod.POST)
		   @ResponseBody
		   public ArrayList<NoticeDTO> readAlarm(@RequestParam String loginId) {
			   logger.info("readAlarm 통신");
		      return service.readAlarm(loginId);
		   }
		

}

