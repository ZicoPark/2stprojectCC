package kr.co.cc.message.service;

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
	
	
	private final MessageDAO dao;
	
	public MessageService(MessageDAO dao){
		this.dao = dao;
	}

	
	
	public ArrayList<MessageDTO> sendList(HttpSession session) {
		String id = (String) session.getAttribute("loginId");
		return dao.sendList(id);
	}

	public ModelAndView search(HashMap<String, String> params) {
		ModelAndView mav = new ModelAndView("msSendList");
		ArrayList<MemberDTO> search = dao.search(params);
		mav.addObject("search", search);
		return mav;
	}

	public MessageDTO msdetail(int id, String flag) {
		if(flag.equals("detail")) {
			logger.info("if문 진입");
			dao.upHit(id); // 읽음 처리
			
		}
		
		return dao.msdetail(id);
	}


	public String msDetailFile(int id) {
		return dao.msDetailFile(id);
	}







	public ArrayList<MessageDTO> receiveList(HttpSession session) {
		String id = (String) session.getAttribute("loginId");
		return dao.receiveList(id);
	}


	public boolean msDelete(String id) {
		
		return dao.msdelete(id);
	}

	// 쪽지 작성
	public String msWrite(MultipartFile file, HashMap<String, String> params,HttpSession session) {


		String page = "redirect:/msWrite.go";
		String loginId = (String) session.getAttribute("loginId");
		MessageDTO dto = new MessageDTO();
		
		logger.info("params :"+params);
		logger.info("files :"+file);

		dto.setFrom_id(loginId);
		dto.setTo_id(params.get("to_id"));
		dto.setTitle(params.get("title"));
		dto.setContent(params.get("content"));
		int row = dao.msWrite(dto);
		logger.info("insert row : "+row);
		
		int idx = dto.getId();
		
		logger.info("idx : "+idx);
		
	    if (file != null && !file.isEmpty()) {		
		// 입력받은 파일 이름
		String fileName = file.getOriginalFilename();
		// 확장자를 추출하기 위한 과정
		String ext = fileName.substring(fileName.lastIndexOf("."));
		// 새로운 파일 이름은?
		String newFileName = System.currentTimeMillis() + ext;
		String classification = "쪽지";
		try {
			byte[] bytes = file.getBytes();

			Path path = Paths.get(root + "/" + newFileName);
			Files.write(path, bytes);			
			dao.msfileWrite(fileName, newFileName,classification, idx);
		} catch (IOException e) {			
			e.printStackTrace();
		}		
	    }	
		
		return "msSendSuccess";
	}











}


