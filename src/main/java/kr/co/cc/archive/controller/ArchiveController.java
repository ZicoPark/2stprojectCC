package kr.co.cc.archive.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.archive.dto.ArchiveDTO;
import kr.co.cc.archive.service.ArchiveService;
import kr.co.cc.message.dto.MessageDTO;


@Controller
public class ArchiveController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired ArchiveService service;
	
	@RequestMapping(value="/archiveBoard.go")
	public ModelAndView archiveBoard() {
		logger.info("자료실 이동");
		ModelAndView mav = new ModelAndView("archiveBoardList") ;
	
			ArrayList<ArchiveDTO> list = service.archivelist();
			logger.info("list cnt" + list.size());
			mav.addObject("list", list);
			
		return mav;
	}

	// 자료실 작성 페이지 이동
	@RequestMapping(value="/archiveWrite.go")
	public ModelAndView msWriteForm() {
		
		return new ModelAndView("archiveWriteForm");
	}
	
	// 자료실 작성
	@RequestMapping(value = "archiveWrite.do", method = RequestMethod.POST)
	public String archiveWrite(MultipartFile file, @RequestParam HashMap<String, String> params, HttpSession session) {
	    logger.info("params: " + params);
	    logger.info("컨트롤러 파일 첨부: " + file);

	    return service.archiveWrite(file, params, session);
	}	

	// 게시글 상세보기
	@RequestMapping(value="/archivedetail.do")
		public String archivedetail(Model model, @RequestParam String id) {
			
			logger.info("상세보기 자료실 번호 : "+id);
			
			ArchiveDTO detailms = service.archivedetail(Integer.parseInt(id), "detail");
			String page = "redirect:/msSendList.go";
			
			if(detailms != null) {
				
				logger.info("if문 진입");
				String detailfile = service.archiveDetailFile(Integer.parseInt(id));
				
				logger.info("detailFile :"+detailfile);
				
				page = "archiveDetail";
				model.addAttribute("detailms", detailms);
				model.addAttribute("detailFile", detailfile);
				
			}	
			return page;
	}
	
}
