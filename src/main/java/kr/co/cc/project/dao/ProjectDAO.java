package kr.co.cc.project.dao;




import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import kr.co.cc.chat.dto.MemberDTO;
import kr.co.cc.project.dto.AttachmentDTO;
import kr.co.cc.project.dto.ProjectDTO;


public interface ProjectDAO {

	int ProjectWrite(ProjectDTO dto);

	ArrayList<ProjectDTO> ProjectList();


	void addContributor(String contributorId, String project_id);

	void ProjectFileWrite(String idx, String ori_file_name, String new_file_name);

	int commentWrite(ProjectDTO dto);

	void stateChange(ProjectDTO dto);

	void AttachmentSave(AttachmentDTO dto);

	ProjectDTO projectDetailUp(String id);

	int projectUpdate(HashMap<String, String> params);

	void updateContributor(String contributorId, String project_id);

	void clearContributors(int project_id);

	String getUserId(String memberId);

	int projectDel(String id);

	void archivefileWrite(String oriFileName, String newFileName, String cls, String id);

	String projectDetailFile(String id);

	ArrayList<HashMap<String, String>> getAllComment(String projectId);

	int replyWrite(String id, String content, String loginId);

	ArrayList<ProjectDTO> replyLoad(String id);

	int replyDel(String id);

	int contributorChk(String loginId, String projectId);

	int createMemberChk(String loginId, String projectId);

	ArrayList<ProjectDTO> memberListAll();

	String getRange(String id);

	int projectRes(String id);

	ArrayList<HashMap<String, String>> getUserIdPhoto(String projectId);

	String getChk(String id);







}
