package kr.co.cc.personal.controller;

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

import kr.co.cc.personal.service.PersonalService;

@Controller
public class PersonalController {

	@Autowired PersonalService service;
	   
    Logger logger = LoggerFactory.getLogger(getClass());
   
      @GetMapping(value="/presonal.go")
      public String personalList() {
         return "personalList";
      }
      
      @RequestMapping(value="/personalWrite.go")
      public String writeForm() {
         logger.info("write page 이동");
         return "personalWriteForm";
      }
      
  	@RequestMapping(value = "/personalWrite.do", method = RequestMethod.POST)
  	public String pwrite(HttpSession session, Model model, @RequestParam HashMap<String, String> params) { 
  		
  		if(session.getAttribute("loginId") != null) {
  			logger.info("write params : {}" , params);
  			String msg = service.pwrite(params); 
  			logger.info("insert row ");
  		}
  		return "redirect:/presonal.go";
  	}
      
//      @RequestMapping(value="/personalwrite.do", method = RequestMethod.POST)
//      public String pwrite( @RequestParam HashMap<String, String> params) {
//         logger.info("params : "+params);
//         return service.pwrite(params);
//      }
}
