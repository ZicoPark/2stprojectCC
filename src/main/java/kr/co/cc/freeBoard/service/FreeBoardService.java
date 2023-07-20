package kr.co.cc.freeBoard.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import kr.co.cc.freeBoard.dao.FreeBoardDAO;
import kr.co.cc.freeBoard.dto.FreeBoardDTO;


@Service
@MapperScan(value= {"kr.co.cc.freeBoard.dao"})
public class FreeBoardService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Value("${spring.servlet.multipart.location}") private String attachmentRoot;
	private final FreeBoardDAO dao;
	
	public FreeBoardService(FreeBoardDAO dao){
		this.dao = dao;
	}

	@Value("${spring.servlet.multipart.location}") private String root;	

	public HashMap<String, Object> Freelist(HashMap<String, Object> params) {
		int page = Integer.parseInt(String.valueOf(params.get("page")));
	    String search = String.valueOf(params.get("search"));

	    
	    HashMap<String, Object> map = new HashMap<String, Object>();

	    int offset = 10*(page-1);	    
		
	    logger.info("offset : " + offset);
	    
	    logger.info("params : " + params);
	    
	    int total = 0;	    
		
	    if(search.equals("default") || search.equals("")) {
	      
	    	  total = dao.totalCount();

	      	}else {	      
	    	   	   
	    	  total = dao.totalCountSearch(search);
	       }
	    
	    int range = total%10  == 0 ? total/10 : total/10+1;

	      page = page>range ? range:page;
	      
	      ArrayList<FreeBoardDTO> list = null;
	      
	      params.put("offset", offset);
			
	      logger.info("user search:"+search);
	      
	      if(search.equals("default") ||search.equals("")) {

	          list = dao.freelist(offset);
	       
	     
	      }else {

	         list = dao.freelistSearch(params);
	      }
	      		
		
	      //logger.info("list size : "+ list.size());
	      map.put("list", list);
	      map.put("currPage", page);	      
	      map.put("pages", range);

	
		return map;

	}

	public String freeWrite(MultipartFile[] attachment, HashMap<String, String> params, HttpSession session,
			Model model) {
		 String id = (String) session.getAttribute("id");
		 String page = "redirect:/freeBoard.go";
		    logger.info("params: " + params);
		    logger.info("files: " + attachment);		 
		 
		    FreeBoardDTO dto = new FreeBoardDTO();
		        dto.setMember_id(id);
		        dto.setSubject(params.get("subject"));
		        dto.setContent(params.get("content"));

		        int row = dao.freeWrite(dto);
		        logger.info("insert row: " + row);
		        String idx = dto.getId();


		        logger.info("idx: " + idx);

				if(row==1) { // 업로드된 자료실 게시물이 1이라면
					
					for (MultipartFile file : attachment) {
						
						logger.info("업로드할 file 있나요? :"+!file.isEmpty());
						
						if(!file.isEmpty()) {
							attachmentSave(idx, file, "게시판");
						}
						
						try { // 쓰레드 0.001초 지연으로 중복파일명 막자
							Thread.sleep(1);
						} catch (InterruptedException e) {
							e.printStackTrace();
						}
						
					}
				}

			
				page = "redirect:/freedetail.do?id="+idx;
				
				
		    return page;
		}

		private void attachmentSave(String id, MultipartFile file, String cls) {
			
			String oriFileName = file.getOriginalFilename();
			String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
			UUID uuid = UUID.randomUUID();
			String newFileName = uuid.toString() + ext;
			logger.info("파일 업로드 : "+oriFileName+"=>"+newFileName+"으로 변경될 예정");
			
			try {
				byte[] bytes = file.getBytes();
				Path path = Paths.get(attachmentRoot+"/"+newFileName);
				Files.write(path, bytes);
				logger.info(newFileName+" upload 디렉토리에 저장 완료 !");
				
				dao.freefileWrite(oriFileName, newFileName, cls, id);
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}

		public FreeBoardDTO freedetail(String id, String flag) {
			if(flag.equals("detail")) {
				logger.info("if문 진입");
				dao.freeupHit(id); // 읽음 처리
				
			}
			
			return dao.freedetail(id);
		}

		public ArrayList<String> freeDetailFile(String id) {
			return dao.freeDetailFile(id);
		}

		public FreeBoardDTO logincheck(String loginId) {
			
			return dao.logincheck(loginId);
		}


		public void postWrite(FreeBoardDTO dto) {
			
			dao.postWrite(dto);
		}	
	
		// 단일 댓글 조회
		public FreeBoardDTO replySelect(FreeBoardDTO dto) throws Exception {
		    return dao.replySelect(dto);
		}

		// 수정 - public HashMap<String, Object>은 select 일때만 
		// org.apache.ibatis.binding.BindingException: Mapper method 'kr.co.cc.freeBoard.dao.FreeBoardDAO.commentUpdate' has an unsupported return type: class java.util.HashMap
		public void commentUpdate(HashMap<String, Object> params) {
			
			logger.info("서비스 댓글 업데이트!");
			dao.commentUpdate(params);
		}

		public HashMap<String, Object> replyList(HttpSession session, HashMap<String, Object> params) {
			
			int page = Integer.parseInt(String.valueOf(params.get("page")));
		 
		    String loginId = (String) session.getAttribute("id");
		    FreeBoardDTO loginid = dao.logincheck(loginId);
		    
		    HashMap<String, Object> map = new HashMap<String, Object>();

		    int offset = 10*(page-1);	    
			
		    logger.info("offset : " + offset);
		    params.put("offset", offset);
		    logger.info("params : " + params);
		       

		    int total = dao.replyTotalCount();

		    int range = total%10  == 0 ? total/10 : total/10+1;

		      page = page>range ? range:page;
		      
		      ArrayList<FreeBoardDTO> list = null;
		      
		      params.put("offset", offset);
				
		      logger.info("서비스 params : "+params);
		      list = dao.replyList(params);

		      //logger.info("list size : "+ list.size());
		      map.put("list", list);
		      map.put("currPage", page);	      
		      map.put("loginid",loginid);
		      map.put("pages", range);
		
			return map;
		}

		public boolean replyDelete(String id, String free_board_id) {
			logger.info("freeboard 댓글 삭제 요청"); 
			return dao.replyDelete(id,free_board_id);
			
		}

		public boolean freeDelete(String id) {
		
			return dao.freeDelete(id);
			
		}

		public int freeUpdate(MultipartFile[] attachment, HashMap<String, String> params,
				ArrayList<String> deletedFiles) {
			logger.info("params : "+params);
	        
	        int row = dao.freeUpdate(params);
	        logger.info("insert row: " + row);
	        String id = "";
	        logger.info("update params :"+params);
	        logger.info("서비스 deletedFiles 있나요 : "+deletedFiles);

			if(row>0) { // 업로드된 자료실 게시물이 1이라면
				
				if(deletedFiles.size()>0) {
					attachmentRemove(deletedFiles);
				}
				
				id = params.get("id");
				logger.info("update idx: " + id);
				
				for (MultipartFile file : attachment) {
					
					logger.info("업로드할 file 있나요? :"+!file.isEmpty());
					
					if(!file.isEmpty()) {
						attachmentSave(id, file, "게시판");
					}
					
					try { // 쓰레드 0.001초 지연으로 중복파일명 막자
						Thread.sleep(1);
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
					
				}
			}

			
	    return row;
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
