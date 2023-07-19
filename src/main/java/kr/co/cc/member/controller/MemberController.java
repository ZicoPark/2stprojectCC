package kr.co.cc.member.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.mail.MailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import kr.co.cc.main.dto.MainDTO;

import kr.co.cc.member.dao.MemberDAO;
import kr.co.cc.member.dto.MemberDTO;
import kr.co.cc.member.service.MemberService;
import kr.co.cc.member.service.SendEmailService;

@Controller
public class MemberController {
	
	@Autowired MemberService memberservice;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Value("${spring.servlet.multipart.location}") private String attachmentRoot;
	
	@RequestMapping(value="/", method = RequestMethod.GET)
	public String home(Model model) {
		return "Login";
	}

	@RequestMapping(value="/join.go", method = RequestMethod.GET)
	public String joinForm(Model model) {
		return "JoinForm";
	}
	
	@RequestMapping(value="/join.do" , method = RequestMethod.POST)
	public ModelAndView join(@RequestParam HashMap<String, String> params, MultipartFile file, MemberDTO dto) {
		logger.info("dto : " + dto.getUser_id());
		logger.info("file : " + file);
		logger.info("params: " + params);
		return memberservice.join(params, file,dto);
	}
	
//	@RequestMapping(value="/profile.do")
//	public String profile(MultipartFile file) {
//		logger.info("file : " + file);
//		return memberservice.profile(file);
//	}
	
	/*
	 * // 로그인 성공시 가는 메인페이지
	 * 
	 * @RequestMapping(value="/main.go") public String main(Model model, HttpSession
	 * session) {
	 * 
	 * String loginId = (String) session.getAttribute("id"); MainDTO mainPage =
	 * memberservice.mainPage(loginId); logger.info("mainPage : "+mainPage);
	 * 
	 * 
	 * model.addAttribute("main",mainPage);
	 * 
	 * return "mainTest"; }
	 */
	
	// 아이디 중복 체크
	@RequestMapping(value = "/idChk.ajax", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> idChk(@RequestParam String user_id) {
		logger.info("idChk-controller");
		return memberservice.idChk(user_id);
	}
	
	// 아이디 찾기 + 아이디 메일 전송
	@RequestMapping(value = "/findID.go", method = RequestMethod.GET)
	public String findID(Model model) {
		return "findID";
	}
	
	@RequestMapping(value="/sendMail.ajax", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> sendMail(@RequestParam HashMap<String, String> params) {
		logger.info("params : " + params);
		return memberservice.sendMail(params);
	}
	
	// 비밀번호 재발급 + 비밀번호 재발급 메일 전송
	@RequestMapping(value = "/findPW.go")
	public String findPW(Model model) {
		return "findPw";
	}
	
	@RequestMapping(value="/sendPWMail.ajax", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> sendPWMail(@RequestParam HashMap<String, String> params) {
		logger.info("params : " + params);
		return memberservice.sendPWMail(params);
	}
	
	
	@RequestMapping(value="/login.do", method = RequestMethod.POST)
	public String login(String user_id, String password, Model model, HttpSession session, String id) {
		String page = "Login";
		
		if (memberservice.login(user_id,password,id) == true){
			id = memberservice.loginid(user_id);
			session.setAttribute("id", id);
			session.setAttribute("user_id", user_id);
			logger.info("id : " + id + "/ " + "user_id : " + user_id + "/ " + "password  : " + password);
			
			page = "redirect:/main.go?id="+id;
			
			
		}else {
			model.addAttribute("msg", "아이디 또는 비밀번호를 확인해주세요");
		}
		
		return page;
	}
	
	@RequestMapping(value="/logout.do")
	public String logout(HttpSession session) {
		session.removeAttribute("id");
		logger.info("id 제거 실행되었나 ? ");
		return "redirect:/";
	}
	
	// 마이페이지
	@RequestMapping(value="/userinfo.go")
    public String userInfo(HttpSession session, Model model) {  
       
       String page = "login";      
       
       logger.info("로그인 세션 : "+session.getAttribute("id"));
       
       if(session.getAttribute("id") != null) {
        	MemberDTO dto = memberservice.userInfo(String.valueOf(session.getAttribute("id")));             
        	model.addAttribute("member",dto);
            page = "userInfo";
       } 
       return page;
    }
	
	@RequestMapping(value = "/userinfoupdate.go")
	public String userInfoUpdatego(@RequestParam String id, HttpSession session, Model model) {
	    logger.info("마이페이지 수정요청");
	    logger.info("uuid : " + id);
	    String page = "userinfo";
	    String loginId = null;
	    
	    if (session.getAttribute("id") != null) {
	        loginId = (String) session.getAttribute("id");
	        if (loginId.equals(id)) {
	            MemberDTO dto = memberservice.userInfo(id);
	            logger.info("수정 서비스 들어가기 전");
	            if (dto != null) {
	                page = "userInfoUpdate";
	                model.addAttribute("member", dto);
	            }
	        }
	    }
	    return page;
	} 

	
	
	@RequestMapping(value="/userinfoupdate.do", method = RequestMethod.POST)
	public String userInfoUpdate(MultipartFile file,@RequestParam HashMap<String, String> params, HttpSession session, Model model) {
	    logger.info("마이페이지 수정");
	    String page = "redirect:/userinfo.go";
	    String loginId = null;
	    int id;
	    logger.info("session loginId : " + session.getAttribute("id"));
	    if (session.getAttribute("id") != null) {
	    	logger.info("params : " + params);
	    	
	        logger.info("params-id : " + params.get("id"));
	    	loginId = (String) session.getAttribute("id");
	        
	        if (loginId.equals(params.get("id"))) {
	        	logger.info("file : " + file);
	            memberservice.userInfoUpdate(file, params);
	            page = "redirect:/userinfo.go";
	        }
	    }
	    return page;
	}
	
	@RequestMapping(value = "/signprofile.go")
	public String signprofilego(HttpSession session, Model model) {

	    logger.info("서명이미지 페이지이동");
	    logger.info("로그인 세션 : "+session.getAttribute("id"));

	    String page = "login";
	    String loginId = null;
	    
		if(session.getAttribute("id") != null) {
			MemberDTO dto = memberservice.signinfo(String.valueOf(session.getAttribute("id")));             
			model.addAttribute("member",dto);
			page = "signprofilego";
		} 
	       return page;
	}
	
	@RequestMapping(value = "/signprofilechange.go")
	public String signprofilechangego(@RequestParam String id, HttpSession session, Model model) {
	    logger.info("서명이미지 등록시작");
	    logger.info("uuid : " + id);
	    String page = "signprofilego";
	    String loginId = null;
	    
	    if (session.getAttribute("id") != null) {
	        loginId = (String) session.getAttribute("id");
	        if (loginId.equals(id)) {
	        	MemberDTO dto = memberservice.signinfo(String.valueOf(session.getAttribute("id"))); 
	            logger.info("등록 서비스 들어가기 전");
	            if (dto != null) {
	                page = "signprofile";
	                model.addAttribute("member", dto);
	            }
	        }
	    }
	    return page;
	} 
	
	@RequestMapping(value="/signprofilechange.do")
	public String signprofilechange(HttpServletRequest request, HttpSession session, Model model) {  
	   
	    logger.info("서명 이미지 등록");
	    String page = "signprofilego";
	    String loginId = null;
	    String id = request.getParameter("id");
	    logger.info("session loginId : " + session.getAttribute("id"));
	    if (session.getAttribute("id") != null) {
	        logger.info("params-id : " + id);
	        loginId = (String) session.getAttribute("id");
	        

	            MultipartFile file = ((MultipartHttpServletRequest) request).getFile("signprofile");
	            logger.info("file : " + file);
	            memberservice.signprofile(file, id);
	            page = "redirect:/signprofile.go";
	 
	    }
	    return page;
	}
	
	// 부서 리스트 이동
	@RequestMapping(value="/departmentlist.go")
    public String departmentlistgo() {
		

        return "departmentlist";  
    }
	
	
	// 부서 리스트
	@RequestMapping(value="/departmentlist.ajax", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> departmentlist(HttpSession session, @RequestParam HashMap<String, Object> params) {
		
		logger.info("departmentlist params : " + params);
		return memberservice.departmentlist(params);
	}
	
	@RequestMapping(value="/photoView.do")
	public ResponseEntity<Resource> photoView(String path){
		
		Resource body = new FileSystemResource(attachmentRoot+"/"+path);
		
		HttpHeaders header = new HttpHeaders();
		
		try {
				
			String type = Files.probeContentType(Paths.get(attachmentRoot+"/"+path));
			logger.info("type : "+type);
			header.add("Content-type", type);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<Resource>(body, header, HttpStatus.OK);
	}
}