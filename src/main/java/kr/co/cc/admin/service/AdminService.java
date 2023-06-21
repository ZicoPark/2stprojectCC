package kr.co.cc.admin.service;

import java.util.ArrayList;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.admin.dao.AdminDAO;
import kr.co.cc.admin.dto.AdminDTO;

@Service
@MapperScan(value = {"kr.co.cc.admin.dao"})
public class AdminService {

	@Autowired AdminDAO dao;
	Logger logger = LoggerFactory.getLogger(getClass());
	
		public ModelAndView MemberList() {
			ModelAndView mav = new ModelAndView("AdminMemberList");
			ArrayList<AdminDTO> list = dao.MemberList();
			mav.addObject("list",list);
			return mav;
		}
	
}
