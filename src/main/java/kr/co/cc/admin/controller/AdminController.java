package kr.co.cc.admin.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	public ModelAndView AdminMemberDetail(@RequestParam ("id") String id) {
		return service.AdminMemberDetail(id);
	}
	
	// 사원리스트 검색
	@RequestMapping(value = "/MemberSearch.go")
	public ModelAndView MemberSearch(@RequestParam("searchField") String searchField, @RequestParam("searchText") String searchText) {
		 ArrayList<AdminDTO> list = service.MemberSearch(searchField, searchText);
		 ModelAndView mav = new ModelAndView("AdminMemberList");
		 mav.addObject("list", list);
		 return mav;
	}
	
	// 관리자 사원 상세보기 업데이트(권한, 직급변경)
	@PostMapping("/MemberUpdate.go")
	public String memberUpdate(HttpServletRequest request) {
	    String id = request.getParameter("id");
	    String jobName = request.getParameter("job");
	    String deptName = request.getParameter("dept");
	    String[] statusArray = request.getParameterValues("status");
	    String[] adminArray = request.getParameterValues("admin");

	    boolean status = false;
	    boolean admin = false;

	    if (statusArray != null && statusArray.length > 0) {
	        String statusStr = statusArray[0];
	        if (statusStr.equalsIgnoreCase("재직")) {
	            status = true;
			} /*
				 * else if (statusStr.equalsIgnoreCase("휴직")) { status = true; } else { status =
				 * false; }
				 */
	    }

	    if (adminArray != null && adminArray.length > 0) {
	        String adminStr = adminArray[0];
	        if (adminStr.equalsIgnoreCase("1")) {
	            admin = true;
	        }
	    }
	    // logger.info("jobName체크 : "+jobName);
	    // logger.info("deptName체크 : "+deptName);
	    // logger.info("status체크 : "+status);
	    // logger.info("admin체크 : "+admin);
	    AdminDTO dto = new AdminDTO();
	    dto.setId(id);
	    dto.setJob_name(jobName);
	    dto.setDept_name(deptName);
	    dto.setStatus(status);
	    dto.setAdmin_chk(admin);
	    
	    return service.MemberUpdate(dto, id);
	}
	
	// 관리자 사원 요청/삭제 리스트
	@RequestMapping(value = "/MemberONOFFList.go")
	public String MemberONOFFList() {
		return "MemberONOFFList";
	}
}
