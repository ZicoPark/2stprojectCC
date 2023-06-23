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

import kr.co.cc.member.dto.MemberDTO;
import kr.co.cc.message.dao.MessageDAO;
import kr.co.cc.message.dto.MessageDTO;

@Service
@MapperScan(value= {"kr.co.cc.message.dao"})
public class MessageService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Value("${spring.servlet.multipart.location}") private String root;
	
	@Autowired MessageDAO dao;

	
	
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
	public String msWrite(MultipartFile[] photos, HashMap<String, String> params,HttpSession session) {


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
		logger.info("방금 insert한 idx : "+idx);
		
		for (MultipartFile photo : photos) {
			logger.info("photo 있으면 false, 없으면 true :"+photo.isEmpty());
			if(photo.isEmpty()==false) {
				
				fileSave(idx, photo);
				
				try {
					Thread.sleep(1);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				
			}
		}

		page = "redirect:/msdetail.do?id="+idx;

		return page;
	}

	private void fileSave(int idx, MultipartFile photo) {

		String ori_photo_name = photo.getOriginalFilename();
		String ext = ori_photo_name.substring(ori_photo_name.lastIndexOf("."));
		String classification = "쪽지";
		String new_photo_name = System.currentTimeMillis() + ext;
		logger.info(ori_photo_name+"=>"+new_photo_name);
		
		try {
			byte[] bytes = photo.getBytes();
			
			Path path = Paths.get("C:/upload"+new_photo_name);
			Files.write(path, bytes);
			logger.info(new_photo_name+" save OK");
			
			dao.msfileWrite(ori_photo_name, new_photo_name, idx, classification);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
}


