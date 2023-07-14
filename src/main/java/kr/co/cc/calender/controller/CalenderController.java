package kr.co.cc.calender.controller;

import java.text.DateFormat;
import java.text.ParseException;
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

	    ModelAndView mav = new ModelAndView("Login");
	    ArrayList<CalenderDTO> eventList = service.CalenderList(id);
	    if(session.getAttribute("id") != null) {
	    	if (eventList != null && !eventList.isEmpty()) {
		        List<HashMap<String, Object>> calenderEvents = new ArrayList<>();
		        //SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		        for (CalenderDTO event : eventList) {
		        	HashMap<String, Object> map = new HashMap<>();
		        	map.put("id", event.getId());
		        	map.put("member_id", event.getMember_id());
		        	map.put("title", event.getTitle());
		            map.put("content", event.getContent());
		            map.put("color", event.getColor());
		            //map.put("start_at", dateFormat.format(event.getStart_at()));
		            //map.put("end_at", dateFormat.format(event.getEnd_at()));
		            //map.put("create_at", dateFormat.format(event.getCreate_at()));
		            map.put("start_at", event.getStart_at());
		            map.put("end_at", event.getEnd_at());
		            map.put("create_at", event.getCreate_at());

		            calenderEvents.add(map);
		            logger.info("calenderEvents 확인 : "+calenderEvents);
		        }
		        mav = new ModelAndView("CalenderList");
		        ObjectMapper objectMapper = new ObjectMapper();
		        String jsonString = objectMapper.writeValueAsString(calenderEvents);
		        mav.addObject("json", jsonString);
		    } else {
		        mav = new ModelAndView("CalenderList");
		        mav.addObject("msg", "이벤트가 없습니다.");
		    }
	    }      
	    return mav;
	}
	
	@PostMapping("/CalenderListDrop.ajax")
    @ResponseBody
    public HashMap<String, Object> CalenderListDrop(@RequestBody List<HashMap<String, Object>> event) throws Exception{
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		//logger.info("이벤트 데이터확인 : {}",event);
		List<HashMap<String, Object>> dataList = new ArrayList<>(); // 데이터를 저장할 리스트 생성
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
			
			HashMap<String, Object> dataMap = new HashMap<>();
		    dataMap.put("id", id);
		    dataMap.put("member_id", member_id);
		    dataMap.put("title", title);
		    dataMap.put("content", content);
		    dataMap.put("color", color);
		    dataMap.put("create_at", create_at);
		    dataMap.put("start_at", start_at);
		    dataMap.put("end_at", end_at);

		    dataList.add(dataMap); // 리스트에 맵 추가
		}		
		HashMap<String, Object> map = new HashMap<>();
		map.put("data", dataList); // 데이터 리스트를 맵에 추가
	    map.put("status", "success");
	    map.put("message", "일정이 성공적으로 생성되었습니다.");
	    
	    return map;
	}
	
	// 이벤트 시간 수정
	@PostMapping("/CalenderListResize.ajax")
    @ResponseBody
    public HashMap<String, Object> CalenderListResize(@RequestBody HashMap<String, Object> event) throws ParseException{
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		String id = (String) event.get("uuid");
		
		String startStr = (String) event.get("start");
		java.util.Date startDate = dateFormat.parse(startStr);
		java.sql.Timestamp start_at = new java.sql.Timestamp(startDate.getTime());
		
		String endStr = (String) event.get("end");
		java.util.Date endDate = dateFormat.parse(endStr);
		java.sql.Timestamp end_at = new java.sql.Timestamp(endDate.getTime());

		//logger.info("이벤트 아이디 : "+id);
		//logger.info("이벤트 시작 : "+start_at);
		//logger.info("이벤트 끝 : "+end_at);
		
		service.CalenderListResize(id,start_at,end_at);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("status", "success");
		map.put("message", "이벤트 시간이 업데이트되었습니다.");
		
		return map;
	}
	
	// 이벤트 위치 수정
	@PostMapping("/CalenderListEventDrop.ajax")
    @ResponseBody
    public HashMap<String, Object> CalenderListEventDrop(@RequestBody HashMap<String, Object> event) throws ParseException{
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		String id = (String) event.get("uuid");
		
		String startStr = (String) event.get("start");
		java.util.Date startDate = dateFormat.parse(startStr);
		java.sql.Timestamp start_at = new java.sql.Timestamp(startDate.getTime());
		
		String endStr = (String) event.get("end");
		java.util.Date endDate = dateFormat.parse(endStr);
		java.sql.Timestamp end_at = new java.sql.Timestamp(endDate.getTime());

		//logger.info("이벤트 아이디 : "+id);
		//logger.info("이벤트 시작 : "+start_at);
		//logger.info("이벤트 끝 : "+end_at);
		
		service.CalenderListEventDrop(id,start_at,end_at);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("status", "success");
		map.put("message", "이벤트 시간이 업데이트되었습니다.");
		
		return map;
	}
	
	// 이벤트 삭제
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