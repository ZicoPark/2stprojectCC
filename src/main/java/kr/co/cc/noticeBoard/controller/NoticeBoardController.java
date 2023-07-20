package kr.co.cc.noticeBoard.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;
import org.springframework.web.socket.WebSocketSession;

import kr.co.cc.alarm.config.WebSocketHandler;
import kr.co.cc.member.dto.MemberDTO;
import kr.co.cc.noticeBoard.dto.NoticeBoardDTO;
import kr.co.cc.noticeBoard.service.NoticeBoardService;

@Controller
public class NoticeBoardController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
   @Autowired NoticeBoardService service;
   
   @Value("${spring.servlet.multipart.location}") private String root;
   
   
   @RequestMapping(value="/noticeBoard.go")
   public ModelAndView noticeBoard(Model model, HttpSession session){
	   logger.info("list");
		ModelAndView mav = new ModelAndView("noticeBoardList") ;
	
			ArrayList<NoticeBoardDTO> list = service.nolist();
			logger.info("list cnt" + list.size());
			mav.addObject("list", list);
			
			String loginId = (String) session.getAttribute("id");
			NoticeBoardDTO loginid = service.logincheck(loginId);
			
	         model.addAttribute("loginId", loginId);
	         model.addAttribute("loginid", loginid);
			
			
			
		return mav;
         
   }
   
   @RequestMapping(value = "/noticeBoardWrite.go")
   public ModelAndView writeForm() {
         
	   return new ModelAndView("noticeBoardWriteForm");
   }
   

   
   @RequestMapping(value = "/noticeBoardWrite.do", method = RequestMethod.POST)
   public String nowrite(MultipartFile file, @RequestParam HashMap<String, String> params, HttpSession session, RedirectAttributes rttr) {
   
     logger.info("params : " + params);
     logger.info("파일 : "+file);
     
    
      return service.nowrite(file, params,session,rttr);
   }
   
   

   @RequestMapping(value="/noticeBoardDetail.do")
   public String nodetail(Model model, @RequestParam String id, @RequestParam String type ,HttpSession session){
      
	   logger.info("type : " + type);
	   
	   if(type.equals("alarm")) {
		   service.readNotice(id, String.valueOf(session.getAttribute("id")));
	   }
	   
	   String loginId = (String) session.getAttribute("id");
	   NoticeBoardDTO loginid = service.logincheck(loginId);
	   
      logger.info("nodetail : " + id);
      
      
      NoticeBoardDTO detailno = service.nodetail(id, "detail");
      String page = "redirect:/noticeBoard.go";
      
      if (detailno != null) {
         
         logger.info("if문 진입");
         ArrayList<String> detailfile = service.noDetailFile(id);
         
         logger.info("detailFile: " + detailfile);
         
         page = "noticeBoardDetail";
         model.addAttribute("detailno", detailno);
         model.addAttribute("detailFile", detailfile);
         model.addAttribute("loginId", loginId);
         model.addAttribute("loginid", loginid);

//         String loginId = (String) session.getAttribute("id");
         logger.info("read: " + loginId);

         // 중복 방지용 변수 초기화
         int row = service.rcount(loginId, id);
         logger.info("row: " + row);

         if (row == 0) {
            // 읽은 직원 insert
            service.getinfo(loginId, id);
         }
         
         // 읽은 사람 목록 가져오기
         ArrayList<NoticeBoardDTO> reader = service.rlist(id);
         logger.info("reader: " + reader);
         model.addAttribute("reader", reader);
      }   
      
      return page;   
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