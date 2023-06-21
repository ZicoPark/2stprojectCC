package kr.co.cc.project.dao;




import java.util.ArrayList;

import kr.co.cc.project.dto.ProjectDTO;


public interface ProjectDAO {

	int write(ProjectDTO dto);

	ArrayList<ProjectDTO> list();

}
