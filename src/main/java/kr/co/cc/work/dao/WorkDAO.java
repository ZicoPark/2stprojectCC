package kr.co.cc.work.dao;




import java.sql.Time;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;

import kr.co.cc.work.dto.WorkDTO;

public interface WorkDAO {

	ArrayList<WorkDTO> workHistoryList(String id);

	int timeGoBefore(String id, String date);

	String findName(String id);
	
	void timeGo(String id, String name);

	void timeEnd(String id, String date, String time);

	int WorkChangeRequestChk(String id, String type);

	void WorkChangeRequest(HashMap<String, String> params);

	ArrayList<WorkDTO> workHistoryReqListGo(String id);

	ArrayList<WorkDTO> workHistoryList_Ad();

	int WorkChangeAdmin(String working_hour_id, String type, int approval);

	int WorkChangeAdminChk(String working_hour_id, String type);

	int workHistoryChange_go(String working_hour_id, Time update_time);

	int workHistoryChange_end(String working_hour_id, Time update_time);

	ArrayList<WorkDTO> workDailyList(LocalDate currentDate);

	ArrayList<WorkDTO> dailyListFind(String formattedDate);

	ArrayList<WorkDTO> weekListFind(String week);

	String dayChk(String week);

	void workWorn(HashMap<String, Object> params);

	int workWornChk(String member_id, String weekRe);

	ArrayList<WorkDTO> workWornList();

	ArrayList<WorkDTO> wornAllList();

	ArrayList<WorkDTO> wornListFindName(String wornFind1, String wornFind2);
	
	ArrayList<WorkDTO> wornListFindId(String wornFind1, String wornFind2);

	void wornDel(String member_id, String week);

	ArrayList<WorkDTO> leave_recode_List(String id);
	
	WorkDTO annual_leave(String id);
	
	ArrayList<WorkDTO> workHolidayList_Ad();
	
	ArrayList<WorkDTO> holidayListFind(String holidayList);
	
	String findId(Object object);

	void annualRegistration(String regist_id, String approval_id, String start_at, String end_at, String use_cnt,
			String reason, String type);

	ArrayList<WorkDTO> annualRegistrationGo();

	void giveAnnualLeave();

	int currentYearChk(int currentYear);

	int findGalId(String galId);

	void giveAnnualLeave_id(String galId, int i);

	int idChk(String galId);

	void annualLeaveApproval(String regist_id, int currentYear, int use_cnt);

	void holidayApproval(String approval, String id);

	String holidayApprovalChk(String id);

	ArrayList<WorkDTO> approvalChange(String approval);

	void workHourChange(String regist_id, String name, String start_at, String end_at);

	ArrayList<WorkDTO> historyListFind(String value, String id);

	ArrayList<WorkDTO> historyChange(String historyChange);

	int adminChk(String id);














}
