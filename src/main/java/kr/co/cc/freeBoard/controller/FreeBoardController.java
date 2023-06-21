package kr.co.cc.freeBoard.controller;


import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;



@Controller
public class FreeBoardController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	
	@RequestMapping(value="/freeBoardList")
    public String writePage() {
		

        return "freeBoardList";  
    }
	
	
	
	
	
	
	
	
	
	
}
