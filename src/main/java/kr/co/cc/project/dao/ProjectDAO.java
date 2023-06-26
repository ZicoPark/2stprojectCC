package kr.co.cc.project.dao;




import java.util.ArrayList;

import kr.co.cc.project.dto.ProjectDTO;


public interface ProjectDAO {

	int ProjectWrite(ProjectDTO dto);

	ArrayList<ProjectDTO> ProjectList();

	ProjectDTO ProjectDetail(int id);

	void addContributor(int project_id, String memberId);

}
