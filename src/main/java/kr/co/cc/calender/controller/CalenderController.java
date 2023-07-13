package kr.co.cc.calender.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.cc.calender.dto.CalenderDTO;
import kr.co.cc.calender.service.CalenderService;

@Controller
public class CalenderController {
	
	@Autowired CalenderService service;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	// 캘린더 리스트
	@RequestMapping(value = "/CalenderList.go")
	public ModelAndView CalenderList(HttpSession session) throws JsonProcessingException {
	    String id = (String) session.getAttribute("id");
	    String user_id = (String) session.getAttribute("user_id");
	    logger.info("id 확인 : " + id);
	    logger.info("user_id 확인 : " + user_id);

	    ModelAndView mav;
	    ArrayList<CalenderDTO> eventList = service.CalenderList(id);
	    if (eventList != null && !eventList.isEmpty()) {
	        List<HashMap<String, Object>> calenderEvents = new ArrayList<>();
	        for (CalenderDTO event : eventList) {
	        	HashMap<String, Object> calenderEvent = new HashMap<>();
	            calenderEvent.put("id", event.getId());
	            calenderEvent.put("member_id", event.getMember_id());
	            calenderEvent.put("title", event.getTitle());
	            calenderEvent.put("content", event.getContent());
	            calenderEvent.put("start_at", event.getStart_at());
	            calenderEvent.put("end_at", event.getEnd_at());
	            calenderEvent.put("color", event.getColor());
	            calenderEvent.put("create_at", event.getCreate_at());

	            calenderEvents.add(calenderEvent);
	        }
	        mav = new ModelAndView("CalenderList");
	        ObjectMapper objectMapper = new ObjectMapper();
	        String jsonString = objectMapper.writeValueAsString(calenderEvents);
	        mav.addObject("json", jsonString);
	    } else {
	        mav = new ModelAndView("CalenderList");
	        mav.addObject("msg", "이벤트가 없습니다.");
	    }
	      
	    return mav;
	}
	
	@PostMapping("/CalenderListDrop.ajax")
    @ResponseBody
    public HashMap<String, Object> CalenderListDrop(@RequestBody List<HashMap<String, Object>> event) throws Exception{
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		//logger.info("이벤트 데이터확인 : {}",event);
		for (HashMap<String, Object> map : event) {
			String id = (String) map.get("uuid");
			String member_id = (String) map.get("id");
			//String member_id = (String) map.get("member_id");
			String title = (String) map.get("title");
			String content = (String) map.get("content");
			String color = (String) map.get("color");
			
			String createStr = (String) map.get("create_at");
			java.util.Date createDate = dateFormat.parse(createStr);
			java.sql.Timestamp create_at = new java.sql.Timestamp(createDate.getTime());
			
			String startStr = (String) map.get("start");
			java.util.Date startDate = dateFormat.parse(startStr);
			java.sql.Timestamp start_at = new java.sql.Timestamp(startDate.getTime());
			
			String endStr =  (String) map.get("end");
			java.util.Date endDate = dateFormat.parse(endStr);
			java.sql.Timestamp end_at = new java.sql.Timestamp(endDate.getTime());
			
			//logger.info("id 확인 : "+id);
			logger.info("uuid 확인 : "+id);
			logger.info("member 확인 : "+member_id);
			logger.info("title 확인 : "+title);
			logger.info("content 확인 : "+content);
			logger.info("color 확인 : "+color);
			logger.info("create_at 확인 : "+create_at);
			logger.info("start 확인 : "+start_at);
			logger.info("end 확인 : "+end_at);
			service.CalenderListDrop(id,member_id,title,content,color,create_at,start_at,end_at);
		}		
		HashMap<String, Object> map = new HashMap<>();
	    map.put("status", "map");
	    map.put("message", "일정이 성공적으로 생성되었습니다.");
	    
	    return map;
	}
    
	@PostMapping("/CalenderListDelete.ajax")
	@ResponseBody
	public HashMap<String, Object> CalenderListDelete(@RequestParam("eventId") String eventId){
		logger.info("eventId 확인 : "+eventId);
		service.CalenderListDelete(eventId);
		HashMap<String, Object> map = new HashMap<>();
		map.put("status", "success");
		return map;	
	}

}