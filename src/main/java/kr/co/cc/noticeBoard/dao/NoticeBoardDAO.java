package kr.co.cc.noticeBoard.dao;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.cc.member.dto.MemberDTO;
import kr.co.cc.noticeBoard.dto.NoticeBoardDTO;

public interface NoticeBoardDAO {
   
   ArrayList<NoticeBoardDTO> nolist();
   
   int noticeBoardWrite(NoticeBoardDTO dto);
   
   void nofileWrite(String fileName, String newFileName, String classification, String idx);

//   int write(String id, String subject, String content);

   void upHit(String id);
  
   NoticeBoardDTO nodetail(String id);
   
   ArrayList<String> noDetailFile(String id);
   
   int noticeBoardDel(String id);

   void noticeFile(String fileName, String newFileName, String classification, String id);

   ArrayList<NoticeBoardDTO> nlist();

   int write(NoticeBoardDTO dto);

	ArrayList<NoticeBoardDTO> relist();
	
	ArrayList<NoticeBoardDTO> rlist(String id);
	
	int rcount(String loginId, String id);
	
	void getinfo(String loginId, String id);
	
	ArrayList<MemberDTO> memberAll();
	
	int insertNotice(HashMap<String, Object> map);

	int noticeDel(String id);

	void readNotice(String id, String loginId);

	NoticeBoardDTO logincheck(String loginId);

   












}