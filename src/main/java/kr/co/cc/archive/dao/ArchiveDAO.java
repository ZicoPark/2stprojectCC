package kr.co.cc.archive.dao;

import java.util.ArrayList;

import kr.co.cc.archive.dto.ArchiveDTO;


public interface ArchiveDAO {

	ArrayList<ArchiveDTO> archivelist();

	int archiveWrite(ArchiveDTO dto);

	void archivefileWrite(String fileName, String newFileName, String classification, int idx);

	void upHit(int id);

	ArchiveDTO archivedetail(int id);

	String archiveDetailFile(int id);

}
