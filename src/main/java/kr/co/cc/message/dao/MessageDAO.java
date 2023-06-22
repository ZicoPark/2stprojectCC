package kr.co.cc.message.dao;

import java.util.ArrayList;
import java.util.HashMap;



import kr.co.cc.member.dto.MemberDTO;
import kr.co.cc.message.dto.MessageDTO;

public interface MessageDAO {

	ArrayList<MessageDTO> sendList();

	ArrayList<MemberDTO> search(HashMap<String, String> params);

	MessageDTO msdetail(String id);

	int msWrite(MessageDTO dto);

	void fileWrite(String ori_photo_name, String new_photo_name, int id, String classification);

	ArrayList<MessageDTO> receiveList();

}
