package kr.co.cc.project.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.cc.project.dto.AttachmentDTO;
import kr.co.cc.project.dao.ProjectDAO;
import kr.co.cc.project.dto.ProjectDTO;

@Service
@MapperScan(value= {"kr.co.cc.project.dao"})
public class ProjectService {

	@Autowired ProjectDAO dao;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	
    public String write(ProjectDTO dto, String id) {
        dto.setMember_id(id);
        logger.info("id"+id);
        int row = dao.ProjectWrite(dto);
        return String.valueOf(dto.getId()); // 새로 생성된 프로젝트의 ID 반환
    }

    public void addContributor(String contributorId, String project_id) {
        dao.addContributor(contributorId, project_id);	
    }
    
	public ArrayList<ProjectDTO> list() {
		
		return dao.ProjectList();
	}

	public ArrayList<ProjectDTO> detail(int id) {
		logger.info("detail for id: {}"+ id);
		return dao.ProjectDetail(id);
	}

	public String insert(MultipartFile video_file, HashMap<String, String> params) {
		String page = "redirect:/projects.go";
		

		
		
		ProjectDTO dto = new ProjectDTO();
		dto.setMember_id(params.get("member_id"));
		dto.setComment_content(params.get("comment_content"));
		dto.setStep(params.get("step"));
		dto.setStatus(params.get("status"));
		dto.setId(params.get("project_idx"));
		int row = dao.commentWrite(dto);
		dao.stateChange(dto);
		page = "redirect:/projectDetail.go?id="+params.get("project_idx");
		

		
		if(!video_file.getOriginalFilename().equals("")) {
			logger.info("파일 업로드 작업");
			// 2-1. 파일을 저장
			fileSave(params, video_file); 			
		}
	/*	
		int id = dto.getId();
		logger.info("insert"+id);		
	*/		
		return page;
		
	}

	private void fileSave(HashMap<String, String> params, MultipartFile file) {
		
		String ori_file_name = file.getOriginalFilename();
		String ext = ori_file_name.substring(ori_file_name.lastIndexOf("."));
		String new_file_name = System.currentTimeMillis() + ext;
		logger.info(ori_file_name + " => " + new_file_name);
		/*
		try {
			byte[] bytes = file.getBytes();// 1-4. 바이트 추출
			// 1-5. 추출한 바이트 저장
			Path path = Paths.get("C:/img/upload/" + new_file_name); // 경로가져오기
			Files.write(path, bytes);
			logger.info(new_file_name + " save OK");
			String idx= params.get("project_idx");
			dao.ProjectFileWrite(idx, ori_file_name, new_file_name);
		} catch (IOException e) {
			e.printStackTrace();
		}
		*/
		
		AttachmentDTO dto = new AttachmentDTO();
		dto.setOri_file_name(ori_file_name);
		dto.setNew_file_name(new_file_name);
		dto.setClassification("프로젝트첨부파일");
		dto.setIdentify_value(params.get("project_idx"));
		
		dao.AttachmentSave(dto);
		
		////////////// 유민아 이거 참고해랏
		String attachmentId = dto.getId();
		logger.info("인서트한 첨부파일의 id : "+attachmentId);
	}

	public ProjectDTO projectDetailUp(int id) {
		return dao.projectDetailUp(id);
	}

	public void projectUpdate(HashMap<String, String> params) {
		int row = dao.projectUpdate(params);
		
	}

	public void ContributorUpdate(int project_id, String contributorId) {
		 dao.updateContributor(project_id, contributorId);	
		
	}

	public void clearContributors(int project_id) {
	    dao.clearContributors(project_id);
	}

	public List<String> getUserIdsByProjectId(String id) {
	    return dao.getUserIdsByProjectId(id);
	}






}
