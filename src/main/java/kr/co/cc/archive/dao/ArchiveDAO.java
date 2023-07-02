package kr.co.cc.archive.dao;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import kr.co.cc.archive.dto.ArchiveDTO;


public interface ArchiveDAO {

	ArrayList<ArchiveDTO> archivelist();

	int archiveWrite(ArchiveDTO dto);

	void archivefileWrite(String oriFileName, String newFileName, String cls, String id);

	void upHit(String id);

	ArchiveDTO archivedetail(String id);

	ArrayList<String> archiveDetailFile(String id);

	int archiveUpdate(HashMap<String, String> params, HttpSession session);

	void removeFileName(String fileName);

	void archivedelete(String id);

}
