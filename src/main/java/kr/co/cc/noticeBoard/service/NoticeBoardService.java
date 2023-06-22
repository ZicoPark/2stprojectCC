package kr.co.cc.noticeBoard.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.noticeBoard.dao.NoticeBoardDAO;
import kr.co.cc.noticeBoard.dto.NoticeBoardDTO;

@Service
@MapperScan(value= {"kr.co.cc.noticeBoard.dao"})
public class NoticeBoardService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired NoticeBoardDAO dao;
	
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
}
