package kr.co.cc.doc.dto;

import java.sql.Date;

public class DocDTO {

	private String id;
	private String subject;
	private String content;
	private int status;
	private String member_id;
	private String doc_form_id;
	private String dept_id;
	private String job_name;
	private String public_range;
	private Date create_at;
	
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
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}
	public String getPublic_range() {
		return public_range;
	}
	public void setPublic_range(String public_range) {
		this.public_range = public_range;
	}
	public Date getCreate_at() {
		return create_at;
	}
	public void setCreate_at(Date create_at) {
		this.create_at = create_at;
	}
	
}
