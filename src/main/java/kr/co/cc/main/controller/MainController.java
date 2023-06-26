package kr.co.cc.main.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class MainController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@GetMapping(value="/mainGNB.go")
	public String index() {
		return "index";

	}
	
	@GetMapping(value="/index2.go")
	public String index2() {
		return "index2";
	}
	
	@GetMapping(value="/calender.go")
	public String calenderGo() {
		return "calender";
	}
	

	
	// 000.move 로 요청이 오면 000.jsp 로 이동
	@GetMapping(value="/{page}.move")
	public String pageMove(@PathVariable String page) {
		logger.info(page+".jsp 로 이동");
		return page;
	}
	
	
	
	@GetMapping(value="{root}/{page}.move")
	public String pageMove(@PathVariable String root
			,@PathVariable String page) {
		logger.info(page+".jsp 로 이동");
		return root+"/"+page;
	}
	
	@GetMapping(value="{root}/{sub}/{page}.move")
	public String pageMove(@PathVariable String root
			,@PathVariable String sub
			,@PathVariable String page) {
		logger.info(page+".jsp 로 이동");
		return root+"/"+sub+"/"+page;
	}
	
}