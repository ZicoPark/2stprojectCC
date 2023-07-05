package kr.co.cc.doc.dto;

import java.sql.Timestamp;

public class DocDTO {

	private String id;
	private String subject;
	private String content;
	private int status;
	private String member_id;
	private String doc_form_id;
	private String dept_id;
	private String job_level_name;
	private String public_range;
	private Timestamp create_at;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getDoc_form_id() {
		return doc_form_id;
	}
	public void setDoc_form_id(String doc_form_id) {
		this.doc_form_id = doc_form_id;
	}
	public String getDept_id() {
		return dept_id;
	}
	public void setDept_id(String dept_id) {
		this.dept_id = dept_id;
	}
	public String getJob_level_name() {
		return job_level_name;
	}
	public void setJob_level_name(String job_level_name) {
		this.job_level_name = job_level_name;
	}
	public String getPublic_range() {
		return public_range;
	}
	public void setPublic_range(String public_range) {
		this.public_range = public_range;
	}
	public Timestamp getCreate_at() {
		return create_at;
	}
	public void setCreate_at(Timestamp create_at) {
		this.create_at = create_at;
	}
	
}
