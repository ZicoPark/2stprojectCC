package kr.co.cc.work.controller;


import java.time.format.DateTimeFormatter;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.work.service.WorkService;

@Controller
public class WorkController {
/*	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	//DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("MM-dd");
	//DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
	
	
	
	@Autowired WorkService service;
	
	// 근태 관리 workHistoryList > 
	@GetMapping(value="/workHistoryList.go")
	public ModelAndView workHistoryList(HttpSession session) {
		return service.workHistoryList(session);
	}
	
	@GetMapping(value="/timeGo.do")
	public String timeGo(HttpSession session, Model model) {
		String msg = "이미 출근을 등록하였습니다.";
		//logger.info("dateFormatter"+ dateFormatter);
		//logger.info("timeFormatter"+ timeFormatter);
		
		/*
		String id = "nodada";
		int row = service.timeGoBefore(id, dateFormatter);
		
		if(row==0) {
			//service.timeGo(session);
			msg = "출근이 등록되었습니다.";
		}
				
		model.addAttribute("msg", msg);
		//return "redirect:/workHistoryList.go?id=";
		return "workHistoryList";
	}
	*/
	
	
	
	
	// 연차 관리 workHolidayList > 
	@GetMapping(value="/workHolidayList.go")
	public String workHolidayList() {
		return "workHolidayList";
	}
	
	// 근태 관리 관리자
	@GetMapping(value="/workHistoryList_Ad.go")
	public String workHistoryList_Ad() {
		return "workHistoryList_Ad";
	}
	
	@GetMapping(value="/workHolidayList_Ad.go")
	public String workHolidayList_Ad() {
		return "workHolidayList_Ad";
	}
	
	@GetMapping(value="/workDailyList.go")
	public String workDailyList() {
		return "workDailyList";
	}
	
	@GetMapping(value="/workWeekList.go")
	public String workWeekList() {
		return "workWeekList";
	}
	
	@GetMapping(value="/workWornList.go")
	public String workWornList() {
		return "workWornList";
	}
	

}
