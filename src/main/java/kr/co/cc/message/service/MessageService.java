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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.doc.dao.DocDAO;
import kr.co.cc.member.dto.MemberDTO;
import kr.co.cc.message.dao.MessageDAO;
import kr.co.cc.message.dto.MessageDTO;

@Service
@MapperScan(value= {"kr.co.cc.message.dao"})
public class MessageService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Value("${spring.servlet.multipart.location}") private String attachmentRoot;
	
	
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

	public ModelAndView msdetail(String id) {
		ModelAndView mav = new ModelAndView("MessageDetail");
		MessageDTO dto = dao.msdetail(id);
		mav.addObject("info", dto);
		return mav;
	}




	public ArrayList<MessageDTO> receiveList(HttpSession session) {
		String id = (String) session.getAttribute("loginId");
		return dao.receiveList(id);
	}


	public boolean msDelete(String id) {
		
		return dao.msdelete(id);
	}

	// 쪽지 작성
	public String msWrite(MultipartFile[] files, HashMap<String, String> params,HttpSession session) {


		String page = "redirect:/msWrite.go";
		String loginId = (String) session.getAttribute("loginId");
		MessageDTO dto = new MessageDTO();
		
		logger.info("params :"+params);
		

		dto.setFrom_id(loginId);
		dto.setTo_id(params.get("to_id"));
		dto.setTitle(params.get("title"));
		dto.setContent(params.get("content"));
		int row = dao.msWrite(dto);
		logger.info("insert row : "+row);
		
		int idx = dto.getId();
		
		if(idx==1) {// 업로드된 doc이 1이라면
			for (MultipartFile file : files) {
				logger.info("업로드할 file 있나요? :"+!file.isEmpty());
				
				attachmentSave(idx, file, "쪽지");
				
				try {// 쓰레드 0.001초 지연으로 중복파일명 막자
					Thread.sleep(1);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				
			}
		}
		
		return "msSendSuccess";
	}


	public void attachmentSave(int id, MultipartFile file, String cls) {

		String oriFileName = file.getOriginalFilename();
		String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
		String newFileName = System.currentTimeMillis() + ext;
		logger.info("파일 업로드 : "+oriFileName+"=>"+newFileName+"으로 변경될 예정");
		
		try {
			byte[] bytes = file.getBytes();
			Path path = Paths.get(attachmentRoot+"/"+newFileName);
			Files.write(path, bytes);
			logger.info(newFileName+" upload 디렉토리에 저장 완료 !");
			
			dao.msfileWrite(oriFileName, newFileName, id, cls);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
	}
		/*
	    if (file != null) {		
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
*/





}


