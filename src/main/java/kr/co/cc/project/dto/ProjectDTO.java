package kr.co.cc.project.dto;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

public class ProjectDTO {

	private String del_chk;
	private String id;
	private String public_range;
	private String project_id;
	private String name;
	private String user_id;
	private String member_id;
	private String create_at;
	private String explain;
	private String step;
	private String status;
	private String start_at;
	private String end_at;
	private String contributors;
	private String subject;
	private String user_name;
	private String content;
	private String comment_content;
	private int comment_status;
	private Date comment_create_date;
	private String coment_id;
	private String dept_name;

	private String ori_file_name;
	private String new_file_name;
	private String classification;
	private String identify_value;

	private ArrayList<HashMap<String, String>> userIdPhoto;

	public String getDept_name() {
		return dept_name;
	}

	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}

	public String getComent_id() {
		return coment_id;
	}

	public void setComent_id(String coment_id) {
		this.coment_id = coment_id;
	}

	public String getDel_chk() {
		return del_chk;
	}

	public void setDel_chk(String del_chk) {
		this.del_chk = del_chk;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPublic_range() {
		return public_range;
	}

	public void setPublic_range(String string) {
		this.public_range = string;
	}

	public String getProject_id() {
		return project_id;
	}

	public void setProject_id(String project_id) {
		this.project_id = project_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getCreate_at() {
		return create_at;
	}

	public void setCreate_at(String create_at) {
		this.create_at = create_at;
	}

	public String getExplain() {
		return explain;
	}

	public void setExplain(String explain) {
		this.explain = explain;
	}

	public String getStep() {
		return step;
	}

	public void setStep(String step) {
		this.step = step;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getStart_at() {
		return start_at;
	}

	public void setStart_at(String start_at) {
		this.start_at = start_at;
	}

	public String getEnd_at() {
		return end_at;
	}

	public void setEnd_at(String end_at) {
		this.end_at = end_at;
	}

	public String getContributors() {
		return contributors;
	}

	public void setContributors(String contributors) {
		this.contributors = contributors;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getComment_content() {
		return comment_content;
	}

	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}

	public int getComment_status() {
		return comment_status;
	}

	public void setComment_status(int comment_status) {
		this.comment_status = comment_status;
	}

	public Date getComment_create_date() {
		return comment_create_date;
	}

	public void setComment_create_date(Date comment_create_date) {
		this.comment_create_date = comment_create_date;
	}

	public String getOri_file_name() {
		return ori_file_name;
	}

	public void setOri_file_name(String ori_file_name) {
		this.ori_file_name = ori_file_name;
	}

	public String getNew_file_name() {
		return new_file_name;
	}

	public void setNew_file_name(String new_file_name) {
		this.new_file_name = new_file_name;
	}

	public String getClassification() {
		return classification;
	}

	public void setClassification(String classification) {
		this.classification = classification;
	}

	public String getIdentify_value() {
		return identify_value;
	}

	public void setIdentify_value(String identify_value) {
		this.identify_value = identify_value;
	}

	public ArrayList<HashMap<String, String>> getUserIdPhoto() {
		return userIdPhoto;
	}

	public void setUserIdPhoto(ArrayList<HashMap<String, String>> userIdPhoto) {
		this.userIdPhoto = userIdPhoto;
	}

}
