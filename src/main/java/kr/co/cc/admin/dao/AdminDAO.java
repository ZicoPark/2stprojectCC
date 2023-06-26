package kr.co.cc.admin.dao;

import java.util.ArrayList;

import kr.co.cc.admin.dto.AdminDTO;

public interface AdminDAO {

	ArrayList<AdminDTO> MemberList();

	ArrayList<AdminDTO> AdminMemberDetail(String memberId);



}
