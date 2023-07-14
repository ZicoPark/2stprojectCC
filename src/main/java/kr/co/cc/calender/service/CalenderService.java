package kr.co.cc.calender.service;

import java.sql.Timestamp;
import java.util.ArrayList;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.cc.calender.dao.CalenderDAO;
import kr.co.cc.calender.dto.CalenderDTO;

@Service
@MapperScan(value = {"kr.co.cc.calender.dao"})
public class CalenderService {
	
	@Autowired CalenderDAO dao;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	public ArrayList<CalenderDTO> CalenderList(String id) {
		return dao.CalenderList(id);
	}

	public void CalenderListDrop(String id, String member_id, String title, String content, String color,
			Timestamp create_at, Timestamp start_at, Timestamp end_at) {
		dao.CalenderListDrop(id,member_id,title,content,color,create_at,start_at,end_at);	
	}

	public void CalenderListDelete(String eventId) {
		dao.CalenderListDelete(eventId);
	}

	public void CalenderListResize(String id, Timestamp start_at, Timestamp end_at) {
		dao.CalenderListResize(id,start_at,end_at);
		
	}

	public void CalenderListEventDrop(String id, Timestamp start_at, Timestamp end_at) {
		dao.CalenderListEventDrop(id,start_at,end_at);
	}








}
