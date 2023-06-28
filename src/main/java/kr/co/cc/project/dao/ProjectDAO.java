package kr.co.cc.project.dao;




import java.util.ArrayList;

import kr.co.cc.project.dto.ProjectDTO;


public interface ProjectDAO {

	int ProjectWrite(ProjectDTO dto);

	ArrayList<ProjectDTO> ProjectList();

	ArrayList<ProjectDTO> ProjectDetail(int id);

	void addContributor(int project_id, String memberId);

	void ProjectFileWrite(String idx, String ori_file_name, String new_file_name);

	int commentWrite(ProjectDTO dto);

	void stateChange(String string);

	void stateChange(ProjectDTO dto);

}
