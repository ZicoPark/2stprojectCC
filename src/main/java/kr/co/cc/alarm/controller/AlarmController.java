package kr.co.cc.alarm.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.cc.alarm.service.AlarmService;

@Controller
public class AlarmController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired AlarmService service;
	
	@PostMapping(value="/alarmCount.ajax")
	@ResponseBody
	public int alarmCount(@RequestParam String receive_id) {
		logger.info("receive_id : " + receive_id);
		return service.alarmCount(receive_id);
	}
}
