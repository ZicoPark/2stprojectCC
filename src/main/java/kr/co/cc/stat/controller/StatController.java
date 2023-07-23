package kr.co.cc.stat.controller;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.co.cc.stat.service.StatService;

@Controller
public class StatController {

	@Autowired
	StatService statservice;

	Logger logger = LoggerFactory.getLogger(getClass());

	@GetMapping(value = "/findStat.do")
	@ResponseBody
	public HashMap<String, Object> findStat(@RequestParam String statSearchText) {

		return statservice.findStat("https://kr.noxinfluencer.com/youtube/channel-calculator/"+statSearchText);
	}

}
