package kr.co.cc.personal.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.cc.personal.dao.PersonalDAO;
import kr.co.cc.personal.dto.PersonalDTO;
import kr.co.cc.project.dto.ProjectDTO;

@Service
@MapperScan(value= {"kr.co.cc.personal.dao"})
public class PersonalService {
	
	@Autowired PersonalDAO dao;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	public ArrayList<PersonalDTO> personalList(String id){
		logger.info("서비스도착완료");
		return dao.personalList(id);	
	}

//	public String pwrite(HashMap<String, String> params) {
//		logger.info("서비스 도착");
//		int row = dao.pwrite(params);
//		return "";
//	}

	public ArrayList<PersonalDTO> list(String id) {
		return dao.personalList(id);
	}

	public int del(String id) {
		 return dao.del(id);
	}

	public String pwrite(PersonalDTO dto, String id) {
		 dto.setMember_id(id);
	        logger.info("id"+id);
	        int row = dao.pwrite(dto);
		return "";
	}
	
	public PersonalDTO personalUpdate(String id) {
		return dao.personalUpdate(id);
	}

	public String update(HashMap<String, String> params) {
		
//		int idx = Integer.parseInt(params.get("id"));		
		dao.update(params);// 1. update 실행

		String page ="redirect:/personal.go";
		logger.info("update => "+page);
		
		return page;
	}





}
