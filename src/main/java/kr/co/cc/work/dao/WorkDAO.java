package kr.co.cc.work.dao;

import java.sql.Time;
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

	int WorkChangeAdmin(int id, String type, int approval);

	int WorkChangeAdminChk(int id, String type);

	int workHistoryChange_go(int id, Time update_time);

	int workHistoryChange_end(int id, Time update_time);





}
