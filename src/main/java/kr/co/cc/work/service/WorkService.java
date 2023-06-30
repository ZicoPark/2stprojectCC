package kr.co.cc.work.service;



import java.sql.Time;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.work.dao.WorkDAO;
import kr.co.cc.work.dto.WorkDTO;

@Service
@MapperScan(value= {"kr.co.cc.work.dao"})
public class WorkService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired WorkDAO dao;

	public ModelAndView workHistoryList(HttpSession session) {
		ModelAndView mav = new ModelAndView("workHistoryList");
		String id = (String) session.getAttribute("loginId");
		ArrayList<WorkDTO> workList = dao.workHistoryList(id);
		if(workList != null) {
			mav.addObject("workList",workList);			
		}
		return mav;
	}

	public int timeGoBefore(String id, String date) {
		return dao.timeGoBefore(id,date);
	}

	public void timeGo(String id) {
		String name = dao.findName(id);
		dao.timeGo(id, name);
		
	}

	public void timeEnd(String id, String date, String time) {
		dao.timeEnd(id,date,time);
		
	}

	public int WorkChangeRequestChk(String id, String type) {
		return dao.WorkChangeRequestChk(id,type);
	}

	public void WorkChangeRequest(HashMap<String, String> params) {
		dao.WorkChangeRequest(params);
		
	}

	public ModelAndView workHistoryReqListGo(HttpSession session) {
		String id = (String) session.getAttribute("loginId");
		ArrayList<WorkDTO> dto = dao.workHistoryReqListGo(id);		
		ModelAndView mav = new ModelAndView("workHistoryReqList");
		mav.addObject("dto",dto);
		
		return mav;
	}
	
	public ModelAndView workHistoryList_Ad(HttpSession session, String msg, String flag) {
		ModelAndView mav = new ModelAndView("workHistoryList_Ad");
		ArrayList<WorkDTO> dto = dao.workHistoryList_Ad();
		mav.addObject("dto",dto);
		if(flag.equals("WorkChangeAdmin")) {
			mav.addObject("msg",msg);
		}
		return mav;
	}
	public int WorkChangeAdmin(String working_hour_id, String type, int approval) {
		return dao.WorkChangeAdmin(working_hour_id,type,approval);
		
	}

	public int workHistoryChange_go(String working_hour_id, Time update_time) {
		return dao.workHistoryChange_go(working_hour_id,update_time);
	}

	public int workHistoryChange_end(String working_hour_id, Time update_time) {
		return dao.workHistoryChange_end(working_hour_id,update_time);
	}

	public int WorkChangeAdminChk(String working_hour_id, String type) {
		return dao.WorkChangeAdminChk(working_hour_id,type);
	}
	
	// 완료

	public ModelAndView workDailyList() {		
		ModelAndView mav = new ModelAndView("workDailyList");
		ArrayList<WorkDTO> dto = dao.workDailyList();
		mav.addObject("dto",dto);
		return mav;
	}

	public ArrayList<WorkDTO> dailyListFind(String formattedDate) {
		return dao.dailyListFind(formattedDate);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	

	public ModelAndView weekListFind(String week, String msg) {
		ModelAndView mav = new ModelAndView("workWeekList");		
		String dayChk = dao.dayChk(week);
		
		if(dayChk.equals("Monday")) {
			ArrayList<WorkDTO> dto = dao.weekListFind(week);
			mav.addObject("week", week);
			mav.addObject("dto",dto);			
		} else {
			mav.addObject("msg","검색을 원하시는 주의 월요일을 선택해주세요.");
		}
		
		if(!msg.equals("")) {
			mav.addObject("msg",msg);
		}
		
		return mav;
	}

	public void workWorn(HashMap<String, Object> params) {
		dao.workWorn(params);
		
	}

	public int workWornChk(String member_id, String weekRe) {
		return dao.workWornChk(member_id,weekRe);
	}

	public ModelAndView workWornList() {
		ModelAndView mav = new ModelAndView("workWornList");
		
		ArrayList<WorkDTO> wornList = dao.workWornList();
		if(wornList != null) {
			mav.addObject("wornList", wornList);			
		}
		
		ArrayList<WorkDTO> wornAllList = dao.wornAllList();
		if(wornAllList!=null) {
			mav.addObject("wornAllList", wornAllList);			
		}
		return mav;
	}

	public ArrayList<WorkDTO> wornListFindName(String wornFind1, String wornFind2) {
		return dao.wornListFindName(wornFind1, wornFind2);
	}

	public ArrayList<WorkDTO> wornListFindId(String wornFind1, String wornFind2) {
		return dao.wornListFindId(wornFind1, wornFind2);
	}

	public void wornDel(String member_id, String week) {
		dao.wornDel(member_id,week);
		
	}

	public ArrayList<WorkDTO> wornAllList2() {
		return dao.wornAllList();
	}

	public ModelAndView workHolidayList(String id) {
		ModelAndView mav = new ModelAndView("workHolidayList");
		
		ArrayList<WorkDTO> leave_recode_List = dao.leave_recode_List(id);
		mav.addObject("leave_recode_List",leave_recode_List);
		
		WorkDTO annual_leave = dao.annual_leave(id);		
		mav.addObject("annual_leave",annual_leave);
		return mav;
	}

	public void annualRegistration(HashMap<String, String> params, HttpSession session) {
		
		String regist_id =  (String) session.getAttribute("loginId");
		String approval_id = params.get("approval_id");
		String start_date = params.get("year_go")+"-"+params.get("month_go")+"-"+params.get("day_go");
		String end_date = params.get("year_end")+"-"+params.get("month_end")+"-"+params.get("day_end");
		String use_cnt = params.get("use_cnt"); 
		String reason = params.get("reason");
		String type = params.get("type");
		
		dao.annualRegistration(regist_id,approval_id,start_date,end_date,use_cnt,reason,type);		
	}

	public ArrayList<WorkDTO> annualRegistrationGo() {
		return dao.annualRegistrationGo();
	}

	public ModelAndView workHolidayList_Ad() {
		ModelAndView mav = new ModelAndView("workHolidayList_Ad");
		ArrayList<WorkDTO> dto = dao.workHolidayList_Ad();
		
		mav.addObject("dto", dto);		
		
		return mav;
	}

	public ModelAndView holidayListFind(String holidayList) {
		ModelAndView mav = new ModelAndView("workHolidayList_Ad");
		ArrayList<WorkDTO> dto = dao.holidayListFind(holidayList);
		mav.addObject("dto",dto);
		
		return mav;
	}







	

}
