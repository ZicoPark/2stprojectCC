package kr.co.cc.personal.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import kr.co.cc.personal.service.PersonalService;

@Controller
public class PersonalController {

	@Autowired PersonalService service;
	
	 Logger logger = LoggerFactory.getLogger(getClass());
	
		@GetMapping(value="/presonal.go")
		public String personalList() {
			return "personalList";
		}
}
