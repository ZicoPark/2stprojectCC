package kr.co.cc.message.service;

import java.util.ArrayList;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.cc.message.dao.MessageDAO;
import kr.co.cc.message.dto.MessageDTO;

@Service
@MapperScan(value= {"kr.co.cc.message.dao"})
public class MessageService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MessageDAO dao;

	public ArrayList<MessageDTO> sendList() {
		
		return dao.sendList();
	}

}
