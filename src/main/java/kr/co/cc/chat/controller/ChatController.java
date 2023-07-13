package kr.co.cc.chat.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.chat.dto.ChatDTO;
import kr.co.cc.chat.dto.MemberDTO;
import kr.co.cc.chat.service.ChatService;

@Controller
public class ChatController {
	
	private final SimpMessagingTemplate template;	
	
	
	Logger logger = LoggerFactory.getLogger(getClass());	
	@Autowired ChatService service;	
	
	
	public ChatController(SimpMessagingTemplate template) {
		this.template = template;
	}
	
	@GetMapping(value="/chatRoom.go")
	public String home(HttpSession session) {
		String chatNameChk = service.chatNameChk(session);
		
		session.setAttribute("chatNameChk", chatNameChk);
		
		return "chatRoom";
	}	
	
	@PostMapping(value="/memberListAll.ajax")
	@ResponseBody
	public ArrayList<MemberDTO> memberListAll() {
		logger.info("/memberListAll.ajax");
		return service.memberListAll();
	}
	
	@PostMapping(value="/createChatroom.ajax")
	@ResponseBody
	public String createChatRoom(@RequestParam(value="member_id_array[]") ArrayList<String> member_id_array
			,@RequestParam String chat_room_name) {
		logger.info("member_id_array" + member_id_array);
		logger.info("chat_room_name : " + chat_room_name);
		
		for (String member_id_array_list : member_id_array) {
			logger.info("member_id_array : " + member_id_array_list);
		}
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("member_id_array", member_id_array);
		map.put("chat_room_name", chat_room_name);
		
		return service.createChatRoom(map);
	}
	
	@PostMapping(value="/chatList.ajax")
	@ResponseBody
	public ArrayList<ChatDTO> chatList(@RequestParam String member_id) {
		logger.info("chatList.ajax member_id : " + member_id);
		return service.chatList(member_id);
	}
	
	@PostMapping(value="/chatHistory.ajax")
	@ResponseBody
	public ArrayList<ChatDTO> chatHistory(@RequestParam String chat_room_id) {
		logger.info(chat_room_id);
		return service.chatHistory(chat_room_id);
	}
	
	@GetMapping(value="/chat/{chat_room_id}")
	public ModelAndView chat(@PathVariable String chat_room_id) {
		
		logger.info("chat_room_id : " + chat_room_id);
		ModelAndView mav = new ModelAndView("chatRoom");
		return mav;
	}
	
	@PostMapping(value="/chatLoad.ajax")
	@ResponseBody
	public ArrayList<ChatDTO> chatStored(@RequestBody String chat_room_id) {
		logger.info("chat_room_id : " + chat_room_id);
		return service.chatLoad(chat_room_id);
	}

	
	@MessageMapping(value="/chat/sendMessage")
	public void sendMessage(@PathVariable String chat_room_id, @Payload ChatDTO dto
			,SimpMessageHeaderAccessor headerAccessor) {
		
		// @Payload 어노테이션을 통해 메시지의 페이로드를 ChatDTO 객체로 수신하고, SimpMessageHeaderAccessor를 통해 WebSocket 메시지의 헤더에 접근
		
		logger.info("session id : " + headerAccessor.getSessionId());
		logger.info("dto : " + dto.getChat_room_id());
		logger.info("dto : " + dto.getSend_id());
		logger.info("dto : " + dto.getContent());
		logger.info("dto : " + dto.isIs_notice());
		logger.info("template : " + template);
		
		service.chatStored(dto);
		
		// SimpMessagingTemplate을 사용하여 메시지를 특정 주제(destination)에게 전송하는 역할
		// 첫 번째 매개변수는 메시지를 전송할 주제(destination)이고, 두 번째 매개변수는 전송할 메시지 데이터
		
		template.convertAndSend("/sub/chat/"+ dto.getChat_room_id(), dto);
	}
	
	@PostMapping(value="/chatRoomExit.ajax")
	@ResponseBody
	public HashMap<String, Object> chatRoomExit(@RequestParam String member_id,@RequestParam String chat_room_id) {
		logger.info("member_id : " + member_id, "chat_room_id : " + chat_room_id);
		service.chatRoomExit(chat_room_id,member_id);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("success", "success");
		
		return map;
	}
	
	@PostMapping(value="/memberList.ajax")
	@ResponseBody
	public ArrayList<MemberDTO> memberList(@RequestParam String chat_room_id) {
		logger.info("/memberList.ajax");
		return service.memberList(chat_room_id);
	}
	
	@PostMapping(value="/inviteChatRoom.ajax")
	@ResponseBody
	public String inviteChatRoom(@RequestParam(value="member_id_array[]") ArrayList<String> member_id_array
			,@RequestParam String chat_room_id) {
		logger.info("member_id_array" + member_id_array);
		logger.info("chat_room_id : " + chat_room_id);
		
		for (String member_id_array_list : member_id_array) {
			logger.info("member_id_array : " + member_id_array_list);
		}
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("member_id_array", member_id_array);
		map.put("chat_room_id", chat_room_id);
		
		return service.inviteChatRoom(map);
	}
	
	@PostMapping(value="/chatMember.ajax")
	@ResponseBody
	public ArrayList<ChatDTO> chatMember(@RequestParam String chat_room_id) {
		logger.info("chatMember.ajax chat_room_id : " + chat_room_id);
		return service.chatMember(chat_room_id);
	}
	
	
}
