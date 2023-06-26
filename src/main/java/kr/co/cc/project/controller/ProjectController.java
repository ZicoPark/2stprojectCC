package kr.co.cc.project.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.co.cc.project.dto.ProjectDTO;
import kr.co.cc.project.service.ProjectService;

@Controller
public class ProjectController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired ProjectService service;

	@GetMapping(value="/projects.go")
	public String projectsGo(Model model, HttpSession session) {
		ArrayList<ProjectDTO> list = service.list();
		logger.info("list cnt : " + list.size());
		model.addAttribute("list", list);
		return "projects";
	}
	
	@GetMapping(value="/projectDetail.go")
	public String writePage(Model model, @RequestParam int id, HttpSession session) {
	    logger.info("detail : " + id);
	    String page = "redirect:/projects.go";

	    ProjectDTO dto = service.detail(id);
	    
	    if (dto != null) {
	        int publicRange = dto.getPublic_range();
	        if (publicRange == 0) {
	            String memberId = (String) session.getAttribute("loginId");
	            if (memberId == null || !memberId.equals(dto.getMember_id())) {
	                // 비공개 프로젝트이고 로그인한 사용자와 프로젝트 소유자가 다를 경우
	                // 접근 권한이 없으므로 다른 페이지로 리다이렉트
	                return page;
	            }
	        }
	        
	        page = "project-detail";
	        model.addAttribute("dto", dto);
	    }

	    return page;
	}

	
	@GetMapping(value="/project-add.go")
	public String projectAddGo() {
		return "project-add";
	}
	

	
	@RequestMapping(value = "/project_add.do", method = RequestMethod.POST)
	public String projectAdd(Model model, @RequestParam HashMap<String, String> params, HttpSession session) {
	    String msg = "프로젝트 등록";
	    model.addAttribute("msg", msg);

	    String memberId = (String) session.getAttribute("loginId");

	    ProjectDTO dto = new ProjectDTO();
	    dto.setName(params.get("name"));
	    dto.setPublic_range(Integer.valueOf(params.get("public_range")));
	    dto.setPriod(params.get("priod"));
	    dto.setDeadlinepriod(params.get("deadlinepriod"));

	    String projectId = service.write(dto, memberId);
	    int project_id=dto.getProject_id();

	    String memberIdsString = params.get("member_id");
	    String[] memberIds = memberIdsString.split(",");
	    for (String contributorId : memberIds) {
	        service.addContributor(project_id, contributorId);
	    }


	    return "redirect:/projects.go";
	}
	
	@GetMapping(value="/projectInsert.go")
	public String projectInsertGo() {
		return "projectInsert";
	}
	
	@RequestMapping(value = "/projectInsert.do", method = RequestMethod.POST)
	public String write(MultipartFile video_file,
			@RequestParam HashMap<String, String> params) {
		logger.info("params : " + params);
		return service.insert(video_file, params);
	}




	
	
	
}
