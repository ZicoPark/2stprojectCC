package kr.co.cc.noticeBoard.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import kr.co.cc.noticeBoard.dto.NoticeBoardDTO;

public interface NoticeBoardDAO {

	ArrayList<NoticeBoardDTO> list();

}
