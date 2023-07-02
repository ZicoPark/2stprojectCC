package kr.co.cc.project.dto;

import java.util.Date;
import java.util.List;

public class ProjectDTO {

	private String id;
	private int public_range;
	private String name;
	private String member_id;
	private String user_id;
	private Date create_at;
	private String explain; 
	private String step;
	private String status;
	private String start_at;
	private String end_at;
	private String contributors;
	private String subject;
	private String user_name;
	private String content;
	private int project_id;
	private List<String> userIds;
	private String comment_content;
	private int comment_status;
	private Date comment_create_date;
	

	private String ori_file_name;
	   private String new_file_name;
	   private String classification;
	   private String identify_value;
	
	
	
	
	public List<String> getUserIds() {
		return userIds;
	}

	public void setUserIds(List<String> userIds) {
		this.userIds = userIds;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public Date getCreate_at() {
		return create_at;
	}

	public void setCreate_at(Date create_at) {
		this.create_at = create_at;
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

	public Date getComment_create_date() {
		return comment_create_date;
	}

	public void setComment_create_date(Date comment_create_date) {
		this.comment_create_date = comment_create_date;
	}

	public int getComment_status() {
		return comment_status;
	}

	public void setComment_status(int comment_status) {
		this.comment_status = comment_status;
	}

	public String getComment_content() {
		return comment_content;
	}

	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
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

	public int getProject_id() {
		return project_id;
	}

	public void setProject_id(int project_id) {
		this.project_id = project_id;
	}

	public String getContributors() {
        return contributors;
    }

    public void setContributors(String contributors) {
        this.contributors = contributors;
    }


	public int getPublic_range() {
		return public_range;
	}
	public void setPublic_range(int public_range) {
		this.public_range = public_range;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
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

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	
	
	

	
}
