package kr.co.cc.notice.service;

import java.util.ArrayList;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.cc.notice.dao.NoticeDAO;
import kr.co.cc.notice.dto.NoticeDTO;

@Service
@MapperScan(value= {"kr.co.cc.notice.dao"})
public class NoticeService {
	
	@Autowired NoticeDAO dao;
	Logger logger = LoggerFactory.getLogger(getClass());
	   
	   
	public ArrayList<NoticeDTO> nlist() {
		return dao.nlist();
	}


	public ArrayList<NoticeDTO> nonReadAlarm(String loginId) {
		return dao.nonReadAlarm(loginId);
	}


	public ArrayList<NoticeDTO> readAlarm(String loginId) {
		return dao.readAlarm(loginId);
	}


}
