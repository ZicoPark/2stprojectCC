package kr.co.cc.alarm.service;

import java.util.ArrayList;
import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.cc.alarm.dao.AlarmDAO;
import kr.co.cc.alarm.dto.AlarmDTO;

@Service
@MapperScan(value= {"kr.co.cc.alarm.dao"})
public class AlarmService {
	
	@Autowired AlarmDAO dao;
	
	Logger logger = LoggerFactory.getLogger(getClass());

	public int alarmCount(String receive_id) {
		return dao.alarmCount(receive_id);
	}

	public ArrayList<AlarmDTO> alarmList(String loginId) {
		return dao.alarmList(loginId);
	}


}
