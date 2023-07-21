package kr.co.cc.work.service;




import java.sql.Time;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.Month;
import java.time.temporal.TemporalAdjusters;
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
		String id = (String) session.getAttribute("id");
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
		logger.info("find name : " + name);
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
		String id = (String) session.getAttribute("id");
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
		
		String id = (String) session.getAttribute("id");
		int adminChk = dao.adminChk(id);
		if(adminChk != 1) {
			mav = new ModelAndView("AdminMemberListNotAdmin");
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

	public ModelAndView workDailyList(HttpSession session) {		
		ModelAndView mav = new ModelAndView("workDailyList");
		LocalDate currentDate = LocalDate.now();
		ArrayList<WorkDTO> dto = dao.workDailyList(currentDate);
		mav.addObject("dto",dto);
		
		String id = (String) session.getAttribute("id");
		int adminChk = dao.adminChk(id);
		if(adminChk != 1) {
			mav = new ModelAndView("AdminMemberListNotAdmin");
		}
		return mav;
	}

	public ArrayList<WorkDTO> dailyListFind(String formattedDate) {
		return dao.dailyListFind(formattedDate);
	}
	

	public ModelAndView weekListFind(String week, String msg,HttpSession session) {
		ModelAndView mav = new ModelAndView("workWeekList");		
		String dayChk = dao.dayChk(week);
		
		if(dayChk.equals("Monday")) {
			ArrayList<WorkDTO> dto = dao.weekListFind(week);
			mav.addObject("week", week);
			mav.addObject("dto",dto);			
		} else {
	        LocalDate date = LocalDate.parse(week);
	        LocalDate monday = date.with(TemporalAdjusters.previous(DayOfWeek.MONDAY));
	        String previousWeek = monday.toString();
	        
	        ArrayList<WorkDTO> dto = dao.weekListFind(previousWeek);
	        mav.addObject("week", previousWeek);
	        mav.addObject("dto", dto);    
	    }
		
		String id = (String) session.getAttribute("id");
		int adminChk = dao.adminChk(id);
		if(adminChk != 1) {
			mav = new ModelAndView("AdminMemberListNotAdmin");
		}
		
		
		return mav;
	}
	

	public void workWorn(HashMap<String, Object> params) {
		dao.workWorn(params);
		
	}

	public int workWornChk(String member_id, String weekRe) {
		return dao.workWornChk(member_id,weekRe);
	}
	
	

	public ModelAndView workWornList(HttpSession session) {
		ModelAndView mav = new ModelAndView("workWornList");
		
		ArrayList<WorkDTO> wornList = dao.workWornList();
		if(wornList != null) {
			mav.addObject("wornList", wornList);			
		}
		
		ArrayList<WorkDTO> wornAllList = dao.wornAllList();
		if(wornAllList!=null) {
			mav.addObject("wornAllList", wornAllList);			
		}
		
		String id = (String) session.getAttribute("id");
		int adminChk = dao.adminChk(id);
		if(adminChk != 1) {
			mav = new ModelAndView("AdminMemberListNotAdmin");
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
	
	public String findId(Object object) {
		logger.info("object ? " + object);
		return dao.findId(object);
	}
	

	public ModelAndView workHolidayList(String id) {
		ModelAndView mav = new ModelAndView("workHolidayList");
		
		ArrayList<WorkDTO> leave_recode_List = dao.leave_recode_List(id);
		mav.addObject("leave_recode_List",leave_recode_List);
		
		WorkDTO annual_leave = dao.annual_leave(id);		
		mav.addObject("annual_leave",annual_leave);
		return mav;
	}
	
	public ModelAndView workHolidayList_Ad(String msg, HttpSession session) {
		ModelAndView mav = new ModelAndView("workHolidayList_Ad");
		ArrayList<WorkDTO> dto = dao.workHolidayList_Ad();		
		mav.addObject("dto", dto);
		if(msg != "") {
			mav.addObject("msg",msg);
		}
		String id = (String) session.getAttribute("id");
		int adminChk = dao.adminChk(id);
		if(adminChk != 1) {
			mav = new ModelAndView("AdminMemberListNotAdmin");
		}
		return mav;
	}

	public ModelAndView holidayListFind(String holidayList) {
		ModelAndView mav = new ModelAndView("workHolidayList_Ad");
		ArrayList<WorkDTO> dto = dao.holidayListFind(holidayList);
		mav.addObject("dto",dto);
		return mav;
	}
	
	public ModelAndView historyListFind(String value, HttpSession session) {
		ModelAndView mav = new ModelAndView("workHistoryList");
		String id =  (String) session.getAttribute("id");
		ArrayList<WorkDTO> workList = dao.historyListFind(value, id);
		mav.addObject("workList",workList);
		return mav;
	}
	

	public void annualRegistration(HashMap<String, String> params, HttpSession session) {
		
		String regist_id =  (String) session.getAttribute("id");
		String approval_id = params.get("approval_id");
		String start_at = params.get("year_go")+"-"+params.get("month_go")+"-"+params.get("day_go");
		String end_at = params.get("year_end")+"-"+params.get("month_end")+"-"+params.get("day_end");
		String use_cnt = params.get("use_cnt"); 
		String reason = params.get("reason");
		String type = params.get("type");
		
		dao.annualRegistration(regist_id,approval_id,start_at,end_at,use_cnt,reason,type);		
	}

	public ArrayList<WorkDTO> annualRegistrationGo() {
		return dao.annualRegistrationGo();
	}
	
	public ModelAndView giveAnnualLeave(HttpSession session) {
		int currentYear = LocalDate.now().getYear();
		logger.info("currentYear : " + currentYear);
		int currentYearChk = dao.currentYearChk(currentYear);
		String msg = "올해 연차가 갱신되었습니다 ! (" + currentYear + "년)";
		if(currentYearChk>0) {
			msg = "올해 연차를 갱신할 수 없습니다. 새해 1월1일 이후에 클릭해주세요 ! (현재 : " + currentYear + "년)";
		} else {
			dao.giveAnnualLeave();
		}		
		
		return workHolidayList_Ad(msg, session);
	}

	public ModelAndView giveAnnualLeave_id(String galId, HttpSession session) {
		
		String msg = "아이디를 다시 확인해주세요.";
		int idChk = dao.idChk(galId);
		if(idChk > 0) {
			msg = galId + " 님에게 연차를 부여하였습니다."; 
			int row = dao.findGalId(galId);
			if(row>0) {
				msg = "이미 연차를 가지고 있는 사원입니다. 다시 확인해주세요.";
			} else {
				LocalDate currentDate = LocalDate.now();
				Month currentMonth = currentDate.getMonth();
				int monthValue = currentMonth.getValue();
				dao.giveAnnualLeave_id(galId,12-monthValue);
				msg = galId + " 님에게 연차를 부여하였습니다. (연차 갯수 : 12-"+monthValue+"="+(12-monthValue)+")";
			}
		}
		return workHolidayList_Ad(msg,session);
	}

	public ModelAndView holidayApproval(String regist_id,String approval, String id, int use_cnt, String type, String start_at, String end_at, HttpSession session) {
		
		String msg = "이미 처리한 항목입니다.";
		String haChk = dao.holidayApprovalChk(id);
		
		if(haChk.equals("0")) {
			if(approval.equals("1")) {				
				msg = "연차를 승인하였습니다.";
				// 연차 날짜에 8시간 근무 처리
				String name = dao.findName(regist_id);
				dao.workHourChange(regist_id,name,start_at,end_at);
				//연차 갯수 처리
				if(type.equals("A")) {
					int currentYear = LocalDate.now().getYear();
					dao.annualLeaveApproval(regist_id,currentYear,use_cnt);					
				}
			} else {
				msg = "연차를 반려하였습니다.";
			}
			// 연차 승인/반려 처리
			dao.holidayApproval(approval,id);
		}
		
		return workHolidayList_Ad(msg, session);
	}
	
	
	

	public ArrayList<WorkDTO> approvalChange(String approval) {
		return dao.approvalChange(approval);
	}

	public ArrayList<WorkDTO> historyChange(String historyChange) {
		return dao.historyChange(historyChange);
	}

	




	


}
