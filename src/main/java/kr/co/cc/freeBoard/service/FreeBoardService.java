package kr.co.cc.freeBoard.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;


import kr.co.cc.freeBoard.dao.FreeBoardDAO;
import kr.co.cc.freeBoard.dto.FreeBoardDTO;


@Service
@MapperScan(value= {"kr.co.cc.freeBoard.dao"})
public class FreeBoardService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Value("${spring.servlet.multipart.location}") private String attachmentRoot;
	private final FreeBoardDAO dao;
	
	public FreeBoardService(FreeBoardDAO dao){
		this.dao = dao;
	}

	@Value("${spring.servlet.multipart.location}") private String root;	

	public HashMap<String, Object> Freelist(HashMap<String, Object> params) {
		int page = Integer.parseInt(String.valueOf(params.get("page")));
	    String subject = String.valueOf(params.get("subject"));
	    String memberId = String.valueOf(params.get("member_id"));
	    String search = String.valueOf(params.get("search"));
	    String create_at = String.valueOf(params.get("create_at"));
	    String hit = String.valueOf(params.get("hit"));

	    
	    HashMap<String, Object> map = new HashMap<String, Object>();

	    int offset = 10*(page-1);	    
		
	    logger.info("offset : " + offset);
	    
	    logger.info("params : " + params);
	    
	    int total = 0;	    
		
	    if(search.equals("default") || search.equals("")) {
	      
	    	  total = dao.totalCount();

	      	}else {	      
	    	   	   
	    	  total = dao.totalCountSearch(search);
	       }
	    
	    int range = total%10  == 0 ? total/10 : total/10+1;

	      page = page>range ? range:page;
	      
	      ArrayList<FreeBoardDTO> list = null;
	      
	      params.put("offset", offset);
			
	      logger.info("user search:"+search);
	      
	      if(search.equals("default") ||search.equals("")) {

	          list = dao.freelist(offset);
	       
	     
	      }else {

	         list = dao.freelistSearch(params);
	      }
	      		
		
	      //logger.info("list size : "+ list.size());
	      map.put("list", list);
	      map.put("currPage", page);	      
	    

	
		return map;

	}
}
