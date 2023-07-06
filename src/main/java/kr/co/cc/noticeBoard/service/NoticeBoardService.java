package kr.co.cc.noticeBoard.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.cc.archive.dto.ArchiveDTO;
import kr.co.cc.noticeBoard.dao.NoticeBoardDAO;
import kr.co.cc.noticeBoard.dto.NoticeBoardDTO;

@Service
@MapperScan(value= {"kr.co.cc.noticeBoard.dao"})
public class NoticeBoardService {

   @Autowired NoticeBoardDAO dao;
   @Value("${spring.servlet.multipart.location}") private String root;
   
   Logger logger = LoggerFactory.getLogger(getClass());
   
   public ArrayList<NoticeBoardDTO> nolist() {
		
		return dao.nolist();
	}


//   public ModelAndView write(MultipartFile uploadFile, HashMap<String, String> params, HttpSession session) {
//      
//      //String page = "redirect:/noticeBoardList.go.";
//      String page ="redirect:/";
//      
//      NoticeBoardDTO dto = new NoticeBoardDTO();
//      String identify_value = dto.getIdentify_value();
//      logger.info(identify_value);
//      
//      String id = (String) session.getAttribute("loginId");
//      String subject = params.get("subject");
//      String content = params.get("content");
//      
//      int success = dao.write(id,subject, content);
//      
//      if (uploadFile != null && !uploadFile.isEmpty()) {      
//         // 입력받은 파일 이름
//         String fileName = uploadFile.getOriginalFilename();
//         // 확장자를 추출하기 위한 과정
//         String ext = fileName.substring(fileName.lastIndexOf("."));
//         // 새로운 파일 이름은?
//         String newFileName = System.currentTimeMillis() + ext;
//         String classification = "공지사항";
//         try {
//            byte[] bytes = uploadFile.getBytes();
//
//            Path path = Paths.get(root + "/" + newFileName);
//            Files.write(path, bytes);         
//            dao.noticeFile(fileName, newFileName,classification, identify_value);
//         } catch (IOException e) {         
//            e.printStackTrace();
//         }      
//          }   
//      
//      return new ModelAndView(page);
//   }

	
	public String nowrite(MultipartFile file, HashMap<String, String> params, HttpSession session) {
	    String loginId = (String) session.getAttribute("id");
	    String page = "noticeBoard.go";
	    logger.info("params: " + params);
	    logger.info("files: " + file);
	
	    NoticeBoardDTO dto = new NoticeBoardDTO();
	    dto.setMember_id(loginId);
	    dto.setSubject(params.get("subject"));
	    dto.setContent(params.get("content"));
	
	    int row = dao.noticeBoardWrite(dto);
	    logger.info("insert row: " + row);
	    String idx = dto.getId();
	    
//	    String idx = String.valueOf(dto.getId()); // ID를 문자열로 변환
	
	    logger.info("insert row: " + row);
	    logger.info("idx: " + idx);
	
	    if (file != null && !file.isEmpty()) {
	        // 입력받은 파일 이름
	        String fileName = file.getOriginalFilename();
	        // 확장자를 추출하기 위한 과정
	        String ext = fileName.substring(fileName.lastIndexOf("."));
	        // 새로운 파일 이름은 UUID로 생성
	        String id = UUID.randomUUID().toString() + ext;
	        String classification = "공지사항";
	        try {
	            byte[] bytes = file.getBytes();
	
	            Path path = Paths.get(root + "/" + id);
	            Files.write(path, bytes);
	            dao.nofileWrite(fileName, id, classification, idx);
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }
	
	    page = "redirect:/noticeBoardDetail.do?id=" + idx;
	
	    return page;
	}
   
//   private void fileSave(int idx, MultipartFile photo) {
//	// 1. 파일을 C:/img/upload/ 에 저장
//			//1-1. 원본 이름 추출
//	   		String fileName = photo.getOriginalFilename();
//			//1-2. 확장자 추출
//	   		String ext = fileName.substring(fileName.lastIndexOf("."));
//			//1-3. 새이름 생성 + 확장자
//			 String newFileName = System.currentTimeMillis() + ext;
//	            String classification = "공지사항";
//	            try {
//	                byte[] bytes = photo.getBytes();
//
//	                Path path = Paths.get(root + "/" + newFileName);
//	                Files.write(path, bytes);
//	                dao.nofileWrite(fileName, newFileName, classification, idx);
//	            } catch (IOException e) {
//	                e.printStackTrace();
//	            }
//			
//		}

//	public NoticeBoardDTO detail(String id) {
//	      
//	      dao.upHit(id);
//	      
//	      return dao.detail(id);
//	   }
   
   public NoticeBoardDTO nodetail(String id, String flag) {
		
		if(flag.equals("detail")) {
			logger.info("if문");
			dao.upHit(id);
			
		}
		
		return dao.nodetail(id);
	}
   
   public ArrayList<String> noDetailFile(String id) {
	   return dao.noDetailFile(id);
	}
   
   public int del(String id) {
      
      return dao.del(id);
   }


	public ArrayList<NoticeBoardDTO> relist() {
		return dao.relist();
	}


	public ArrayList<NoticeBoardDTO> rlist(String id) {
		return dao.rlist(id);
	}


	public int rcount(String loginId, String id) {
		return dao.rcount(loginId, id);
	}


	public void getinfo(String loginId, String id) {
		dao.getinfo(loginId, id);
	}


//   //읽사
//   public ArrayList<NoticeBoardDTO> nlist() {
//      return dao.nlist();
//   }


}