package kr.co.cc.project.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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
		
		
		// 현재 로그인한 사용자의 아이디 가져오기
	    String loginId = (String) session.getAttribute("id");
	    
	    ArrayList<ProjectDTO> list = service.list();
	    logger.info("list cnt : " + list.size());
	    for (ProjectDTO project : list) {
	        List<String> userIds = service.getUserIdsByProjectId(project.getId());
	        project.setUserIds(userIds);
	    }
	    
	    model.addAttribute("list", list);
	    model.addAttribute("id", loginId);
	    logger.info("loginid : " + loginId);
	    
	    String msg = (String) session.getAttribute("msg");
		if(msg != null) {
			model.addAttribute("msg", msg);
			session.removeAttribute("msg");
		}
	    
	    return "projects";
	}


	
	@RequestMapping(value = "projectDetail.go")
	public String projectList(HttpSession session, Model model, @RequestParam String id) {
		String page = "redirect:/";
		
		if(session.getAttribute("id") != null) {
			   page = "project-detail";
			   model.addAttribute("project_id",id);
		   }
		
		return page;
	}
	
	
	@GetMapping(value="/projectDetail.ajax")
	@ResponseBody
	public HashMap<String, Object> writePage(@RequestParam String id, HttpSession session) {
	    logger.info("detail : " + id);
	    String page = "redirect:/projects.go";
	    
	    HashMap<String, Object> map = new HashMap<String, Object>();
	    
	    ArrayList<ProjectDTO> detailList = service.detail(id);
	    map.put("detailList", detailList);
	    map.put("project_id", id);
	    

	    return map;
	}

	
	@GetMapping(value="/project-add.go")
	public String projectAddGo() {
		return "project-add";
	}
	
	@GetMapping(value="/projectUpdate.go")
	public String projectUpdateGo(Model model, HttpSession session, @RequestParam String id) {
	    ProjectDTO dto = service.projectDetailUp(id);
	    model.addAttribute("projectDetailUp", dto);
	    model.addAttribute("project_id", id);
	    return "projectUpdate";
	}


	@RequestMapping(value = "/projectUpdate.do")
	public String update(Model model, @RequestParam HashMap<String, String> params, HttpSession session) {
	    logger.info("update param:" + params);
	    if (session.getAttribute("id") != null) {
	        // 프로젝트 정보 업데이트
	    	String id = params.get("project_id");
	    	logger.info("idddddd"+id);
	        service.projectUpdate(params);
	        logger.info("params"+params);
	        


	        String memberIdsString = params.get("member_id");

	        if (memberIdsString != null) {
	            String[] memberIds = memberIdsString.split(",");
	            // 새로운 참가자 정보 추가
	            for (String contributorId : memberIds) {
	                service.addContributor(contributorId, id);
	            }
	        }

	        session.setAttribute("msg", "프로젝트가 수정되었습니다.");
	    }
	    return "redirect:/projects.go";
	}


	@GetMapping(value = "/projectDel.do")
	public String projectDel(HttpSession session, @RequestParam String id) {
		logger.info("params : " + id);
		logger.info("del 접근 : ");
		
		String msg = "철회에 실패 했습니다.";
		
		if(session.getAttribute("id") != null) {
			if(service.project_del(id) == 1) { 
			msg = "철회에 성공 했습니다.";				
			}							
		}
		// redirect 시 데이터를 보낼 수 없다.
		// 하지만 session 에 데이터를 넣어 보낼 수 있다.
		session.setAttribute("msg", msg);
		
		return "redirect:/projects.go";
	}


	
	@RequestMapping(value = "/project_add.do", method = RequestMethod.POST)
	public String projectAdd(Model model, @RequestParam HashMap<String, String> params, HttpSession session) {
		logger.info("프로젝트 등록");
	    String msg = "프로젝트 등록";
	    model.addAttribute("msg", msg);

	    String id = (String) session.getAttribute("id");
	    logger.info("loginId"+id);

	    ProjectDTO dto = new ProjectDTO();
	    dto.setName(params.get("name"));
	    dto.setPublic_range(Integer.valueOf(params.get("public_range")));
	    dto.setStart_at(params.get("start_at"));
	    dto.setEnd_at(params.get("end_at"));

	    String projectId = service.write(dto, id);
	    String project_id=dto.getId();
	    logger.info("projectId"+projectId);
	    logger.info("project_id"+project_id);


	    String memberIdsString = params.get("user_id");
	    String[] memberIds = memberIdsString.split(",");
	    for (String contributorId : memberIds) {
	        service.addContributor(contributorId, project_id);

	    }


	    return "redirect:/projects.go";
	}
	
	@GetMapping(value="/projectInsert.go")
	public String projectInsertGo(HttpSession session, Model model,@RequestParam String id) {
		String memberId = (String) session.getAttribute("id");
		
		String user_id = service.getMemberById(memberId);
		model.addAttribute("user_id", user_id);

		model.addAttribute("member_id", memberId);
		logger.info("왜 안될까요?"+id);
		model.addAttribute("project_id",id);
			
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
