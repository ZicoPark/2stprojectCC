package kr.co.cc.message.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import kr.co.cc.archive.dto.ArchiveDTO;
import kr.co.cc.member.dto.MemberDTO;
import kr.co.cc.message.dto.MessageDTO;

public interface MessageDAO {

	ArrayList<MessageDTO> sendList(int offset, String loginId);

	ArrayList<MemberDTO> search(HashMap<String, String> params);

	MessageDTO msdetail(String id);

	int msWrite(MessageDTO dto);



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

	int sendtotalCount(String loginId);

	int sendtotalCountSearch(String search, String loginId);

	ArrayList<MessageDTO> sendListSearch(HashMap<String, Object> params);

	void msNotice(String send_id, String recieveId, String type, String identifyValue);


	List<HashMap<String, Object>> MemberByDept(String dept);

	int msremovetotalCount(String loginId);

	int msremoveCountSearch(String search, String loginId);

	ArrayList<MessageDTO> msremovedList(int offset, String loginId);

	ArrayList<MessageDTO> msremoveListSearch(HashMap<String, Object> params);

	int receivetotalCount(String loginId);

	int receivetotalCountSearch(String search, String loginId);

	ArrayList<MessageDTO> receiveList(int offset, String loginId);

	ArrayList<MessageDTO> receiveListSearch(HashMap<String, Object> params);

	MessageDTO msSenddetail(String id);

	void readMessage(String id, String loginId);

	String msReplyMember(String fromId);





}
