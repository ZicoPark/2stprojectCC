package kr.co.cc.freeBoard.dao;




import java.util.ArrayList;
import java.util.HashMap;

import kr.co.cc.archive.dto.ArchiveDTO;
import kr.co.cc.freeBoard.dto.FreeBoardDTO;


public interface FreeBoardDAO {

	int totalCount();

	int totalCountSearch(String search);

	ArrayList<FreeBoardDTO> freelist(int offset);

	ArrayList<FreeBoardDTO> freelistsubject(HashMap<String, Object> params);

	ArrayList<FreeBoardDTO> freelistmemberId(HashMap<String, Object> params);

	ArrayList<FreeBoardDTO> freelistAll(HashMap<String, Object> params);

	ArrayList<FreeBoardDTO> freelistSearch(HashMap<String, Object> params);

	int freeWrite(FreeBoardDTO dto);

	void freefileWrite(String oriFileName, String newFileName, String cls, String id);

	void freeupHit(String id);

	FreeBoardDTO freedetail(String id);

	ArrayList<String> freeDetailFile(String id);

	FreeBoardDTO logincheck(String loginId);

	ArrayList<FreeBoardDTO> replyList(String id);

	void postWrite(FreeBoardDTO dto);

	FreeBoardDTO replySelect(FreeBoardDTO dto);

	int replyModify(HashMap<String, String> params);

	




}
