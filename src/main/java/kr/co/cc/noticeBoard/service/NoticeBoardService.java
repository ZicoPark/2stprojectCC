package kr.co.cc.noticeBoard.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.noticeBoard.dao.NoticeBoardDAO;
import kr.co.cc.noticeBoard.dto.NoticeBoardDTO;

@Service
@MapperScan(value= {"kr.co.cc.noticeBoard.dao"})
public class NoticeBoardService {

	@Autowired NoticeBoardDAO dao;
	@Value("${spring.servlet.multipart.location}") private String root;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	public ArrayList<NoticeBoardDTO>list() {

		return dao.list();
		}

	public ModelAndView write(MultipartFile uploadFile, HashMap<String, String> params, HttpSession session) {
		
		//String page = "redirect:/noticeBoardList.go.";
		String page ="redirect:/";
		
		String id = (String) session.getAttribute("loginId");
		String subject = params.get("subject");
		String content = params.get("content");
		
		int success = dao.write(id,subject, content);
	   
		if (uploadFile != null && !uploadFile.isEmpty()) {		
			// 입력받은 파일 이름
			String fileName = uploadFile.getOriginalFilename();
			// 확장자를 추출하기 위한 과정
			String ext = fileName.substring(fileName.lastIndexOf("."));
			// 새로운 파일 이름은?
			String newFileName = System.currentTimeMillis() + ext;
			String classification = "공지사항";
			try {
				byte[] bytes = uploadFile.getBytes();

				Path path = Paths.get(root + "/" + newFileName);
				Files.write(path, bytes);			
				dao.noticeFile(fileName, newFileName,classification, id);
			} catch (IOException e) {			
				e.printStackTrace();
			}		
		    }	
		
		return new ModelAndView(page);
	}
	
	public NoticeBoardDTO detail(String id) {
		
		dao.upHit(id);
		
		return dao.detail(id);
	}
	
	public int del(String id) {
		
		return dao.del(id);
	}

	
}
