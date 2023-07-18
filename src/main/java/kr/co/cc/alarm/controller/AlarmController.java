package kr.co.cc.alarm.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.cc.alarm.dto.AlarmDTO;
import kr.co.cc.alarm.service.AlarmService;
import kr.co.cc.notice.dto.NoticeDTO;
import kr.co.cc.notice.service.NoticeService;
import kr.co.cc.noticeBoard.service.NoticeBoardService;


@Controller
public class AlarmController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired AlarmService service;
	//@Autowired NoticeService nService;
	
	@PostMapping(value="/alarmCount.ajax")
	@ResponseBody
	public int alarmCount(@RequestParam String receive_id) {
		logger.info("receive_id : " + receive_id);
		return service.alarmCount(receive_id);
	}
	
//	@RequestMapping(value="/alarmList.ajax", method = RequestMethod.POST)
//	@ResponseBody
//	 public ArrayList<NoticeDTO> alarmList(@RequestParam String loginId) {
//		   logger.info("readAlarm 통신");
//	      return nService.readAlarm(loginId);
//	   }
	
	@RequestMapping(value="/alarmList.ajax", method = RequestMethod.POST)
	@ResponseBody
	 public ArrayList<AlarmDTO> alarmList(@RequestParam String loginId) {
		   logger.info("readAlarm 통신");
	      return service.alarmList(loginId);
	   }
}
