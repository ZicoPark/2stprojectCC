package kr.co.cc.message.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.member.dto.MemberDTO;
import kr.co.cc.message.dao.MessageDAO;
import kr.co.cc.message.dto.MessageDTO;

@Service
@MapperScan(value= {"kr.co.cc.message.dao"})
public class MessageService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Value("${spring.servlet.multipart.location}") private String root;
	
	@Autowired MessageDAO dao;

	public void msUpload(MultipartFile uploadFile) {
		
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
	
	
	public ArrayList<MessageDTO> sendList() {
		
		return dao.sendList();
	}

	public ModelAndView search(HashMap<String, String> params) {
		ModelAndView mav = new ModelAndView("msSendList");
		ArrayList<MemberDTO> search = dao.search(params);
		mav.addObject("search", search);
		return mav;
	}

	public ModelAndView msdetail(String id) {
		ModelAndView mav = new ModelAndView("MessageDetail");
		MessageDTO dto = dao.msdetail(id);
		mav.addObject("info", dto);
		return mav;
	}




	public ArrayList<MessageDTO> receiveList() {
		return dao.receiveList();
	}

}
