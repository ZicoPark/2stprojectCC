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

	DocDTO getWritedDoc(String uuid);
	
	String getApprovalId(String approvalPriority);
	
	void approvalWrite(HashMap<String, Object> docStatusMap);
	
	void docNotice(String sendId, String receiveId, String type, String identifyValue);

	void docWriteETC(String id, String dateWritedContent);

	ArrayList<DocDTO> getDocList(String loginId, int status);

	ArrayList<AttachmentDTO> getAttachmentList(String id);
	
	DocFormDTO getDocForm(String doc_form_id);
	
	int attachmentDelete(String attachmentId);
	
	int docUpdate(HashMap<String, String> params);

	

	

	

	

	

	

	

	



	

}
