package kr.co.cc.chat.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.co.cc.chat.dto.ChatDTO;
import kr.co.cc.chat.dto.MemberDTO;
import kr.co.cc.chat.dao.ChatDAO;

@Service
@MapperScan(value= {"kr.co.cc.chat.dao"})
public class ChatService {
	
	Logger logger = LoggerFactory.getLogger(getClass());	
	private final ChatDAO dao;
	public ChatService(ChatDAO dao) {
		this.dao = dao;
	}
	
	
	public ArrayList<MemberDTO> memberListAll() {
		return dao.memberListAll();
	}
	
	public String createChatRoom(HashMap<String, Object> map) {
		ChatDTO dto = new ChatDTO();
		dto.setName(String.valueOf(map.get("chat_room_name")));
		
		dao.createRoom(dto);
		
		logger.info("getChat_room_id : " + dto.getChat_room_id());
		
		for (String member_id_array : (ArrayList<String>) map.get("member_id_array")) {
			logger.info("id : "+ member_id_array);
			dao.insert_chat_room_info(dto.getChat_room_id(), member_id_array);
			
		}
		
		dao.insert_chat(dto.getChat_room_id());
		
		return "success";
	}
	
	public ArrayList<ChatDTO> chatList(String member_id) {
		ArrayList<ChatDTO> room_list = new ArrayList<ChatDTO>();
		ArrayList<ChatDTO> room_info_list = dao.chatList(member_id);
		
		for (ChatDTO chatDTO : room_info_list) {
			logger.info("chatDTO : " + chatDTO.getChat_room_id());
			room_list.add(dao.room_list(chatDTO.getChat_room_id()));
		}
		return room_list;
	}
	
	public ArrayList<ChatDTO> chatHistory(String chat_room_id) {
		return dao.chatHistory(chat_room_id);
	}
	
	public ArrayList<ChatDTO> chatLoad(String chat_room_id) {
		return dao.chatLoad(chat_room_id);
	}	

	public void chatStored(ChatDTO dto) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("chat_room_id", dto.getChat_room_id());
		map.put("send_id", dto.getSend_id());
		map.put("content", dto.getContent());
		map.put("is_notice", dto.isIs_notice());
		dao.chatStored(map);
	}
	public void chatRoomExit(String chat_room_id, String member_id) {
		dao.chatRoomExit(chat_room_id,member_id);
		
	}
	public String chatNameChk(HttpSession session) {
		String id = (String) session.getAttribute("id");
		return dao.chatNameChk(id);
	}
	public ArrayList<MemberDTO> memberList(String chat_room_id) {
		logger.info(chat_room_id + "chat_room_id");
		return dao.memberList(chat_room_id);
	}


	public String inviteChatRoom(HashMap<String, Object> map) {
		ChatDTO dto = new ChatDTO();
		dto.setChat_room_id(String.valueOf(map.get("chat_room_id")));
		
		logger.info("getChat_room_id : " + dto.getChat_room_id());
		
		String chat_room_id = dto.getChat_room_id();
		
		for (String member_id_array : (ArrayList<String>) map.get("member_id_array")) {
			logger.info("id : "+ member_id_array);
			dao.insert_chat_room_info(chat_room_id, member_id_array);			
		}
		
		return "success";
	}


	public ArrayList<ChatDTO> chatMember(String chat_room_id) {
		return dao.chatMember(chat_room_id);
	}

	
	

}
