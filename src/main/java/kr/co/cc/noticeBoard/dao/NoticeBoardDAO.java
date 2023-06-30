package kr.co.cc.noticeBoard.dao;

import java.util.ArrayList;

import kr.co.cc.noticeBoard.dto.NoticeBoardDTO;

public interface NoticeBoardDAO {
   
   ArrayList<NoticeBoardDTO> nolist();
   
   int noticeBoardWrite(NoticeBoardDTO dto);
   
   void nofileWrite(String fileName, String newFileName, String classification, int idx);

//   int write(String id, String subject, String content);

   void upHit(int id);
  
   NoticeBoardDTO nodetail(int id);
   
   ArrayList<String> noDetailFile(String id);
   
   int del(String id);

   void noticeFile(String fileName, String newFileName, String classification, String id);

   ArrayList<NoticeBoardDTO> nlist();

   int write(NoticeBoardDTO dto);

   












}