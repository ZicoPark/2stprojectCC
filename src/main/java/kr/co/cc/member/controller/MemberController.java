package kr.co.cc.member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.member.dto.MemberDTO;
import kr.co.cc.member.service.MemberService;
import kr.co.cc.member.service.SendEmailService;

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
		return "workHistoryList";
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
	
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout(HttpSession session) {
		session.removeAttribute("loginId");
		return "redirect:/";
	}
	
	 /*//Email과 name의 일치여부를 check하는 컨트롤러
	 @GetMapping("/check/findPw")
	 public @ResponseBody Map<String, Boolean> pw_find(String userEmail, String userName){
	    Map<String,Boolean> json = new HashMap<>();
	    boolean pwFindCheck = memberservice.userEmailCheck(userEmail,userName);

	    System.out.println(pwFindCheck);
	    json.put("check", pwFindCheck);
	    return json;
	    }

	//등록된 이메일로 임시비밀번호를 발송하고 발송된 임시비밀번호로 사용자의 pw를 변경하는 컨트롤러
	@PostMapping("/check/findPw/sendEmail")
	public @ResponseBody void sendEmail(String userEmail, String userName){
	    MemberDTO dto = SendEmailService.createMailAndChangePassword(userEmail, userName);
	    SendEmailService.mailSend(dto);

	    }
*/
}
