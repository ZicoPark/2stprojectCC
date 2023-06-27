package kr.co.cc.message.dao;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.cc.admin.dto.AdminDTO;
import kr.co.cc.member.dto.MemberDTO;
import kr.co.cc.message.dto.MessageDTO;

public interface MessageDAO {

	ArrayList<MessageDTO> sendList(String id);

	ArrayList<MemberDTO> search(HashMap<String, String> params);

	MessageDTO msdetail(int id);

	int msWrite(MessageDTO dto);

	ArrayList<MessageDTO> receiveList(String id);

	boolean msdelete(String id);

	void msfileWrite(String oriFileName, String newFileName, String cls, int id);

	void upHit(int id);

	String msDetailFile(int id);

	ArrayList<AdminDTO> msMemberList();

	boolean msSelectDelete(String id);

}
