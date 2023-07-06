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

	HashMap<String, String> getJobLevelMap(String job_level_id);
	
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

	ArrayList<AttachmentDTO> getAttachmentList(String id);
	
	int docDelete(String docId);
	
	DocFormDTO getDocForm(String doc_form_id);
	
	int attachmentDelete(String attachmentId);
	
	int docUpdate(HashMap<String, String> params);

	ArrayList<HashMap<String, String>> getRequestDocList(String loginId);

	HashMap<String, String> requestDocDetail(String docId);
	
	String getWithDrawChk(String docId);

	ArrayList<HashMap<String, String>> requestDocWaitList(String loginId);

	void readCheckUpdate(String docId, String loginId);

	void readTimeUpdate(String docId, String loginId, String currentTime);
	
	ApprovalDTO getApprovalDTO(HashMap<String, String> params);

	void requestDocApproval(HashMap<String, String> params);

	



	

	

	

	

	

	

	

	

	



	

}
