package kr.co.cc.calender.service;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.calender.dao.CalenderDAO;
import kr.co.cc.calender.dto.CalenderDTO;

@Service
@MapperScan(value = {"kr.co.cc.calender.dao"})
public class CalenderService {
	
	@Autowired CalenderDAO dao;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	public ModelAndView CalenderList(HttpSession session) {
		ModelAndView mav = new ModelAndView("CalenderList");
		String loginId = (String) session.getAttribute("member_id");
		ArrayList<CalenderDTO> list = dao.CalenderList(loginId);
		mav.addObject("list",list);
		return mav;
	}

	public ModelAndView CalenderListSave(String event) {
		ModelAndView mav = new ModelAndView("CalenderList");
		ArrayList<CalenderDTO> list =dao.CalenderListSave(event);
		mav.addObject("list",list);
		return mav;
	}

}
