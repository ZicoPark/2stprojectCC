package kr.co.cc.message.dao;

import java.util.ArrayList;
import java.util.HashMap;



import kr.co.cc.member.dto.MemberDTO;
import kr.co.cc.message.dto.MessageDTO;

public interface MessageDAO {

	ArrayList<MessageDTO> sendList();

	ArrayList<MemberDTO> search(HashMap<String, String> params);

	MessageDTO msdetail(String id);

}
