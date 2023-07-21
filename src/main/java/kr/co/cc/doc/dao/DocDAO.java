package kr.co.cc.doc.dao;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.cc.doc.dto.ApprovalDTO;
import kr.co.cc.doc.dto.AttachmentDTO;
import kr.co.cc.doc.dto.DocDTO;
import kr.co.cc.doc.dto.DocFormDTO;
import kr.co.cc.doc.dto.MemberDTO;

public interface DocDAO {

	ArrayList<ApprovalDTO> getApprovalList();
	
	ArrayList<HashMap<String, String>> getMemberList();
	
	ArrayList<DocFormDTO> getDocFormList();

	HashMap<String, String> getDeptMap(String deptId);

	MemberDTO getMemberInfo(String loginId);

	HashMap<String, String> getJobLevelMap(String jobLevelId);
	
	String getMemberSignFilePath(String memberId);
	
	String getApprovalName(String approvalPriority);
	
	void attachmentSave(String attachmentId, String oriFileName, String classification, String identifyValue);

	int docWrite(DocDTO dto);

	DocDTO getWritedDoc(String docId);
	
	String getApprovalId(String approvalPriority);
	
	void approvalWrite(HashMap<String, Object> docStatusMap);
	
	void docNotice(String sendId, String receiveId, String type, String identifyValue);

	void docWriteETC(String id, String dateWritedContent);

	ArrayList<DocDTO> getDocList(String loginId, int status);

	ArrayList<AttachmentDTO> getAttachmentList(String docId);
	
	int docDelete(String docId);
	
	DocFormDTO getDocForm(String doc_form_id);
	
	int docAttachmentDelete(String attachmentId);
	
	int docUpdate(HashMap<String, String> params);

	ArrayList<HashMap<String, String>> getRequestDocList(String loginId);

	HashMap<String, String> requestDocDetail(String docId);
	
	String getFirstReadChk(String docId);

	ArrayList<HashMap<String, String>> requestDocWaitList(String loginId);

	void readCheckUpdate(String docId, String loginId);

	void readTimeUpdate(String docId, String loginId, String currentTime);
	
	ApprovalDTO getApprovalDTO(HashMap<String, String> params);

	void requestDocApproval(HashMap<String, String> params);

	int docStatusDelete(String docId);

	ArrayList<HashMap<String, String>> getObjectionDocList(String loginId);

	HashMap<String, String> objectionDocDetail(String docId);
	
	int objectionDocBlind(String docId, String loginId);

	ArrayList<HashMap<String, String>> getDocStatusList(String docId);
	
	int getNextApprovalMemberRow(String string);

	String getNextApprovalMemberId(String docId);

	ArrayList<HashMap<String, String>> getCompleteDocList(String loginId);

	HashMap<String, String> completeDocDetail(String docId, String loginId);

	ArrayList<HashMap<String, String>> getDeptList();

	int totalCount(String deptId, String opt, String text);
	
	ArrayList<HashMap<String, String>> getRegisteredDocList(String loginId, String deptId, String opt, String text, int cnt, int offset);

	HashMap<String, String> registeredDocDetail(String docId);

	void changeNoticeStatus(String loginId, String type, String docId);

	String getDefaultDocForm(String docFormId);

}
