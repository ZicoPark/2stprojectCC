package kr.co.cc.freeBoard.dao;




import java.util.ArrayList;
import java.util.HashMap;


import kr.co.cc.freeBoard.dto.FreeBoardDTO;


public interface FreeBoardDAO {

	int totalCount();

	int totalCountSearch(String search);

	ArrayList<FreeBoardDTO> freelist(int offset);

	ArrayList<FreeBoardDTO> freelistsubject(HashMap<String, Object> params);

	ArrayList<FreeBoardDTO> freelistmemberId(HashMap<String, Object> params);

	ArrayList<FreeBoardDTO> freelistAll(HashMap<String, Object> params);

	ArrayList<FreeBoardDTO> freelistSearch(HashMap<String, Object> params);




}
