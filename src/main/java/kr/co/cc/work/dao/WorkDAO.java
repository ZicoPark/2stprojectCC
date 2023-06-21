package kr.co.cc.work.dao;

import java.util.ArrayList;


import kr.co.cc.work.dto.WorkDTO;

public interface WorkDAO {

	ArrayList<WorkDTO> workHistoryList(String id);

	int timeGoBefore(String id, String date);

	String findName(String id);
	void timeGo(String id, String name);

	void timeEnd(String id, String date, String time);


}
