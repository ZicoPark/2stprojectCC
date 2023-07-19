package kr.co.cc.freeBoard.controller;

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


import kr.co.cc.freeBoard.dto.FreeBoardDTO;
import kr.co.cc.freeBoard.service.FreeBoardService;

@Controller
public class FreeBoardController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired FreeBoardService service;
	
	@RequestMapping(value="/freeBoard.go")
    public String writePage() {
		

        return "freeBoardList";  
    }
	
	// 사내게시판 리스트 호출, 검색, 페이징
    @RequestMapping(value="/Freelist.ajax", method = RequestMethod.POST)
    @ResponseBody
    public HashMap<String, Object> list(HttpSession session, @RequestParam HashMap<String, Object> params){
    logger.info("사내게시판 리스트 호출");
       return service.Freelist(params);
    }

	// 사내게시판 작성 페이지 이동
	@RequestMapping(value="/freeWrite.go")
	public ModelAndView freeWriteForm() {
		
		return new ModelAndView("freeWriteForm");
	}
    
    
	// 사내게시판 작성
	@RequestMapping(value = "freeWrite.do", method = RequestMethod.POST)
	public String freeWrite(MultipartFile[] attachment, @RequestParam HashMap<String, String> params, HttpSession session, Model model) {
	    logger.info("params: " + params);
	    logger.info("컨트롤러 파일 첨부: " + attachment);

	    return service.freeWrite(attachment, params, session, model);
	}	
	
	// 사내게시판 상세보기
	@RequestMapping(value="/freedetail.do")
		public String freedetail(Model model, HttpSession session,@RequestParam String id) {
			
			logger.info("상세보기 사내게시판 번호 : "+id);
			String loginId = (String) session.getAttribute("id");
			FreeBoardDTO detailms = service.freedetail(id, "detail");
			FreeBoardDTO loginid = service.logincheck(loginId);
			String page = "freeDetail";

			
			
			if(detailms != null) {
				
				logger.info("if문 진입");
				ArrayList<String> detailfile = service.freeDetailFile(id);
				
				logger.info("detailFile :"+detailfile);
				
				page = "freeDetail";
				
				model.addAttribute("detailms", detailms);
				model.addAttribute("detailFile", detailfile);
				model.addAttribute("loginId", loginId);
				model.addAttribute("loginid", loginid);
			}	
			return page;
	}	
	
	
	// 게시글 삭제
    @RequestMapping(value = "/freeDelete.do")
    public String freeDelete(String id, Model model) throws Exception {
    	String page = "freeBoardList";
    	service.freeDelete(id);

       return page;
    }	
	
    
    // 게시글 수정
	@RequestMapping(value="/freeUpdate.go")
		public String freeUpdateForm(@RequestParam String id, @RequestParam String member_id, HttpSession session, Model model) {
		logger.info("게시글 수정 요청");

		
				FreeBoardDTO detailms = service.freedetail(id, "update");
				
				if(detailms != null) {
					ArrayList<String> detailfile = service.freeDetailFile(id);
					
					model.addAttribute("detailms", detailms);
					model.addAttribute("detailfile", detailfile);
			
				}

		return "freeUpdateForm";		
	}
	

	
	@RequestMapping(value = "/freeUpdate.do")
	public String freeUpdate(MultipartFile[] attachment, @RequestParam HashMap<String, String> params, 
								@RequestParam ArrayList<String> deletedFiles,
								HttpSession session, Model model) {
		
		logger.info("게시글 수정 하겠습니다");
		String page = "redirect:/freeBoard.go";
		String loginId = null;
		String id;
		logger.info("remove File : "+deletedFiles);
		if(session.getAttribute("id")!=null) {//로그인 상태이고 글 작성자와 동일하면
			loginId = (String) session.getAttribute("id");
			if(loginId.equals(params.get("member_id"))) {
				logger.info("컨트롤러 params : "+params);
				logger.info("attachment : "+attachment);
				logger.info("removeFile : "+deletedFiles);
				service.freeUpdate(attachment, params,deletedFiles);
				id =params.get("id");
				page = "redirect:/freedetail.do?id="+id;
			}
		}		
		
		
	    return page;
	}		
	
	
	
	
	
    @RequestMapping(value="/replyList.ajax", method = RequestMethod.POST)
    @ResponseBody
    public HashMap<String, Object> replyList(HttpSession session, @RequestParam HashMap<String, Object> params){
    	logger.info("댓글 리스트 호출");
    	logger.info("params : "+params);
       return service.replyList(session, params);
    }	
	
	
	// 댓글 작성하기
	@RequestMapping(value="/replyWrite.do", method = RequestMethod.POST)
	public String postWrite(FreeBoardDTO dto, @RequestParam("free_board_id") String free_board_id, HttpSession session) {
	    String id = (String) session.getAttribute("id");
	    
	    dto.setMember_id(id);
	    dto.setFree_board_id(free_board_id);
	    
	    service.postWrite(dto);
	    return "redirect:/freedetail.do?id=" + dto.getFree_board_id();
	}

	
	
	// 댓글 단일 조회
	@RequestMapping(value = "/replyModify.go", method = RequestMethod.GET)
	public String getModify(Model model,@RequestParam String id, @RequestParam("free_board_id") String free_board_id, HttpSession session) throws Exception {
		
		String userId = null;
		String page = "redirect://freedetail.do?id="+id;
		String msg = "해당 회원이 아닙니다. 상세보기로 이동합니다.";
		FreeBoardDTO dto = new FreeBoardDTO();
		if(session.getAttribute("id")!=null) {//로그인 상태이고 글 작성자와 동일하면
			userId = (String) session.getAttribute("id");
		dto.setMember_id(userId);
		dto.setId(id);
		dto.setFree_board_id(free_board_id);
		
		FreeBoardDTO reply = service.replySelect(dto);
		
		model.addAttribute("reply", reply);
		page = "freeReplyModify";
		} else {
			
			model.addAttribute("msg", msg);
		}
		return page;
	}
	
	// 댓글 수정
	@RequestMapping(value="/commentUpdate.ajax", method = RequestMethod.POST)
    @ResponseBody
    public HashMap<String, Object> commentUpdate(@RequestParam HashMap<String, Object> params){
		logger.info("id : " + params.get("id"));
		logger.info("content : " + params.get("content"));
		
		logger.info("params : "+params);
		service.commentUpdate(params);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("success", true); // ajax 에서 success 였을 때 넘어가는 데이터가 map
		return map; 
    }
	
	
	// 댓글 삭제
    @RequestMapping(value = "/replyDelete.do")
    public String replyDelete(String id, String free_board_id) throws Exception {
    	
    	service.replyDelete(id,free_board_id);
       return "redirect:/freedetail.do?id="+free_board_id;
    }	

	
}
