package kr.co.cc.work.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.work.service.WorkService;

@Controller
public class WorkController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
		
	@Autowired WorkService service;	
	String time;
	String date;
	
	// 근태 관리 workHistoryList > 
	@GetMapping(value="/workHistoryList.go")
	public ModelAndView workHistoryList(HttpSession session) {
		formattedDateTime();
		logger.info(time + date);
		return service.workHistoryList(session);
	}
	
	@GetMapping(value="/timeGo.do")
	public ModelAndView timeGo(HttpSession session, Model model) {
		formattedDateTime();
		String id = (String) session.getAttribute("loginId");
		String msg = "이미 출근을 등록하였습니다.";
		
		int row = service.timeGoBefore(id,date);
		logger.info("timeGoBefore row : " + row);		
		
		if(row==0) {
			service.timeGo(id);
			msg = "출근이 등록되었습니다.";
		}				
		model.addAttribute("msg", msg);		
		return service.workHistoryList(session);
	}
	
	@GetMapping(value="/timeEnd.do")
	public ModelAndView timeEnd(HttpSession session, Model model) {
		
		formattedDateTime();
		String id = (String) session.getAttribute("loginId");
		String msg = "출근이 등록되지 않았습니다.";
		
		int row = service.timeGoBefore(id,date);
		logger.info("timeGoBefore row : " + row);		
		
		if(row==1) {
			service.timeEnd(id,date,time);
			msg = "퇴근이 등록되었습니다.";
		}
		model.addAttribute("msg", msg);
		return service.workHistoryList(session);
	}
	
	
	@GetMapping(value="/WorkChangeRequest.do")
	public ModelAndView WorkChangeRequest(HttpSession session,@RequestParam String id) {
		logger.info(time + date);
		return service.workHistoryList(session);
	}
	
	@PostMapping(value = "/your-controller-url")
    public String handleRequest(@RequestParam("inputData") String inputData) {
        // 입력한 데이터 처리
        System.out.println("Received data: " + inputData);

        // 응답 생성
        String response = "Data received successfully";

        return "";
    }
	
	
	
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
	
	
	public void formattedDateTime() {
		long currentTimeMillis = System.currentTimeMillis();

	    Calendar calendar = Calendar.getInstance();
	    calendar.setTimeInMillis(currentTimeMillis);

	    SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss");
	    String formattedTime = format.format(calendar.getTime());	    
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String formattedDate = dateFormat.format(calendar.getTime());

        logger.info(formattedDate);
        logger.info(formattedTime);
        
        this.time=formattedTime;
        this.date=formattedDate;
	}
	

}
