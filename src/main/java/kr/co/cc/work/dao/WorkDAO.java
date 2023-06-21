package kr.co.cc.work.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import kr.co.cc.work.dto.WorkDTO;

@Mapper
public interface WorkDAO {

	ArrayList<WorkDTO> workHistoryList(String id);

}
