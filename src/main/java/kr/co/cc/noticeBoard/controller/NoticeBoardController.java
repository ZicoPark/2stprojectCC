package kr.co.cc.noticeBoard.controller;


import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.noticeBoard.dto.NoticeBoardDTO;
import kr.co.cc.noticeBoard.service.NoticeBoardService;

@RestController
public class NoticeBoardController {

	@Autowired NoticeBoardService service;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
//	@RequestMapping(value="/noticeBoardList.go")
//	public String noticeBoardList(){
//		return "noticeBoardList";
//	
//	}
	
	
	@RequestMapping(value="/noticeBoard.go", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView list(){
		
		logger.info("list");
		ModelAndView mav = new ModelAndView("noticeBoardList") ;
	
			ArrayList<NoticeBoardDTO> list = service.list();
			logger.info("list cnt" + list.size());
			mav.addObject("list", list);
			
		return mav;
			
	}
		
}
