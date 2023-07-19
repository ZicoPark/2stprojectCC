package kr.co.cc.noticeBoard.dto;


//@Alias("noticeBoard")
public class NoticeBoardDTO {

   private String id;
   private String member_id;
   private String subject;
   private String content;
   private String hit;
   private String status;
   private String create_at;
   private String ori_file_name;
   private String classification;
   private String identify_value;
   private String name;
	private String user_id;
	private String admin_chk;
	
	
	
	
   
	   
	public String getAdmin_chk() {
		return admin_chk;
	}
	public void setAdmin_chk(String admin_chk) {
		this.admin_chk = admin_chk;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
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
	public String getHit() {
		return hit;
	}
	public void setHit(String hit) {
		this.hit = hit;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCreate_at() {
		return create_at;
	}
	public void setCreate_at(String create_at) {
		this.create_at = create_at;
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
  
   
}