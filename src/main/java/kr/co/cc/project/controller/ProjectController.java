package kr.co.cc.project.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.co.cc.chat.dto.MemberDTO;
import kr.co.cc.chat.service.ChatService;
import kr.co.cc.project.dto.ProjectDTO;
import kr.co.cc.project.service.ProjectService;

@Controller
public class ProjectController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Value("${spring.servlet.multipart.location}")
	private String root;

	@Autowired
	ProjectService service;

	@GetMapping(value = "/projects.go")
	public String projectsGo(Model model, HttpSession session, HttpServletRequest request) {

		// 현재 로그인한 사용자의 아이디 가져오기
		String loginId = (String) session.getAttribute("id");

		ArrayList<ProjectDTO> list = service.list();
		logger.info("list cnt : " + list.size());

		for (ProjectDTO project : list) {
			ArrayList<HashMap<String, String>> userIdPhoto = service.getUserIdPhoto(project.getId());
			project.setUserIdPhoto(userIdPhoto);
		}

		model.addAttribute("list", list);
		model.addAttribute("id", loginId);
		logger.info("loginid : " + loginId);

		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);

		if (flashMap != null) {
			String msgU = (String) flashMap.get("msgU");
			model.addAttribute("msgU", msgU);
		}

		return "projects";
	}

	@PostMapping(value = "/pjMemberListAll.ajax")
	@ResponseBody
	public ArrayList<ProjectDTO> memberListAll() {
		logger.info("/memberListAll.ajax");
		return service.memberListAll();
	}

	@RequestMapping(value = "projectDetail.go")
	public String projectList(HttpSession session, Model model, @RequestParam String id, @RequestParam int public_range,
			@RequestParam int del_chk, RedirectAttributes rttr) {

		String page = "redirect:/projects.go";

		if (public_range == 0) {
			if (session.getAttribute("id") != null) {
				String loginId = (String) session.getAttribute("id");
				page = service.getMemberList(loginId, id);
				model.addAttribute("project_id", id);
				model.addAttribute("del_chk", del_chk);
				rttr.addFlashAttribute("msgU", "일부 공개 프로젝트입니다.");
			}
		} else {
			page = "project-detail";
			model.addAttribute("project_id", id);
			model.addAttribute("del_chk", del_chk);
		}
		return page;
	}

	@GetMapping(value = "/projectDetail.ajax")
	@ResponseBody
	public HashMap<String, Object> writePage(@RequestParam String id, HttpSession session) {
		logger.info("detail : " + id);
		String page = "redirect:/projects.go";

		String loginId = (String) session.getAttribute("id");
		HashMap<String, Object> map = new HashMap<String, Object>();

		ArrayList<HashMap<String, String>> commentList = new ArrayList<HashMap<String, String>>();
		commentList = service.getAllComment(id);

		for (HashMap<String, String> hashMap : commentList) {
			logger.info("코멘트 정보 : " + hashMap);
		}
		map.put("commentList", commentList);
		map.put("loginId", loginId);
		map.put("project_id", id);

		return map;
	}

	@GetMapping(value = "/project-add.go")
	public String projectAddGo() {
		return "project-add";
	}

	@GetMapping(value = "/projectUpdate.go")
	public String projectUpdateGo(Model model, HttpSession session, @RequestParam String id) {
		ProjectDTO dto = service.projectDetailUp(id);
		model.addAttribute("projectDetailUp", dto);
		model.addAttribute("project_id", id);
		return "projectUpdate";
	}

	@RequestMapping(value = "/projectUpdate.do")
	public String update(Model model, @RequestParam HashMap<String, String> params, HttpSession session,
			RedirectAttributes rttr) {
		logger.info("update param:" + params);
		if (session.getAttribute("id") != null) {
			// 프로젝트 정보 업데이트
			String id = params.get("project_id");

			if (params.get("user_id") != null && !params.get("user_id").equals("")) {
				String memberIdsString = params.get("user_id");
				String[] memberIds = memberIdsString.split(",");
				// 새로운 참가자 정보 추가
				for (String contributorId : memberIds) {
					service.addContributor(contributorId, id);
				}
			}
			service.projectUpdate(params);
			logger.info("params" + params);

			rttr.addFlashAttribute("msgU", "프로젝트가 수정되었습니다.");
		}
		return "redirect:/projects.go";
	}

	@GetMapping(value = "/projectDel.do")
	public String projectDel(HttpSession session, @RequestParam String id, RedirectAttributes rttr) {
		logger.info("params : " + id);
		logger.info("del 접근 : ");

		String msg = "철회에 실패 했습니다.";

		if (session.getAttribute("id") != null) {
			if (service.project_del(id) == 1) {
				msg = "철회에 성공 했습니다.";
			}
		}
		// redirect 시 데이터를 보낼 수 없다.
		// 하지만 session 에 데이터를 넣어 보낼 수 있다.
		rttr.addFlashAttribute("msgU", msg);

		return "redirect:/projects.go";
	}

	@GetMapping(value = "/projectRes.do")
	public String projectRes(HttpSession session, @RequestParam String id, RedirectAttributes rttr) {

		String msg = "복구에 실패 했습니다.";

		if (session.getAttribute("id") != null) {
			if (service.projectRes(id) == 1) {
				msg = "복구에 성공 했습니다.";
			}
		}
		// redirect 시 데이터를 보낼 수 없다.
		// 하지만 session 에 데이터를 넣어 보낼 수 있다.
		rttr.addFlashAttribute("msgU", msg);

		return "redirect:/projects.go";
	}

	@RequestMapping(value = "/project_add.do", method = RequestMethod.POST)
	public String projectAdd(Model model, @RequestParam HashMap<String, String> params, HttpSession session,
			RedirectAttributes rttr) {
		logger.info("프로젝트 등록");
		String msg = "프로젝트 등록";
		model.addAttribute("msg", msg);

		String id = (String) session.getAttribute("id");
		logger.info("loginId" + id);

		ProjectDTO dto = new ProjectDTO();
		dto.setName(params.get("name"));
		dto.setPublic_range(params.get("public_range"));
		dto.setStart_at(params.get("start_at"));
		dto.setEnd_at(params.get("end_at"));

		String projectId = service.write(dto, id);
		String project_id = dto.getId();
		logger.info("projectId" + projectId);
		logger.info("project_id" + project_id);

		String memberIdsString = params.get("user_id");
		String[] memberIds = memberIdsString.split(",");
		for (String contributorId : memberIds) {
			service.addContributor(contributorId, project_id);

		}
		rttr.addFlashAttribute("msgU", "프로젝트 생성 완료");

		return "redirect:/projects.go";
	}

	@GetMapping(value = "/projectInsert.go")
	public String projectInsertGo(HttpSession session, Model model, @RequestParam String id) {
		String memberId = (String) session.getAttribute("id");

		String user_id = service.getMemberById(memberId);
		String public_range = service.getRange(id);
		String del_chk = service.getChk(id);
		
		model.addAttribute("user_id", user_id);
		model.addAttribute("member_id", memberId);
		model.addAttribute("project_id", id);
		model.addAttribute("public_range", public_range);
		model.addAttribute("del_chk", del_chk);

		return "projectInsert";
	}

	@RequestMapping(value = "/projectInsert.do", method = RequestMethod.POST)
	public String write(MultipartFile[] attachment, @RequestParam HashMap<String, String> params, HttpSession session,
			Model model) {
		logger.info("params : " + params);
		logger.info("intsert 접근 : ");
		return service.insert(attachment, params, session, model);
	}

	// 파일 다운로드
	@GetMapping(value = "/attachmentDownload.do")
	public ResponseEntity<Resource> download(String id) {

		Resource body = new FileSystemResource(root + "/" + id);// BODY
		HttpHeaders header = new HttpHeaders();// Header
		try {
			String fileName = "이미지" + id.substring(id.lastIndexOf("."));
			fileName = URLEncoder.encode(fileName, "UTF-8");
			// text/... 은 문자열, image/... 이미지, application/octet-stream 은 바이너리 데이터
			header.add("Content-type", "application/octet-stream");
			// content-Disposition 은 내려보낼 내용이 문자열(inline)인지 파일(attatchment)인지 알려준다.
			header.add("content-Disposition", "attatchment;fileName=\"" + fileName + "\"");
		} catch (IOException e) {
			e.printStackTrace();
		}

		// body, header, status
		return new ResponseEntity<Resource>(body, header, HttpStatus.OK);
	}

	@PostMapping(value = "/postCommentWrite.ajax")
	@ResponseBody
	public HashMap<String, Object> replyWrite(@RequestParam String id, @RequestParam String content,
			HttpSession session) {

		String loginId = (String) session.getAttribute("id");
		logger.info("id" + id);
		logger.info("content" + content);

		return service.replyWrite(id, content, loginId);

	}

	@PostMapping(value = "/postCommentRead.ajax")
	@ResponseBody
	public HashMap<String, Object> replyWrite(@RequestParam String comment_id) {

		logger.info("comment_id : " + comment_id);

		return service.replyRead(comment_id);

	}

	@PostMapping(value = "/replyDel.ajax")
	@ResponseBody
	public int replyDel(@RequestParam String id) {

		logger.info("comment_id : " + id);

		return service.replyDel(id);

	}

}