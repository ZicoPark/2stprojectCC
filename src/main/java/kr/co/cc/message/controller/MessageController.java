package kr.co.cc.message.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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

import jdk.javadoc.doclet.DocletEnvironment.ModuleMode;
import kr.co.cc.message.dto.MessageDTO;
import kr.co.cc.message.service.MessageService;

@Controller
public class MessageController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Value("${spring.servlet.multipart.location}") private String root;
	
	@Autowired MessageService service;
	
	// 쪽지 작성 페이지 이동
	@RequestMapping(value="/msWrite.go")
	public ModelAndView msWriteForm(Model model) {
		ArrayList<MessageDTO> DeptList = service.msDeptList();
		ArrayList<MessageDTO> dept = service.msDept();

		model.addAttribute("dept",dept);
		model.addAttribute("DeptList", DeptList);
		return new ModelAndView("MessageWriteForm2");
	}
	
	// 부서 선택시 사원 표시
	@RequestMapping(value="/MemberByDept.ajax")
	@ResponseBody
	public List<HashMap<String, Object>> memberByDept(@RequestParam String dept) {
	    logger.info("부서 선택 사원");
	    logger.info("dept deptName: " + dept);
	    return service.memberByDept(dept);
	}

	
	
	//주소록 사원 선택값 보내기
	@RequestMapping(value = "/chk.send")
	public String sendMemberajax(@RequestParam("valueArr") String[] valueArr, Model model) throws Exception {
	    List<String> memList = new ArrayList<>();

	    for (String value : valueArr) {
	        List<MessageDTO> mem = service.sendMemberchk(value);
	        logger.info("mem: " + mem);
	        for (MessageDTO member : mem) {
	            memList.add(member.toString()); // DTO 객체를 String으로 변환하여 추가
	        }
	    }

	    model.addAttribute("memList", memList);
	    logger.info("memList: " + memList);

	    return "forward:/msWrite.do";
	}

	
	// 쪽지 작성
	@RequestMapping(value = "/msWrite.do", method = RequestMethod.POST)
	public String msWrite(MultipartFile file, @RequestParam("to_id") String[] toIds, @RequestParam HashMap<String, String> params, HttpSession session,Model model) {
	    logger.info("params: " + params);
	    logger.info("컨트롤러 파일 첨부: " + file);

		/*
		 * List<String> memList = (List<String>) model.getAttribute("memList");
		 * model.addAttribute("memList", memList);
		 */
	    
	    return service.msWrite(file, toIds, params, session);
	}

	
    @RequestMapping(value = "/chk.send", method = RequestMethod.GET)
    public String sendMemberchk(String id) throws Exception {
    	service.sendMemberchk(id);
       return "redirect:/msWrite.go";
    }

	
	// 받은 쪽지 상세보기
	@RequestMapping(value="/msRcDetail.do")
		public String msRcDetail(Model model, @RequestParam String id, @RequestParam String type ,HttpSession session) {
			
			logger.info("상세보기 쪽지 번호 : "+id);
			
			   if(type.equals("alarm")) {
				   service.readMessage(id, String.valueOf(session.getAttribute("id")));
			   }
			   
			
			MessageDTO detailms = service.msdetail(id, "detail");
			String page = "redirect:/msSendList.go";
			
			if(detailms != null) {
				
				logger.info("if문 진입");
				ArrayList<String> detailfile = service.msDetailFile(id);
				
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
			
			MessageDTO detailms = service.msSenddetail(id, "detail");
			String page = "redirect:/msSendList.go";
			
			if(detailms != null) {
				
				logger.info("if문 진입");
				ArrayList<String> detailfile = service.msDetailFile(id);
				
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
		
		String oriFileName = service.selectFile(path);
		
		Resource body = new FileSystemResource(root+"/"+path);
		
		HttpHeaders header = new HttpHeaders();
		try {						
			String fileName = oriFileName+path.substring(path.lastIndexOf("."));
			
			fileName = URLEncoder.encode(fileName, "UTF-8");
			
			header.add("Content-type", "application/octet-stream");
			
			header.add("content-Disposition", "attatchment;fileName=\""+fileName+"\"");
		} catch (IOException e) {
			e.printStackTrace();
		}
			
	
		return new ResponseEntity<Resource>(body, header, HttpStatus.OK);
	}
	
	// 보낸 쪽지함 이동
	@RequestMapping(value="/msSendList.go")
	public String msSendList() {
		logger.info("보낸 쪽지함 이동");
	
		return "msSendList";
	}	
	
	// 보낸 쪽지함 리스트 
	@RequestMapping(value="/sendlist.ajax")
	@ResponseBody
	public HashMap<String, Object> msSendList(@RequestParam HashMap<String, Object> params,HttpSession session) {
		logger.info("보낸 쪽지함 이동");

	
		return service.sendList(session,params);
	}	
	

	// 받은 쪽지함 이동
	@RequestMapping(value="/msReceiveList.go")
	public String msReceiveList(Model model,HttpSession session) {
		logger.info("받은 쪽지함 이동");

		return "msReceiveList";
	}
	
	// 받은 쪽지함 리스트 
	@RequestMapping(value="/receivelist.ajax")
	@ResponseBody
	public HashMap<String, Object> msReceiveList(@RequestParam HashMap<String, Object> params,HttpSession session) {
		logger.info("보낸 쪽지함 이동");

		return service.receiveList(session,params);
	}	
	
	
	

	// 휴지통 이동
	@RequestMapping(value="/msRemoveList.go")
	public String msRemoveList() {
		logger.info("휴지통 이동");
		return "msRemove";
	}		
	
	// 휴지통 리스트 
	@RequestMapping(value="/msRemovelist.ajax")
	@ResponseBody
	public HashMap<String, Object> msRemovelist(@RequestParam HashMap<String, Object> params,HttpSession session) {
		logger.info("휴지통 리스트 ajax");
		logger.info("휴지통 params :"+params);
		return service.msRemovelist(session,params);
	}		
	
	// 답장 작성 페이지 이동
	@RequestMapping(value = "/msReply.go")
	public ModelAndView msReplyForm(Model model, @RequestParam("to_id") String fromId) {
	    // from_id 값을 가져와서 모델에 추가
		
		String member = service.msReplyMember(fromId);
	    model.addAttribute("fromId", fromId);
	    model.addAttribute("member", member);
	    
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
       return "redirect:/msRemoveList.go";
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
