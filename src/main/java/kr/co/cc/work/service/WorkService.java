package kr.co.cc.work.service;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.work.dao.WorkDAO;
import kr.co.cc.work.dto.WorkDTO;

@Service
public class WorkService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired WorkDAO dao;

	public ModelAndView workHistoryList(HttpSession session) {
		ModelAndView mav = new ModelAndView("workHistoryList");
		String id = "nodada";
		ArrayList<WorkDTO> workList = dao.workHistoryList(id);
		mav.addObject("workList",workList);
		return mav;
	}

	

}
