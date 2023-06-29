package kr.co.cc.admin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.admin.service.AdminService;

@Controller
public class AdminController {
	
	@Autowired AdminService service;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	// 관리자 사원 리스트
	@RequestMapping(value = "/MemberList.go")
	public ModelAndView MemberList() {
		return service.MemberList();
	}
	// 관리사 사원 상세보기
	@RequestMapping(value = "/AdminMemberDetail.go")
	public ModelAndView AdminMemberDetail(@RequestParam ("id") String MemberId) {
		// logger.info("MemberId : "+MemberId);
		return service.AdminMemberDetail(MemberId);
	}
	
	// 관리자 사원 요청/삭제 리스트
	@RequestMapping(value = "/MemberONOFFList.go")
	public String MemberONOFFList() {
		return "MemberONOFFList";
	}
	
	

}
