package kr.co.cc.member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.member.dto.MemberDTO;
import kr.co.cc.member.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired MemberService memberservice;
	
	Logger logger = LoggerFactory.getLogger(getClass());

	@RequestMapping(value="/", method = RequestMethod.GET)
	public String home(Model model) {
		return "Login";
	}

	@RequestMapping(value="/join.go", method = RequestMethod.GET)
	public String joinForm(Model model) {
		return "JoinForm";
	}
	
	@PostMapping(value="/join.do")
	public ModelAndView join(MemberDTO dto) {
		logger.info("dto : " + dto.getId());
		return memberservice.join(dto);
	}
	
	@RequestMapping(value="/main.go")
	public String main(Model model) {
		return "main";
	}
	
	@RequestMapping(value="/login.do", method = RequestMethod.POST)
	public String login(Model model, @RequestParam HashMap<String, String> params, HttpSession session) {
		String page = "Login";
		
		String loginId = memberservice.login(params);
		logger.info("loginId : " + loginId);
		
		if (loginId !=null) {
			page = "redirect:/main.go";
			session.setAttribute("loginId", loginId);
		}else {
			model.addAttribute("msg", "아이디 또는 비밀번호를 확인해주세요");
		}
		
		return page;
	}
	

}
