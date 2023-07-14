package kr.co.cc.calender.dao;

import java.sql.Timestamp;
import java.util.ArrayList;

import kr.co.cc.calender.dto.CalenderDTO;

public interface CalenderDAO {

	ArrayList<CalenderDTO> CalenderList(String id);

	void CalenderListDrop(String id, String member_id, String title, String content, String color, Timestamp create_at,
			Timestamp start_at, Timestamp end_at);

	void CalenderListDelete(String eventId);

	void CalenderListResize(String id, Timestamp start_at, Timestamp end_at);

	void CalenderListEventDrop(String id, Timestamp start_at, Timestamp end_at);



	



}
