package kr.co.cc.admin.dto;

import java.sql.Date;

public class AdminDTO {

	private String id;
	private String user_id;
	private String name;
	private Date birth_at;
	private String email;
	private String phone;
	private Date hire_at;
	private String dept_id;
	private String job_level_id;
	private boolean status;
	private boolean admin_chk;
	private Date end_at;
	private String job_name;
	private String dept_name;
	private String photoName;
	private String ori_file_name;
	private String classification;
	private String identify_value;
	
	public String getPhotoName() {
		return photoName;
	}
	public void setPhotoName(String photoName) {
		this.photoName = photoName;
	}
	public String getOri_file_name() {
		return ori_file_name;
	}
	public void setOri_file_name(String ori_file_name) {
		this.ori_file_name = ori_file_name;
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
	public Date getEnd_at() {
		return end_at;
	}
	public void setEnd_at(Date end_at) {
		this.end_at = end_at;
	}
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
	public Date getBirth_at() {
		return birth_at;
	}
	public void setBirth_at(Date birth_at) {
		this.birth_at = birth_at;
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
	public Date getHire_at() {
		return hire_at;
	}
	public void setHire_at(Date hire_at) {
		this.hire_at = hire_at;
	}
	public boolean getStatus() {
		return status;
	}
	public void setStatus(boolean status) {
		this.status = status;
	}
	public boolean getAdmin_chk() {
		return admin_chk;
	}
	public void setAdmin_chk(boolean admin_chk) {
		this.admin_chk = admin_chk;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getDept_id() {
		return dept_id;
	}
	public void setDept_id(String dept_id) {
		this.dept_id = dept_id;
	}
	public String getJob_level_id() {
		return job_level_id;
	}
	public void setJob_level_id(String job_level_id) {
		this.job_level_id = job_level_id;
	}
	public String getDept_name() {
		return dept_name;
	}
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	
	
}
