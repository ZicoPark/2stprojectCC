package kr.co.cc.noticeBoard.controller;


import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import kr.co.cc.noticeBoard.dto.NoticeBoardDTO;
import kr.co.cc.noticeBoard.service.NoticeBoardService;

@RestController
public class NoticeBoardController {

   @Autowired NoticeBoardService service;
   
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
   public ModelAndView write(@RequestParam HashMap<String, String> params, HttpSession session) {
      logger.info("params : " + params);
      
      ModelAndView mav = new ModelAndView(new RedirectView("noticeBoard.go"));
      
      service.write(params, session);
      
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
	public ModelAndView del(@RequestParam String id, RedirectAttributes rAttr, HttpSession session) {
		
		String loginId = (String) session.getAttribute("loginId");
		ModelAndView mav = new ModelAndView("noticeBoardList") ;
		if(loginId != null) {
			logger.info("delete id : "+id);			

			String msg = "삭제에 실패 했습니다.";
			
			if(service.del(id) > 0) {
				msg = "삭제에 성공 했습니다.";
			}
			mav.setView(new RedirectView("noticeBoardList.do"));
			rAttr.addFlashAttribute("msg",msg);
		}		

		return mav;
	}
	
	
      
}