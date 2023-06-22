package kr.co.cc.doc.dao;

import java.util.ArrayList;

import kr.co.cc.doc.dto.ApprovalDTO;
import kr.co.cc.doc.dto.DocFormDTO;
import kr.co.cc.doc.dto.MemberDTO;

public interface DocDAO {

	ArrayList<DocFormDTO> docFormCall();

	ArrayList<ApprovalDTO> approvalKindCall();

	ArrayList<MemberDTO> memberListCall();

	MemberDTO getMemberInfo(String loginId);

}
