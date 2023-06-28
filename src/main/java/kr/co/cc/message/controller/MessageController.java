package kr.co.cc.message.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.annotation.RequestScope;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.message.dto.MessageDTO;
import kr.co.cc.message.service.MessageService;

@Controller
public class MessageController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Value("${spring.servlet.multipart.location}") private String root;
	
	@Autowired MessageService service;
	
	// 쪽지 작성 페이지 이동
	@RequestMapping(value="/msWrite.go")
	public ModelAndView msWriteForm() {
		
		return new ModelAndView("compose");
	}
	
	// 쪽지 작성
	@RequestMapping(value = "/msWrite.do", method = RequestMethod.POST)
	public String msWrite(MultipartFile file, @RequestParam("to_id") String[] toIds, @RequestParam HashMap<String, String> params, HttpSession session) {
	    logger.info("params: " + params);
	    logger.info("컨트롤러 파일 첨부: " + file);

	    return service.msWrite(file, toIds, params, session);
	}

	
	// 받은 쪽지 상세보기
	@RequestMapping(value="/msRcDetail.do")
		public String msRcDetail(Model model, @RequestParam String id) {
			
			logger.info("상세보기 쪽지 번호 : "+id);
			
			MessageDTO detailms = service.msdetail(Integer.parseInt(id), "detail");
			String page = "redirect:/msSendList.go";
			
			if(detailms != null) {
				
				logger.info("if문 진입");
				String detailfile = service.msDetailFile(Integer.parseInt(id));
				
				logger.info("detailFile :"+detailfile);
				
				page = "MessageReceiveDetail";
				model.addAttribute("detailms", detailms);
				model.addAttribute("detailFile", detailfile);
				
			}
			
			
			return page;
		}
	
	
	// 보낸 쪽지 상세보기
	@RequestMapping(value="/msSendDetail.do")
		public String msSendDetail(Model model, @RequestParam String id) {
			
			logger.info("상세보기 쪽지 번호 : "+id);
			
			MessageDTO detailms = service.msdetail(Integer.parseInt(id), "detail");
			String page = "redirect:/msSendList.go";
			
			if(detailms != null) {
				
				logger.info("if문 진입");
				String detailfile = service.msDetailFile(Integer.parseInt(id));
				
				logger.info("detailFile :"+detailfile);
				
				page = "MessageSendDetail";
				model.addAttribute("detailms", detailms);
				model.addAttribute("detailFile", detailfile);
				
			}
			
			
			return page;
		}
	
	
	// 파일 다운로드
	@GetMapping(value="/msdownload.do")
	public ResponseEntity<Resource> download(String path) {
		
		Resource body = new FileSystemResource(root+"/"+path);//BODY		
		HttpHeaders header = new HttpHeaders();//Header
		try {						
			String fileName = "이미지"+path.substring(path.lastIndexOf("."));
			// 한글 파일명은 깨질수 있으므로 인코딩을 한번 해 준다.
			fileName = URLEncoder.encode(fileName, "UTF-8");
			// text/... 은 문자열, image/... 이미지, application/octet-stream 은 바이너리 데이터
			header.add("Content-type", "application/octet-stream");
			// content-Disposition 은 내려보낼 내용이 문자열(inline)인지 파일(attatchment)인지 알려준다. 
			header.add("content-Disposition", "attatchment;fileName=\""+fileName+"\"");
		} catch (IOException e) {
			e.printStackTrace();
		}
			
		//body, header, status
		return new ResponseEntity<Resource>(body, header, HttpStatus.OK);
	}
	
	// 보낸 쪽지함 이동
	@RequestMapping(value="/msSendList.go")
	public String msSendList(Model model,HttpSession session) {
		logger.info("보낸 쪽지함 이동");
		ArrayList<MessageDTO> sendList = service.sendList(session);
		
		model.addAttribute("list", sendList);
		return "msSendList";
	}	
	
	@RequestMapping(value="/search.do", method= {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView search(@RequestParam HashMap<String, String>params) {
		logger.info("search params : "+params);
		
		return service.search(params);
		
	}

	// 받은 쪽지함 이동
	@RequestMapping(value="/msReceiveList.go")
	public String msReceiveList(Model model,HttpSession session) {
		logger.info("받은 쪽지함 이동");
		ArrayList<MessageDTO> receiveList = service.receiveList(session);
		model.addAttribute("list", receiveList);
		return "msReceiveList";
	}	

	// 답장 작성 페이지 이동
	@RequestMapping(value = "/msReply.go")
	public ModelAndView msReplyForm(Model model, @RequestParam("to_id") String fromId) {
	    // from_id 값을 가져와서 모델에 추가
	    model.addAttribute("fromId", fromId);

	    return new ModelAndView("msReply");
	}
    
    // 답장 작성
    @RequestMapping(value = "/msReply.do", method = RequestMethod.POST)
    public String msReply(MultipartFile file, @RequestParam HashMap<String, String> params, HttpSession session) {
        logger.info("컨트롤러 파일 첨부: " + file);
        
        return service.msReply(file, params, session);
    }
	
	
	// 쪽지 삭제
    @RequestMapping(value = "/msDelete.do")
    public String msDelete(String id) throws Exception {
    	service.msDelete(id);
       return "redirect:/msReceiveList.go";
    }	
    
    // 쪽지 작성 -> 주소록
	@RequestMapping(value = "/msMemberList.go")
	public ModelAndView msMemberList() {
		return service.msMemberList();
	}

	
	// 체크박스 선택 삭제
    @RequestMapping(value = "/msSelectDelete", method = RequestMethod.GET)
    public String postdelete(String id) throws Exception {
    	service.msSelectDelete(id);
       return "redirect:/adsaleslist.do";
    }	
	

	
    @RequestMapping(value = "/msSelectDelete")
    public String ajaxTest(HttpServletRequest request) throws Exception {

        String[] ajaxMsg = request.getParameterValues("valueArr");
        int size = ajaxMsg.length;
       
        for(int i=0; i<size; i++) {
        	service.msSelectDelete(ajaxMsg[i]);
        	
        }
        return "redirect:/msSendList.go";
    }
	
}
