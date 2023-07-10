package kr.co.cc.chat.dao;

import java.util.ArrayList;
import java.util.HashMap;


import kr.co.cc.chat.dto.ChatDTO;
import kr.co.cc.chat.dto.MemberDTO;

public interface ChatDAO {

	ArrayList<MemberDTO> memberListAll();
	
	int createRoom(ChatDTO dto);
	
	int insert_chat_room_info(String chat_room_id, String user_id);
	
	ArrayList<ChatDTO> chatList(String name);
	
	ChatDTO room_list(String chat_room_id);
	
	ArrayList<ChatDTO> chatHistory(String chat_room_id);
	
	ArrayList<ChatDTO> chatLoad(String chat_room_id);

	int chatStored(HashMap<String, Object> map);

	void chatRoomExit(String chat_room_id, String member_id);
	
	String chatNameChk(String id);
	
	void insert_chat(String chat_room_id);
	
	ArrayList<MemberDTO> memberList(String chat_room_id);

	ArrayList<ChatDTO> chatMember(String chat_room_id);
	
	
	


	


	

	

	

}
