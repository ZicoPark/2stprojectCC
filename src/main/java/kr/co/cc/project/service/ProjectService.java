package kr.co.cc.project.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import kr.co.cc.project.dto.AttachmentDTO;
import kr.co.cc.chat.dto.MemberDTO;
import kr.co.cc.project.dao.ProjectDAO;
import kr.co.cc.project.dto.ProjectDTO;

@Service
@MapperScan(value = { "kr.co.cc.project.dao" })
public class ProjectService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Value("${spring.servlet.multipart.location}")
	private String attachmentRoot;
	private final ProjectDAO dao;

	public ProjectService(ProjectDAO dao) {
		this.dao = dao;
	}

	public String write(ProjectDTO dto, String id) {
		dto.setMember_id(id);
		logger.info("id" + id);
		int row = dao.ProjectWrite(dto);

		return dto.getId(); // 새로 생성된 프로젝트의 ID 반환
	}

	public void addContributor(String project_id, String contributorId) {
		dao.addContributor(project_id, contributorId);
	}

	public ArrayList<ProjectDTO> list() {

		return dao.ProjectList();
	}

	public String insert(MultipartFile[] attachment, HashMap<String, String> params, HttpSession session, Model model) {
		String id = (String) session.getAttribute("id");
		String page = "redirect:/projects.go";

		ProjectDTO dto = new ProjectDTO();
		dto.setMember_id(params.get("member_id"));
		dto.setContent(params.get("content"));
		dto.setStep(params.get("step"));
		dto.setStatus(params.get("status"));
		dto.setProject_id(params.get("project_id"));
		dto.setPublic_range(params.get("public_range"));
		dto.setDel_chk(params.get("del_chk"));
		int row = dao.commentWrite(dto);

		String idx = dto.getId();

		dao.stateChange(dto);
		if (row == 1) { // 업로드된 자료실 게시물이 1이라면

			for (MultipartFile file : attachment) {

				logger.info("업로드할 file 있나요? :" + !file.isEmpty());

				if (!file.isEmpty()) {
					attachmentSave(idx, file, "프로젝트 첨부파일");
				}

				try { // 쓰레드 0.001초 지연으로 중복파일명 막자
					Thread.sleep(1);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}

			}
		}
		page = "redirect:/projectDetail.go?id=" + params.get("project_id") + "&public_range="
				+ params.get("public_range") + "&del_chk="
						+ params.get("del_chk");

		return page;

	}

	private void attachmentSave(String id, MultipartFile file, String cls) {

		String oriFileName = file.getOriginalFilename();
		String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
		UUID uuid = UUID.randomUUID();
		String newFileName = uuid.toString() + ext;
		logger.info("파일 업로드 : " + oriFileName + "=>" + newFileName + "으로 변경될 예정");

		try {
			byte[] bytes = file.getBytes();
			Path path = Paths.get(attachmentRoot + "/" + newFileName);
			Files.write(path, bytes);
			logger.info(newFileName + " upload 디렉토리에 저장 완료 !");

			dao.archivefileWrite(oriFileName, newFileName, cls, id);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	public ProjectDTO projectDetailUp(String id) {
		return dao.projectDetailUp(id);
	}

	public void projectUpdate(HashMap<String, String> params) {
		int row = dao.projectUpdate(params);

	}

	public void ContributorUpdate(String project_id, String contributorId) {
		dao.updateContributor(project_id, contributorId);

	}

	public void clearContributors(int project_id) {
		dao.clearContributors(project_id);
	}

	public String getMemberById(String memberId) {
		return dao.getUserId(memberId);
	}

	public int project_del(String id) {

		return dao.projectDel(id);
	}

	public int projectRes(String id) {
		return dao.projectRes(id);
	}

	public String projectDetailFile(String id) {
		return dao.projectDetailFile(id);
	}

	public ArrayList<HashMap<String, String>> getAllComment(String projectId) {

		return dao.getAllComment(projectId);
	}

	public HashMap<String, Object> replyWrite(String id, String content, String loginId) {
		HashMap<String, Object> data = new HashMap<String, Object>();
		data.put("success", dao.replyWrite(id, content, loginId));
		return data;

	}

	public HashMap<String, Object> replyRead(String comment_id) {
		HashMap<String, Object> data = new HashMap<String, Object>();
		data.put("dto", dao.replyLoad(comment_id));
		return data;

	}

	public int replyDel(String id) {

		int row = dao.replyDel(id);
		return row;
	}

	public String getMemberList(String loginId, String projectId) {

		String page = "redirect:/projects.go";

		int contributorChk = dao.contributorChk(loginId, projectId);
		int createMemberChk = dao.createMemberChk(loginId, projectId);

		if (contributorChk > 0 || createMemberChk > 0) {
			page = "project-detail";
		}

		return page;
	}

	public ArrayList<ProjectDTO> memberListAll() {
		return dao.memberListAll();
	}

	public String getRange(String id) {
		return dao.getRange(id);
	}

	public ArrayList<HashMap<String, String>> getUserIdPhoto(String projectId) {

		return dao.getUserIdPhoto(projectId);
	}

	public String getChk(String id) {
		return dao.getChk(id);
	}

}
