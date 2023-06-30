package kr.co.cc.archive.dao;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.cc.archive.dto.ArchiveDTO;


public interface ArchiveDAO {

	ArrayList<ArchiveDTO> archivelist();

	int archiveWrite(ArchiveDTO dto);

	void archivefileWrite(String oriFileName, String newFileName, String cls, int idx);

	void upHit(int id);

	ArchiveDTO archivedetail(int id);

	ArrayList<String> archiveDetailFile(String id);

	int archiveUpdate(HashMap<String, String> params);

	void removeFileName(String fileName);

}
