package kr.co.cc.admin.dao;

import java.util.ArrayList;

import kr.co.cc.admin.dto.AdminDTO;

public interface AdminDAO {

	ArrayList<AdminDTO> MemberList();

	AdminDTO AdminMemberDetail(String id);

	void MemberUpdate(boolean admin, String dept, String job, String status);

	int MemberUpdate(AdminDTO dto, String user_id);

	ArrayList<AdminDTO> MemberONOFFList();

	AdminDTO MemberONOFFListDetail(String id);

	int MemberONOFFDelete(String id);

	AdminDTO AdminMemberDetailPhoto(String id);


	AdminDTO admin_chk(String id);

	AdminDTO admin_chkDetail(String id);

	int totalCount();

	ArrayList<AdminDTO> MemberListPaging(int cnt, int offset);


	

	


}
