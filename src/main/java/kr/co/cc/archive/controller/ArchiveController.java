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
import org.springframework.web.bind.annotation.ResponseBody;
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
	public String archiveBoard() {
		logger.info("자료실 이동");
	
		return "archiveBoardList";
	}

    @RequestMapping(value="/archivelist.ajax", method = RequestMethod.POST)
    @ResponseBody
    public HashMap<String, Object> list(HttpSession session, @RequestParam HashMap<String, Object> params){
    logger.info("자료실 리스트 호출");
       return service.archivelist(session, params);
    }	
	
	
	
	// 자료실 작성 페이지 이동
	@RequestMapping(value="/archiveWrite.go")
	public ModelAndView msWriteForm() {
		
		return new ModelAndView("archiveWriteForm");
	}
	
	// 자료실 작성
	@RequestMapping(value = "archiveWrite.do", method = RequestMethod.POST)
	public String archiveWrite(MultipartFile[] attachment, @RequestParam HashMap<String, String> params, HttpSession session, Model model) {
	    logger.info("params: " + params);
	    logger.info("컨트롤러 파일 첨부: " + attachment);

	    return service.archiveWrite(attachment, params, session, model);
	}	

	// 게시글 상세보기
	@RequestMapping(value="/archivedetail.do")
		public String archivedetail(Model model, HttpSession session,@RequestParam String id) {
			
			logger.info("상세보기 자료실 번호 : "+id);
			String loginId = (String) session.getAttribute("id");
			ArchiveDTO detailms = service.archivedetail(id, "detail");
			ArchiveDTO loginid = service.logincheck(loginId);
			String page = "redirect:/archiveBoard.go";
			
			if(detailms != null) {
				
				logger.info("if문 진입");
				ArrayList<String> detailfile = service.archiveDetailFile(id);
				
				logger.info("detailFile :"+detailfile);
				
				page = "archiveDetail";
				model.addAttribute("detailms", detailms);
				model.addAttribute("detailFile", detailfile);
				model.addAttribute("loginId", loginId);
				model.addAttribute("loginid", loginid);
			}	
			return page;
	}
	
	// 게시글 업데이트
	@RequestMapping(value="/archiveUpdate.go")
		public String archiveUpdateForm(@RequestParam String id, @RequestParam String member_id, HttpSession session, Model model) {
		logger.info("게시글 수정 요청");
		String page = "archiveBoardList";
				ArchiveDTO detailms = service.archivedetail(id, "update");
				
				if(detailms != null) {
					ArrayList<String> detailfile = service.archiveDetailFile(id);
					
					model.addAttribute("detailms", detailms);
					model.addAttribute("detailfile", detailfile);
					page = "archiveUpdateForm";
				}

		
		return page;		
}

	@RequestMapping(value = "/archiveUpdate.do")
	public String archiveUpdate(MultipartFile[] attachment, @RequestParam HashMap<String, String> params, 
								@RequestParam ArrayList<String> deletedFiles,
								HttpSession session, Model model) {
		
		logger.info("게시글 수정 하겠습니다");
		String page = "redirect:/archiveBoard.go";
		String loginId = null;
		String id;
		logger.info("remove File : "+deletedFiles);
		if(session.getAttribute("id")!=null) {//로그인 상태이고 글 작성자와 동일하면
			loginId = (String) session.getAttribute("id");
			if(loginId.equals(params.get("member_id"))) {
				logger.info("컨트롤러 params : "+params);
				logger.info("attachment : "+attachment);
				logger.info("removeFile : "+deletedFiles);
				service.archiveUpdate(attachment, params,deletedFiles);
				id =params.get("id");
				page = "redirect:/archivedetail.do?id="+id;
			}
		}		
		
		
	    return page;
	}	

	@RequestMapping(value = "/archivedelete.do", method = RequestMethod.GET)
	public String archivedelete(Model model, HttpSession session, @RequestParam HashMap<String, String> params) {
		
		String page = "redirect:/archiveBoard.go";
		
		

				String id = params.get("id");
				service.archivedelete(id);
				page = "redirect:/archiveBoard.go";

	
		return page;
	}	
	
	
}
