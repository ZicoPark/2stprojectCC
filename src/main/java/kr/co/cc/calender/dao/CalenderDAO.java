package kr.co.cc.calender.dao;

import java.util.ArrayList;

import kr.co.cc.calender.dto.CalenderDTO;

public interface CalenderDAO {

	ArrayList<CalenderDTO> CalenderList(String loginId);

	ArrayList<CalenderDTO> CalenderListSave(String event);

}
