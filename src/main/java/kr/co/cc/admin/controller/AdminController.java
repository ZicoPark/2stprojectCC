package kr.co.cc.admin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.admin.dto.AdminDTO;
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
	public String AdminMemberDetail() {
		return "";
	}
	
	// 관리자 사원 요청/삭제 리스트
	@RequestMapping(value = "/MemberONOFFList.go")
	public String MemberONOFFList() {
		return "MemberONOFFList";
	}
	
	// 근태 수정 요청
	@RequestMapping(value = "/WorkChangeRequest.go")
	public String WorkChangeRequest() {
		return "MemberONOFFList";
	}
	
	// 일별 근태 현황
	@RequestMapping(value = "/WorkDailyList.go")
	public String WorkDailyList() {
		return "MemberONOFFList";
	}
	
	// 주별 근태 현황
	@RequestMapping(value = "/WorkWeekList.go")
	public String WorkWeekList() {
		return "MemberONOFFList";
	}
	
	// 연차/휴가 현황
	@RequestMapping(value = "/HolidayListAdmin.go")
	public String HolidayListAdmin() {
		return "MemberONOFFList";
	}
	
	// 부서 카테고리
	@RequestMapping(value = "/DeptCategory.go")
	public String DeptCategory() {
		return "DeptCategory";
	}
	
	// 자료실 카테고리
	@RequestMapping(value = "/ArchiveCategory.go")
	public String ArchiveCategory() {
		return "ArchiveCategory";
	}
	

}
