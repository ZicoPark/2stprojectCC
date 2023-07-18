package kr.co.cc.message.dto;



public class MessageDTO {

	private String id;
	private String user_id;
	private String from_id;
	private String to_id;
	private String title;
	private String content;
	private String send_at;
	private boolean del_chk;
	private boolean read_chk;
	private String formattedDate;
	private String ori_file_name;
	private String new_file_name;
	private String classification;
	private String identify_value;
	private String job_level_id;
	private String dept_id;
	private String password;
	private String name;
	private String birth_at;
	private String hire_at;
	private String end_at;
	private String email;
	private String phone;
	private String status;
	private String admin_chk;
	private String dept_name;
	private String member_name;
	private String tofrom_id;
	private String from_name;
	private String to_name;
	

	
	public String getFrom_name() {
		return from_name;
	}
	public void setFrom_name(String from_name) {
		this.from_name = from_name;
	}
	public String getTo_name() {
		return to_name;
	}
	public void setTo_name(String to_name) {
		this.to_name = to_name;
	}
	public String getTofrom_id() {
		return tofrom_id;
	}
	public void setTofrom_id(String tofrom_id) {
		this.tofrom_id = tofrom_id;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getSend_at() {
		return send_at;
	}
	public void setSend_at(String send_at) {
		this.send_at = send_at;
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
	public String getBirth_at() {
		return birth_at;
	}
	public void setBirth_at(String birth_at) {
		this.birth_at = birth_at;
	}
	public String getHire_at() {
		return hire_at;
	}
	public void setHire_at(String hire_at) {
		this.hire_at = hire_at;
	}
	public String getEnd_at() {
		return end_at;
	}
	public void setEnd_at(String end_at) {
		this.end_at = end_at;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
	public String getAdmin_chk() {
		return admin_chk;
	}
	public void setAdmin_chk(String admin_chk) {
		this.admin_chk = admin_chk;
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

	public String getFrom_id() {
		return from_id;
	}
	public void setFrom_id(String from_id) {
		this.from_id = from_id;
	}
	public String getTo_id() {
		return to_id;
	}
	public void setTo_id(String toId) {
		this.to_id = toId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}

	public boolean isDel_chk() {
		return del_chk;
	}
	public void setDel_chk(boolean del_chk) {
		this.del_chk = del_chk;
	}
	public boolean isRead_chk() {
		return read_chk;
	}
	public void setRead_chk(boolean read_chk) {
		this.read_chk = read_chk;
	}
    public String getFormattedDate() {
        return formattedDate;
    }

    public void setFormattedDate(String formattedDate) {
        this.formattedDate = formattedDate;
    }
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}

	
}
