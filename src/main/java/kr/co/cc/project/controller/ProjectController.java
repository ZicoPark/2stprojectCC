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
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	@RequestMapping(value = "projectDetail.go")
	public String projectList(HttpSession session, Model model, @RequestParam int id) {
		String page = "redirect:/";
		
		if(session.getAttribute("loginId") != null) {
			   page = "project-detail";
			   model.addAttribute("project_id",id);
		   }
		
		return page;
	}
	
	
	@GetMapping(value="/projectDetail.ajax")
	@ResponseBody
	public HashMap<String, Object> writePage(Model model, @RequestParam int id, HttpSession session) {
	    logger.info("detail : " + id);
	    String page = "redirect:/projects.go";
	    
	    HashMap<String, Object> map = new HashMap<String, Object>();
	    
	    ArrayList<ProjectDTO> detailList = service.detail(id);
	    map.put("detailList", detailList);
	    

	    model.addAttribute("detailList", detailList);
	    
	    model.addAttribute("project_id",id);
	    

	    return map;
	}

	
	@GetMapping(value="/project-add.go")
	public String projectAddGo() {
		return "project-add";
	}
	

	
	@RequestMapping(value = "/project_add.do", method = RequestMethod.POST)
	public String projectAdd(Model model, @RequestParam HashMap<String, String> params, HttpSession session) {
		logger.info("프로젝트 등록");
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
	    logger.info("project_id"+project_id);

	    String memberIdsString = params.get("member_id");
	    String[] memberIds = memberIdsString.split(",");
	    for (String contributorId : memberIds) {
	        service.addContributor(project_id, contributorId);
	    }


	    return "redirect:/projects.go";
	}
	
	@GetMapping(value="/projectInsert.go")
	public String projectInsertGo(HttpSession session, Model model,@RequestParam String idx) {
		String memberId = (String) session.getAttribute("loginId");
		model.addAttribute("member_id", memberId);
		logger.info("왜 안될까요?"+idx);
		model.addAttribute("project_idx",idx);
		
		
		return "projectInsert";
	}
	
	@RequestMapping(value = "/projectInsert.do", method = RequestMethod.POST)
	public String write(MultipartFile video_file,
			@RequestParam HashMap<String, String> params) {
		logger.info("params : " + params);
		logger.info("intsert 접근 : ");
		return service.insert(video_file, params);
	}




	
	
	
}
