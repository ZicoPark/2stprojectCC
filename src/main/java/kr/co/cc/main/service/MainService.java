package kr.co.cc.main.service;


import java.util.ArrayList;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.cc.main.dao.MainDAO;
import kr.co.cc.main.dto.MainDTO;
import kr.co.cc.noticeBoard.dto.NoticeBoardDTO;


@Service
@MapperScan(value= {"kr.co.cc.main.dao"})
public class MainService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MainDAO dao;
	
	
	public MainDTO mWorkHistory(String id) {
		
		return dao.mWorkHistory(id);
	}


	public int totalCountMs(String id) {
		
		return dao.totalCountMs(id);
	}


	public int totalRequestDocWait(String loginId) {
		return dao.totalRequestDocWait(loginId);
	}


	public int totalCountPr(String id) {
		return dao.totalCountPr(id);
	}


	public ArrayList<NoticeBoardDTO> noticelist() {
		return dao.noticelist();
	}


	public boolean updateTodo(String todoId) {
		
		return dao.updateTodo(todoId);
	}


	// 유튜브 링크 변환, 저장
	public String youtubeInsert(String youtubeLink) {
		
	    logger.info("원본 youtubeLink: " + youtubeLink);

	    String youtubeId = getYoutubeId(youtubeLink);


	    if (youtubeId != null) {
	        // 변경된 파일명 생성
	        String newYoutubeId = UUID.randomUUID().toString() + ".mp4";
	        String classification = "유튜브";
	        String idx = "유튜브";

	        logger.info("원본 유튜브 링크: " + youtubeId);
	        logger.info("변경된 유튜브 링크: " + newYoutubeId);
	        
	        dao.deleteLink();
	        
	        dao.insertLink(youtubeId,newYoutubeId,classification,idx);
	        
	        return "redirect:/main.go";
	    } else {
	        return "유효한 YouTube URL을 입력해주세요.";
	    }
	}

	// URL에서 YouTube ID를 추출하는 메서드
	public String getYoutubeId(String url) {
	    String regex = "youtu\\.be/([^?]+)";
	    Pattern pattern = Pattern.compile(regex);
	    Matcher matcher = pattern.matcher(url);

	    if (matcher.find()) {
	        return matcher.group(1);
	    } else {
	        return null;
	    }
	}


	public String youtubeURL() {
		
		return dao.youtubeURL();
	}

	}


