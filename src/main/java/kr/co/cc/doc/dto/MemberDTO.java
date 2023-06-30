package kr.co.cc.doc.dto;

import java.sql.Date;

public class MemberDTO {

	private String id;
	private String user_id;
	private String job_level_id;
	private String dept_id;
	private String password;
	private String name;
	private Date birth_at;
	private Date create_at;
	private Date hire_at;
	private Date end_at;
	private String email;
	private String phone;
	private boolean status;
	private boolean admin_chk;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getJob_level_id() {
		return job_level_id;
	}
	public void setJob_level_id(String job_level_id) {
		this.job_level_id = job_level_id;
	}
	public String getDept_id() {
		return dept_id;
	}
	public void setDept_id(String dept_id) {
		this.dept_id = dept_id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getBirth_at() {
		return birth_at;
	}
	public void setBirth_at(Date birth_at) {
		this.birth_at = birth_at;
	}
	public Date getCreate_at() {
		return create_at;
	}
	public void setCreate_at(Date create_at) {
		this.create_at = create_at;
	}
	public Date getHire_at() {
		return hire_at;
	}
	public void setHire_at(Date hire_at) {
		this.hire_at = hire_at;
	}
	public Date getEnd_at() {
		return end_at;
	}
	public void setEnd_at(Date end_at) {
		this.end_at = end_at;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public boolean isStatus() {
		return status;
	}
	public void setStatus(boolean status) {
		this.status = status;
	}
	public boolean isAdmin_chk() {
		return admin_chk;
	}
	public void setAdmin_chk(boolean admin_chk) {
		this.admin_chk = admin_chk;
	}
	
}
