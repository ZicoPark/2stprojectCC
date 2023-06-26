package kr.co.cc.noticeBoard.controller;


import java.io.IOException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import kr.co.cc.noticeBoard.dto.NoticeBoardDTO;
import kr.co.cc.noticeBoard.service.NoticeBoardService;

@RestController
public class NoticeBoardController {

   @Autowired NoticeBoardService service;
   @Value("${spring.servlet.multipart.location}") private String root;
   
   Logger logger = LoggerFactory.getLogger(getClass());
   
//   @RequestMapping(value="/noticeBoardList.go")
//   public String noticeBoardList(){
//      return "noticeBoardList";
//   
//   }
   
   
   @RequestMapping(value="/noticeBoard.go", method= {RequestMethod.GET, RequestMethod.POST})
   public ModelAndView list(){
      
      logger.info("list");
      ModelAndView mav = new ModelAndView("noticeBoardList") ;
   
         ArrayList<NoticeBoardDTO> list = service.list();
         logger.info("list cnt" + list.size());
         mav.addObject("list", list);
         
      return mav;
         
   }
   
   @RequestMapping(value = "/noticeBoardWrite.go")
   public ModelAndView writeForm() {
         
         ModelAndView mav = new ModelAndView("noticeBoardWriteForm") ;
         logger.info("write page 이동");
      return mav;
   }
   
   @RequestMapping(value = "/noticeBoardWrite.do", method = RequestMethod.POST)
   public ModelAndView write(MultipartFile uploadFile, @RequestParam HashMap<String, String> params, HttpSession session) {
   
	  logger.info("params : " + params);
	  logger.info("파일 : "+uploadFile);
      ModelAndView mav = new ModelAndView(new RedirectView("noticeBoard.go"));
      
      service.write(uploadFile, params, session);
      
      return mav;
   }
   
   @RequestMapping(value="/noticeBoardDetail.do")
   public ModelAndView detail(@RequestParam String id, HttpSession session){
      
      logger.info("detail : "+id);
      
      ModelAndView mav = new ModelAndView("noticeBoardDetail") ;
                  
         NoticeBoardDTO dto = service.detail(id);      
         logger.info("dto :" + dto);

            mav.addObject("dto", dto);
            
      return mav;
   }   
   
	@RequestMapping(value="/noticeBoardDel.do", method=RequestMethod.GET)
	public ModelAndView del(@RequestParam String id) {
		
		ModelAndView mav = new ModelAndView("noticeBoard") ;

			logger.info("delete id : "+id);			
			
			if(service.del(id) > 0) {
			mav.setView(new RedirectView("noticeBoard.go"));
		}		

		return mav;
	}
   
	

	
      
}