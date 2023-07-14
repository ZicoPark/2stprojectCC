package kr.co.cc.calender.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class CalenderDTO {

	private String id;
	private String member_id;
	private String title;
	private String content;
	private String color;
	private Timestamp  start_at;
	private Timestamp  end_at;
	private Timestamp  create_at;
	
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
	public Date getStart_at() {
		return new Date(start_at.getTime());
		//return start_at;
	}
	public void setStart_at(Timestamp start_at) {
		this.start_at = start_at;
	}
	public Date getEnd_at() {
		return new Date(end_at.getTime());
		//return end_at;
	}
	public void setEnd_at(Timestamp end_at) {
		this.end_at = end_at;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public Date getCreate_at() {
		return new Date(create_at.getTime());
		//return create_at;
	}
	public void setCreate_at(Timestamp create_at) {
		this.create_at = create_at;
	}
	
}
