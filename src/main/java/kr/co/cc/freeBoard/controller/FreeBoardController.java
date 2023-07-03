package kr.co.cc.freeBoard.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.cc.freeBoard.service.FreeBoardService;

@Controller
public class FreeBoardController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired FreeBoardService service;
	
	@RequestMapping(value="/freeBoard.go")
    public String writePage() {
		

        return "freeBoardList";  
    }
	
    @RequestMapping(value="/Freelist.ajax", method = RequestMethod.POST)
    @ResponseBody
    public HashMap<String, Object> list(HttpSession session, @RequestParam HashMap<String, Object> params){
    	
       return service.Freelist(params);
    }
    	
	
	
	
	
	
	
	
	
}
