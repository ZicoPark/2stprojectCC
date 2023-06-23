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

	public ModelAndView write(HashMap<String, String> params, HttpSession session) {
		
		//String page = "redirect:/noticeBoardList.go.";
		
		String id = (String) session.getAttribute("loginId");
		String subject = params.get("subject");
		String content = params.get("content");
		
		int success = dao.write(id,subject, content);
	
		return null;
	}

	public NoticeBoardDTO detail(String id) {
		
		dao.upHit(id);
		
		return dao.detail(id);
	}
	
	public int del(String id) {
		
		return dao.del(id);
	}



	public void upload(MultipartFile uploadFile) {
		
		// 1. 파일명 추출
		String fileName = uploadFile.getOriginalFilename();
		
		// 2. 새파일 생성(현재시간 + 확장자)
		String ext = fileName.substring(fileName.lastIndexOf("."));
		String newFileName = System.currentTimeMillis() + ext;
		logger.info(fileName+" => "+newFileName);
		
		// 3. 파일 저장
		try {
			byte[] bytes = uploadFile.getBytes();
			Path path = Paths.get(root+"/"+newFileName);
			Files.write(path, bytes);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	public void multiUpload(MultipartFile[] files) {
		for (MultipartFile file : files) {
			upload(file);
			try {
				Thread.sleep(1);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		
	}

	public ArrayList<String> fileList() {		
		ArrayList<String> list = new ArrayList<String>();
		File[] files = new File(root+"/").listFiles();
		for (File file : files) {
			list.add(file.getName());
		}		
		return list;
	}

	
}
