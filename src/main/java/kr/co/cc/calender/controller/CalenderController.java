package kr.co.cc.calender.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.calender.dto.CalenderDTO;
import kr.co.cc.calender.service.CalenderService;

@Controller
public class CalenderController {
	
	@Autowired CalenderService service;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	// 캘린더 리스트
	@RequestMapping(value = "/CalenderList.go")
	public ModelAndView CalenderList() {
		return service.CalenderList();
	}
	
	// 캘린더 저장
	@RequestMapping(value = "/CalenderListSave.go")
	public ModelAndView CalenderListSave(@RequestParam("event") String event) {
		CalenderDTO dto = new CalenderDTO();

		return service.CalenderListSave(event);
	}

}
