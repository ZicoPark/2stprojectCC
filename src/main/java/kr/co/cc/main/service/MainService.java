package kr.co.cc.main.service;


import java.util.ArrayList;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.cc.main.dao.MainDAO;
import kr.co.cc.main.dto.MainDTO;
import kr.co.cc.noticeBoard.dto.NoticeBoardDTO;


@Service
@MapperScan(value= {"kr.co.cc.main.dao"})
public class MainService {

	@Autowired MainDAO dao;
	
	
	public MainDTO mWorkHistory(String id) {
		
		return dao.mWorkHistory(id);
	}


	public int totalCountMs(String id) {
		
		return dao.totalCountMs(id);
	}


	public int totalCountDoc(String id) {
		return dao.totalCountDoc(id);
	}


	public int totalCountPr(String id) {
		return dao.totalCountPr(id);
	}


	public ArrayList<NoticeBoardDTO> noticelist() {
		return dao.noticelist();
	}

}
