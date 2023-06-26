package kr.co.cc.work.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
	
	
	@GetMapping(value="/WorkChangeRequest.go")
	public ModelAndView WorkChangeRequestGo(@RequestParam HashMap<String, String> params) {
		logger.info("WorkChangeRequest go params : {}", params);
		ModelAndView mav = new ModelAndView("workHistoryReq");
		mav.addObject("params",params);
		return mav;
	}
	
	@GetMapping(value="/WorkChangeRequest.do")
	public ModelAndView WorkChangeRequest(@RequestParam HashMap<String, String> params, Model model, HttpSession session) {
		logger.info("WorkChangeRequest do params : {}", params);
		
		ModelAndView mav = new ModelAndView();
		
		String msg = "";
		
		if(params.get("update_time_h").equals("")) {
			msg = "시간을 입력해주세요.";
			mav = WorkChangeRequestGo(params);
		} else if (params.get("update_time_m").equals("")) {
			msg = "시간을 입력해주세요.";
			mav = WorkChangeRequestGo(params);
		} else if (params.get("type").equals("")) {			
			msg = "유형을 선택해주세요.";
			mav = WorkChangeRequestGo(params);
		} else if (params.get("reason").equals("")) {
			msg = "사유를 입력해주세요.";
			mav = WorkChangeRequestGo(params);
		} else {
			int row=service.WorkChangeRequestChk(params.get("id"),params.get("type"));
			if(row>0) {
				msg = "이미 등록한 이력이 있습니다.";
				mav = WorkChangeRequestGo(params);
			} else {
				params.put("update_time", params.get("update_time_h")+":"+params.get("update_time_m")+":00");
				service.WorkChangeRequest(params);
				msg = "수정이 등록 되었습니다.";
				mav = workHistoryReqListGo(session);
			}
		}
		model.addAttribute("msg",msg);
		return mav;
	}
	
	@GetMapping(value="/workHistoryReqList.go")
	public ModelAndView workHistoryReqListGo(HttpSession session) {
		return service.workHistoryReqListGo(session);
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
