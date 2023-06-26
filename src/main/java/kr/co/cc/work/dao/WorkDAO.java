package kr.co.cc.work.dao;

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




}
