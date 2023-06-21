package kr.co.cc.work.service;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.work.dao.WorkDAO;
import kr.co.cc.work.dto.WorkDTO;

@Service
@MapperScan(value= {"kr.co.cc.work.dao"})
public class WorkService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired WorkDAO dao;

	public ModelAndView workHistoryList(HttpSession session) {
		ModelAndView mav = new ModelAndView("workHistoryList");
		String id = (String) session.getAttribute("loginId");
		ArrayList<WorkDTO> workList = dao.workHistoryList(id);
		if(workList != null) {
			mav.addObject("workList",workList);			
		}
		return mav;
	}

	public int timeGoBefore(String id, String date) {
		return dao.timeGoBefore(id,date);
	}

	public void timeGo(String id) {
		String name = dao.findName(id);
		dao.timeGo(id, name);
		
	}

	public void timeEnd(String id, String date, String time) {
		dao.timeEnd(id,date,time);
		
	}

	

}
