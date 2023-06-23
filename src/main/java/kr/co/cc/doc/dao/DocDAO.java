package kr.co.cc.doc.dao;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.cc.doc.dto.ApprovalDTO;
import kr.co.cc.doc.dto.DocDTO;
import kr.co.cc.doc.dto.DocFormDTO;
import kr.co.cc.doc.dto.MemberDTO;

public interface DocDAO {

	ArrayList<DocFormDTO> docFormCall();

	ArrayList<ApprovalDTO> approvalKindCall();

	ArrayList<MemberDTO> memberListCall();

	MemberDTO getMemberInfo(String loginId);

	int docWrite(HashMap<String, String> params);

	int docWrite(DocDTO dto);

	void attachmentSave(String oriFileName, String newFileName, int id, String cls);

}
