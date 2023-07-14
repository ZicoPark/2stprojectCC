package kr.co.cc.chat.dto;

import java.sql.Date;
import java.time.LocalDateTime;


public class ChatDTO {
	private String chat_room_id;
	private String name;
	private String id;
	private String send_id;
	private String subject;
	private String content;
	private boolean is_read;
	private LocalDateTime send_time;
	private boolean blind;
	private boolean is_notice;
	private String dept_name;
	private int number;
	private String profileImg;
	
	
	
	
	
	
	
	public String getProfileImg() {
		return profileImg;
	}
	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	public LocalDateTime getSend_time() {
		return send_time;
	}
	public void setSend_time(LocalDateTime send_time) {
		this.send_time = send_time;
	}
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	public String getChat_room_id() {
		return chat_room_id;
	}
	public void setChat_room_id(String chat_room_id) {
		this.chat_room_id = chat_room_id;
	}
	public boolean isBlind() {
		return blind;
	}
	public void setBlind(boolean blind) {
		this.blind = blind;
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
	public String getSend_id() {
		return send_id;
	}
	public void setSend_id(String send_id) {
		this.send_id = send_id;
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
	public boolean isIs_read() {
		return is_read;
	}
	public void setIs_read(boolean is_read) {
		this.is_read = is_read;
	}
	public boolean isIs_notice() {
		return is_notice;
	}
	public void setIs_notice(boolean is_notice) {
		this.is_notice = is_notice;
	}
	
}
