package kr.co.cc.stat.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.cc.stat.service.StatService;

@Controller
public class StatController {
	
	@Autowired StatService statservice;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value="/stat.go", method = RequestMethod.GET)
	public String statgo() {
		return "StatForm";
	}
	
	@GetMapping(value="/findElem.do")
	public String findElem() {
	      
		statservice.findElem("https://kr.noxinfluencer.com/youtube/channel-calculator/UCaxbXRPhdHPXjM-e-F00LVA");
		  
		return "Statresult";
	}
	
}
