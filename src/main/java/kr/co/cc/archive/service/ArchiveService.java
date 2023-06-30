package kr.co.cc.archive.service;

import java.io.File;
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
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;


import kr.co.cc.archive.dao.ArchiveDAO;
import kr.co.cc.archive.dto.ArchiveDTO;
import kr.co.cc.message.dto.MessageDTO;


@Service
@MapperScan(value= {"kr.co.cc.archive.dao"})
public class ArchiveService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Value("${spring.servlet.multipart.location}") private String attachmentRoot;
	private final ArchiveDAO dao;
	
	public ArchiveService(ArchiveDAO dao){
		this.dao = dao;
	}

	@Value("${spring.servlet.multipart.location}") private String root;
	
	
	public ArrayList<ArchiveDTO> archivelist() {
		logger.info("자료실 dao 이동 슝슝");
		return dao.archivelist();
	}

	public String archiveWrite(MultipartFile[] attachment, HashMap<String, String> params, HttpSession session, Model model) {
		 String loginId = (String) session.getAttribute("loginId");
		 String page = "redirect:/archiveBoard.go";
		    logger.info("params: " + params);
		    logger.info("files: " + attachment);		 
		 
		        ArchiveDTO dto = new ArchiveDTO();
		        dto.setMember_id(loginId);
		        dto.setCategory(params.get("category"));
		        dto.setSubject(params.get("subject"));
		        dto.setContent(params.get("content"));

		        int row = dao.archiveWrite(dto);
		        logger.info("insert row: " + row);
		        int idx = dto.getId();

		        logger.info("idx: " + idx);

				if(row==1) { // 업로드된 자료실 게시물이 1이라면
					
					for (MultipartFile file : attachment) {
						
						logger.info("업로드할 file 있나요? :"+!file.isEmpty());
						
						if(!file.isEmpty()) {
							attachmentSave(idx, file, "자료실");
						}
						
						try { // 쓰레드 0.001초 지연으로 중복파일명 막자
							Thread.sleep(1);
						} catch (InterruptedException e) {
							e.printStackTrace();
						}
						
					}
				}

			
				page = "redirect:/archivedetail.do?id="+idx;
				
				
		    return page;
		}

	
	
	public ArchiveDTO archivedetail(int id, String flag) {
		if(flag.equals("detail")) {
			logger.info("if문 진입");
			dao.upHit(id); // 읽음 처리
			
		}
		
		return dao.archivedetail(id);
	}

	public ArrayList<String> archiveDetailFile(String id) {
		return dao.archiveDetailFile(id);
	}

	public String archiveUpdate(MultipartFile[] attachment, HashMap<String, String> params, ArrayList<String> removeFile, HttpSession session) {
			 
			logger.info("params : "+params);

			if(params.get("category")!=null) {
				String category_id = params.get("category");
				params.put("category_id", category_id);
			}
			if(params.get("subject")!=null) {
				String subject_id = params.get("subject");
				params.put("subject_id", subject_id);
			}
			if(params.get("content")!=null) {
				String content_id = params.get("content");
				params.put("content_id", content_id);
			}	

		        
			        int row = dao.archiveUpdate(params);
			        logger.info("insert row: " + row);
			        int idx = 0;

			        logger.info("idx: " + idx);

					if(row==1) { // 업로드된 자료실 게시물이 1이라면
						
						if(removeFile.size()>1) {
							attachmentRemove(removeFile);
						}
						
						idx = Integer.parseInt(params.get("id"));
						
						for (MultipartFile file : attachment) {
							
							logger.info("업로드할 file 있나요? :"+!file.isEmpty());
							
							if(!file.isEmpty()) {
								attachmentSave(idx, file, "자료실");
							}
							
							try { // 쓰레드 0.001초 지연으로 중복파일명 막자
								Thread.sleep(1);
							} catch (InterruptedException e) {
								e.printStackTrace();
							}
							
						}
					}
					
					
			    return "";
			}
	private void attachmentRemove(ArrayList<String> newFileName) {
		
		for (String FileName : newFileName) {// for 문으로 하나씩 담아서 
			logger.info(FileName);
			File file = new File(attachmentRoot+"/"+newFileName);// file 객체 생성 후 
			if(file.exists()) {// 파일이 존재하면 
				file.delete();// 파일을 삭제함
			}
			dao.removeFileName(FileName);
		}
		
	}

	private void attachmentSave(int id, MultipartFile file, String cls) {
		
		String oriFileName = file.getOriginalFilename();
		String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
		String newFileName = System.currentTimeMillis() + ext;
		logger.info("파일 업로드 : "+oriFileName+"=>"+newFileName+"으로 변경될 예정");
		
		try {
			byte[] bytes = file.getBytes();
			Path path = Paths.get(attachmentRoot+"/"+newFileName);
			Files.write(path, bytes);
			logger.info(newFileName+" upload 디렉토리에 저장 완료 !");
			
			dao.archivefileWrite(oriFileName, newFileName, cls, id);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}	
}


