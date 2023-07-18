package kr.co.cc.main.dao;


import java.util.ArrayList;

import kr.co.cc.main.dto.MainDTO;
import kr.co.cc.noticeBoard.dto.NoticeBoardDTO;


public interface MainDAO {

	MainDTO mWorkHistory(String id);

	int totalCountMs(String id);

	int totalRequestDocWait(String loginId);

	int totalCountPr(String id);

	ArrayList<NoticeBoardDTO> noticelist();

	boolean updateTodo(String todoId);

	void insertLink(String youtubeId, String newYoutubeId, String classification, String idx);

	void deleteLink();

	String youtubeURL();

}
