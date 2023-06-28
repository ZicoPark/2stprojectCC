package kr.co.cc.noticeBoard.service;

import java.util.ArrayList;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.cc.noticeBoard.dao.NoticeBoardDAO;
import kr.co.cc.noticeBoard.dto.NoticeBoardDTO;

@Service
@MapperScan(value= {"kr.co.cc.archive.dao"})
public class NoticeBoardService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired NoticeBoardDAO dao;
	
	public ArrayList<NoticeBoardDTO>list() {

		return dao.list();
		}
}
