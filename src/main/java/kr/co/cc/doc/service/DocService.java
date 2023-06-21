package kr.co.cc.doc.service;

import java.util.ArrayList;
import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.co.cc.doc.dao.DocDAO;
import kr.co.cc.doc.dto.DocFormDTO;

@Service
@MapperScan(value={"kr.co.cc.doc.dao"})
public class DocService {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private final DocDAO dao;
	
	public DocService(DocDAO dao){
		this.dao = dao;
	}

	public ArrayList<DocFormDTO> docFormCall() {

		return dao.docFormCall();
	}
	
}
