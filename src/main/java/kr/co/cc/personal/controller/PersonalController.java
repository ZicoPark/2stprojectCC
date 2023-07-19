package kr.co.cc.personal.controller;

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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import kr.co.cc.archive.dto.ArchiveDTO;
import kr.co.cc.personal.dto.PersonalDTO;
import kr.co.cc.personal.service.PersonalService;
import kr.co.cc.project.dto.ProjectDTO;

@Controller
public class PersonalController {

	@Autowired PersonalService service;
	   
    Logger logger = LoggerFactory.getLogger(getClass());
   
      @GetMapping(value="/personal.go")
      public String personalList(Model model, HttpSession session) {
    	
    	// 현재 로그인한 사용자의 아이디 가져오기
  	    String loginId = (String) session.getAttribute("id");
  	    
  	    ArrayList<PersonalDTO> list = service.list(loginId);
  	    logger.info("list cnt : " + list.size());
  	    
  	    model.addAttribute("list", list);
  	    model.addAttribute("loginId", loginId);
  	    logger.info("loginid : " + loginId);
  	    
         return "personalList";
      }
      
      @RequestMapping(value="/personalWrite.go")
      public String writeForm() {
         logger.info("write page 이동");
         return "personalWriteForm";
      }
      
  	@RequestMapping(value = "/personalWrite.do", method = RequestMethod.POST)
  	public String pwrite(HttpSession session, Model model, @RequestParam HashMap<String, String> params) { 
  		
  		logger.info("개인 업무 추가");
//	    String msg = "개인 업무 등록";
//	    model.addAttribute("msg", msg);

	    String id = (String) session.getAttribute("id");
	    logger.info("loginId"+id);

	    PersonalDTO dto = new PersonalDTO();
	    dto.setCreate_at("create_at");
	    dto.setTitle(params.get("title"));
	    dto.setStart_at(params.get("start_at"));
	    dto.setEnd_at(params.get("end_at"));

	    String personalId = service.pwrite(dto, id);
	    String personal_id=dto.getId();
	    logger.info("personalId"+personal_id);

  		return "redirect:/personal.go";
  	}
  	
  	
	@RequestMapping(value="/personalUpdate.go")
	public String personalUpdate(@RequestParam String id, Model model) {
        logger.info("update page 이동");
        logger.info("id ? " + id);
        PersonalDTO personal = service.personalUpdate(id);
        model.addAttribute("personal", personal);
        return "personalUpdate";
	}
  	
	@RequestMapping(value="/personalUpdate.do", method = RequestMethod.POST)
	public String update(	@RequestParam HashMap<String, String> params, @RequestParam String id) {
		logger.info("params : "+params);
		return service.update(params);
	}
      
    @RequestMapping(value="/personalDel.do", method=RequestMethod.GET)
    public ModelAndView del(@RequestParam String id) {
       
       ModelAndView mav = new ModelAndView("personal") ;

          logger.info("delete id : "+id);         
          
          if(service.del(id) > 0) {
          mav.setView(new RedirectView("personal.go"));
       }      

       return mav;
    }
}
