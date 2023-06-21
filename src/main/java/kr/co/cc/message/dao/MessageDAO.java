package kr.co.cc.message.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import kr.co.cc.message.dto.MessageDTO;

public interface MessageDAO {

	ArrayList<MessageDTO> sendList();

}
