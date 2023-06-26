package kr.co.cc.project.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.cc.project.dao.ProjectDAO;
import kr.co.cc.project.dto.ProjectDTO;

@Service
@MapperScan(value= {"kr.co.cc.project.dao"})
public class ProjectService {

	@Autowired ProjectDAO dao;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	
    public String write(ProjectDTO dto, String memberId) {
        dto.setMember_id(memberId);
        int row = dao.ProjectWrite(dto);
        return String.valueOf(dto.getProject_id()); // 새로 생성된 프로젝트의 ID 반환
    }

    public void addContributor(int project_id, String memberId) {
        dao.addContributor(project_id, memberId);	
    }
    
	public ArrayList<ProjectDTO> list() {
		
		return dao.ProjectList();
	}

	public ProjectDTO detail(int id) {
		logger.info("detail for id: {}"+ id);
		return dao.ProjectDetail(id);
	}

	public String insert(MultipartFile video_file, HashMap<String, String> params) {
String page = "redirect:/projects.go";
		

		ProjectDTO dto = new ProjectDTO();
		dto.setSubject(params.get("subject"));
		dto.setUser_name(params.get("user_name"));
		dto.setContent(params.get("content"));
		
		int row = dao.ProjectWrite(dto);
		logger.info("update row : " + row);
		
		// 조건 3. 받아온 키는 파라메터 DTO 에서 뺀다.
		int idx = dto.getIdx();		
		logger.info("방금 insert 한 idx : "+idx);
		page = "redirect:/detail.do?idx="+idx;
		
		/*
		// 2. 파일도 업로드 한 경우
		if(!photo.getOriginalFilename().equals("")) {
			logger.info("파일 업로드 작업");
			// 2-1. 파일을 저장
			fileSave(idx, photo); 			
		}
		
		*/		
		return page;
		
	}


}
