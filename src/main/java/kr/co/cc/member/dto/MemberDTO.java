package kr.co.cc.member.dto;

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
	private String status;
	private String admin_Chk;
	private String address;
	private String title;
	private String message;
	private String TemporaryPassword;
	private String updateTemporaryPassword;
	private String encodedPassword;
	private String photoName;
	private String ori_file_name;
	private String classification;
	private String identify_value;
	

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
	public String getPhotoName() {
		return photoName;
	}
	public void setPhotoName(String photoName) {
		this.photoName = photoName;
	}
	public String getEncodedPassword() {
		return encodedPassword;
	}
	public void setEncodedPassword(String encodedPassword) {
		this.encodedPassword = encodedPassword;
	}
	public String getUpdateTemporaryPassword() {
		return updateTemporaryPassword;
	}
	public void setUpdateTemporaryPassword(String updateTemporaryPassword) {
		this.updateTemporaryPassword = updateTemporaryPassword;
	}
	public String getTemporaryPassword() {
		return TemporaryPassword;
	}
	public void setTemporaryPassword(String temporaryPassword) {
		TemporaryPassword = temporaryPassword;
	}
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getAdmin_Chk() {
		return admin_Chk;
	}
	public void setAdmin_Chk(String admin_Chk) {
		this.admin_Chk = admin_Chk;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
		
}
