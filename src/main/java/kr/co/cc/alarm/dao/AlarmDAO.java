package kr.co.cc.alarm.dao;

import java.util.ArrayList;

import kr.co.cc.alarm.dto.AlarmDTO;


public interface AlarmDAO {

	int alarmCount(String receive_id);

	ArrayList<AlarmDTO> alarmList(String loginId);

}
