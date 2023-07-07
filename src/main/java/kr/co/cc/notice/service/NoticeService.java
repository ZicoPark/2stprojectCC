package kr.co.cc.notice.service;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.cc.notice.dao.NoticeDAO;

@Service
@MapperScan(value= {"kr.co.cc.notice.dao"})
public class NoticeService {
	
		@Autowired NoticeDAO dao;
	   Logger logger = LoggerFactory.getLogger(getClass());


}
