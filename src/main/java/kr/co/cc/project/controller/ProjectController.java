package kr.co.cc.project.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ProjectController {

	Logger logger = LoggerFactory.getLogger(getClass());

	@RequestMapping(value = "", method = RequestMethod.GET)
	public String main(Model model) {
			return "projDetail";
	}
	
	@RequestMapping(value="/proj.detail.go")
    public String writePage(HttpSession session, Model model) {
		String page = "projDetail";

        return page;  
    }
	
	@GetMapping(value="/project-add.go")
	public String projectAddGo() {
		return "project-add";
	}
	
	@GetMapping(value="/project-detail.go")
	public String projectDetailGo() {
		return "project-detail";
	}
	
}
