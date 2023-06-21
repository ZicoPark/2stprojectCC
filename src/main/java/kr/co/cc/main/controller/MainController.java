package kr.co.cc.main.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class MainController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@GetMapping(value="/")
	public String index() {
		return "index";
	}
	
	// 근태 관리 > 
	@GetMapping(value="/workHistoryList.go")
	public String workHistoryList() {
		return "workHistoryList";
	}
	
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
	// < 근태 관리 / 근태 관리 관리자
	
	
	
	
	
	
	
	
	
	@GetMapping(value="/index2.go")
	public String index2() {
		return "index2";
	}
	
	@GetMapping(value="/calender.go")
	public String calenderGo() {
		return "calender";
	}
	

	
	// 000.move 로 요청이 오면 000.jsp 로 이동
	@GetMapping(value="/{page}.move")
	public String pageMove(@PathVariable String page) {
		logger.info(page+".jsp 로 이동");
		return page;
	}
	
	
	
	@GetMapping(value="{root}/{page}.move")
	public String pageMove(@PathVariable String root
			,@PathVariable String page) {
		logger.info(page+".jsp 로 이동");
		return root+"/"+page;
	}
	
	@GetMapping(value="{root}/{sub}/{page}.move")
	public String pageMove(@PathVariable String root
			,@PathVariable String sub
			,@PathVariable String page) {
		logger.info(page+".jsp 로 이동");
		return root+"/"+sub+"/"+page;
	}
	
}