package kr.co.cc.admin.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.admin.dao.AdminDAO;
import kr.co.cc.admin.dto.AdminDTO;

@Service
@MapperScan(value = {"kr.co.cc.admin.dao"})
public class AdminService {

	private Connection conn;
	private ResultSet rs;
	String url = "jdbc:log4jdbc:mariadb://152.69.231.87:3306/cc2";
	String username = "web_user";
	String password = "gudi@gdj63";
	
	public void connectToDB() {
		try {
		    conn = DriverManager.getConnection(url, username, password);
		} catch (SQLException e) {
		    e.printStackTrace();
		}
	}
	
	@Autowired AdminDAO dao;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	public ModelAndView MemberList(HttpSession session) {
	    ModelAndView mav = new ModelAndView("AdminMemberListNotAdmin");
	    String id = (String) session.getAttribute("id");
	    AdminDTO dto = dao.admin_chk(id);

	    if (id != null && dto != null && dto.getAdmin_chk()) {
	        mav = new ModelAndView("AdminMemberList");
	        ArrayList<AdminDTO> list = dao.MemberList();
	        mav.addObject("list", list);
	    }
	    return mav;
	}

	public ModelAndView AdminMemberDetail(String id, HttpSession session) {
		//logger.info("Member uuid : "+id);
		ModelAndView mav = new ModelAndView("AdminMemberListNotAdmin");
		String member_id = (String) session.getAttribute("id");
		AdminDTO DTO = dao.admin_chkDetail(member_id);
		//logger.info("로그인 세션 : "+ session.getAttribute("id"));
		if (member_id != null && DTO != null && DTO.getAdmin_chk()) {
			mav = new ModelAndView("AdminMemberDetail");
			AdminDTO detail = dao.AdminMemberDetail(id);
			AdminDTO dto = dao.AdminMemberDetailPhoto(id);
			// logger.info("디테일확인 : "+detail);
			mav.addObject("detail", detail);
			mav.addObject("member",dto);
		}
		return mav;
	}
	
	public ArrayList<AdminDTO> MemberSearch(String searchField, String searchText){ //특정한 리스트를 받아서 반환
		ArrayList<AdminDTO> list = new ArrayList<AdminDTO>();
		connectToDB();
		String SQL = "SELECT member.user_id, member.dept_id, member.name, member.status, member.admin_chk, dept.name AS dept_name " +
	             "FROM member " +
	             "JOIN dept ON member.dept_id = dept.id " +
	             "WHERE ";
		if (searchField.trim().equals("name")) {
		    SQL += "member.name LIKE ?";
		} else if (searchField.trim().equals("id")) {
		    SQL += "member.user_id LIKE ?";
		} else if (searchField.trim().equals("dept_name")) {
		    SQL += "dept.name LIKE ?";
		}
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
		    pstmt.setString(1, "%" + searchText.trim() + "%");
		    rs = pstmt.executeQuery();
		    while (rs.next()) {
		        AdminDTO dto = new AdminDTO();
		        dto.setUser_id(rs.getString("user_id"));
		        dto.setDept_id(rs.getString("dept_id"));
		        dto.setName(rs.getString("name"));
		        dto.setStatus(rs.getBoolean("status"));
		        dto.setAdmin_chk(rs.getBoolean("admin_chk"));
		        dto.setDept_name(rs.getString("dept_name"));
		        list.add(dto);
		    }
		} catch (Exception e) {
		    e.printStackTrace();
		}
		return list;
	}

	public String MemberUpdate(AdminDTO dto, String user_id) {
		int row = dao.MemberUpdate(dto, user_id);
		logger.info("업데이트 확인 여부 : "+row);
		// logger.info("id 확인 : "+id);
		// String page = "redirect:/MemberList.go";
		String page = "redirect:/AdminMemberDetail.go?id="+user_id;
		return page;
	}

	public ModelAndView MemberONOFFList() {
		ModelAndView mav = new ModelAndView("MemberONOFFList");
		ArrayList<AdminDTO> list = dao.MemberONOFFList();
		mav.addObject("list",list);
		return mav;
	}

	public ModelAndView MemberONOFFListDetail(String id) {
		ModelAndView mav = new ModelAndView("MemberONOFFListDetail");
		AdminDTO detail = dao.MemberONOFFListDetail(id);
		mav.addObject("detail", detail);
		return mav;
	}

	public ModelAndView MemberONOFFDelete(String id) {
		ModelAndView mav = new ModelAndView("redirect://MemberONOFFList.go");
		int success = dao.MemberONOFFDelete(id);
		logger.info("삭제 여부 : "+success);
		return mav;
	}

	

	

	
	
}
