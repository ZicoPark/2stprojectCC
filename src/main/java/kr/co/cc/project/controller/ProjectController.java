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
    public String writePage() {

        return "project-detail";  
    }
	
	@GetMapping(value="/project-add.go")
	public String projectAddGo() {
		return "project-add";
	}
	

	
	@RequestMapping(value = "/project_add.do", method = RequestMethod.POST)
	public String ProjectAdd(Model model, @RequestParam HashMap<String, String> params,
			HttpSession session) {
		String msg = "프로젝트 등록";
		logger.info("a" + params);
		model.addAttribute("msg", msg);

		return service.write(params);
	}
	
	
	
}
