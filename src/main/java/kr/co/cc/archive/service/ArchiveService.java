package kr.co.cc.archive.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.cc.archive.dao.ArchiveDAO;
import kr.co.cc.archive.dto.ArchiveDTO;
import kr.co.cc.message.dto.MessageDTO;


@Service
@MapperScan(value= {"kr.co.cc.noticeBoard.dao"})
public class ArchiveService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	private final ArchiveDAO dao;
	
	public ArchiveService(ArchiveDAO dao){
		this.dao = dao;
	}

	@Value("${spring.servlet.multipart.location}") private String root;
	
	
	public ArrayList<ArchiveDTO> archivelist() {
		logger.info("자료실 dao 이동 슝슝");
		return dao.archivelist();
	}

	public String archiveWrite(MultipartFile file, HashMap<String, String> params, HttpSession session) {
		 String loginId = (String) session.getAttribute("loginId");
		 
		    logger.info("params: " + params);
		    logger.info("files: " + file);		 
		 
		        ArchiveDTO dto = new ArchiveDTO();
		        dto.setMember_id(loginId);
		        dto.setCategory(params.get("category"));
		        dto.setSubject(params.get("subject"));
		        dto.setContent(params.get("content"));

		        int row = dao.archiveWrite(dto);
		        logger.info("insert row: " + row);
		        int idx = dto.getId();

		        logger.info("insert row: " + row);
		        logger.info("idx: " + idx);

		        if (file != null && !file.isEmpty()) {
		            // 입력받은 파일 이름
		            String fileName = file.getOriginalFilename();
		            // 확장자를 추출하기 위한 과정
		            String ext = fileName.substring(fileName.lastIndexOf("."));
		            // 새로운 파일 이름은?
		            String newFileName = System.currentTimeMillis() + ext;
		            String classification = "자료실";
		            try {
		                byte[] bytes = file.getBytes();

		                Path path = Paths.get(root + "/" + newFileName);
		                Files.write(path, bytes);
		                dao.archivefileWrite(fileName, newFileName, classification, idx);
		            } catch (IOException e) {
		                e.printStackTrace();
		            }
		        }
		    

		    return "archiveBoardList";
		}

	public ArchiveDTO archivedetail(int id, String flag) {
		if(flag.equals("detail")) {
			logger.info("if문 진입");
			dao.upHit(id); // 읽음 처리
			
		}
		
		return dao.archivedetail(id);
	}

	public String archiveDetailFile(int id) {
		return dao.archiveDetailFile(id);
	}

}
