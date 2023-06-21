package kr.co.cc.project.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.cc.project.dao.ProjectDAO;
import kr.co.cc.project.dto.ProjectDTO;

@Service
@MapperScan(value= {"kr.co.cc.project.dao"})
public class ProjectService {

	@Autowired ProjectDAO dao;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	public String write(HashMap<String, String> params) {
		ProjectDTO dto = new ProjectDTO();
		dto.setName(params.get("name"));
		dto.setMember_id(params.get("member_id"));
		dto.setPublic_range(Integer.valueOf(params.get("public_range")));
		dto.setPriod(params.get("priod"));
		dto.setDeadlinepriod(params.get("deadlinepriod"));
		
		int row = dao.write(dto);
		logger.info("update row : " + row);
		String page = "redirect:/projects.go";
		return page;
	}

	public ArrayList<ProjectDTO> list() {
		
		return dao.list();
	}

}
