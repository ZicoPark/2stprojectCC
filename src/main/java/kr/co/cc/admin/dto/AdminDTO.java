package kr.co.cc.admin.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

public class AdminDTO {

	private String id;
	private String name;
	private Date birth_date;
	private String email;
	private String phone;
	private Date hire_date;
	private String dept_name;
	private String job_name;
	private boolean status;
	private boolean admin_chk;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getBirth_date() {
		return birth_date;
	}
	public void setBirth_date(Date birth_date) {
		this.birth_date = birth_date;
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
	public Date getHire_date() {
		return hire_date;
	}
	public void setHire_date(Date hire_date) {
		this.hire_date = hire_date;
	}
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
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
