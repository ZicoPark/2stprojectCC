package kr.co.cc.message.dao;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.cc.archive.dto.ArchiveDTO;
import kr.co.cc.member.dto.MemberDTO;
import kr.co.cc.message.dto.MessageDTO;

public interface MessageDAO {

	ArrayList<ArchiveDTO> sendList(int offset);

	ArrayList<MemberDTO> search(HashMap<String, String> params);

	MessageDTO msdetail(String id);

	int msWrite(MessageDTO dto);

	ArrayList<MessageDTO> receiveList(String id);

	boolean msdelete(String id);

	void msfileWrite(String oriFileName, String newFileName, String cls, String idx);

	void upHit(String id);

	 ArrayList<String> msDetailFile(String id);

	boolean msSelectDelete(String id);

	ArrayList<MessageDTO> msDeptList();

	ArrayList<MessageDTO> sendMemberchk(String id);

	ArrayList<MessageDTO> msDept();

	String selectFile(String id);

	MessageDTO logincheck(String loginId);

	int sendtotalCount();

	int sendtotalCountSearch(String search);

	ArrayList<ArchiveDTO> sendListSearch(HashMap<String, Object> params);



}
