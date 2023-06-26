package kr.co.cc.work.dto;

import java.sql.Date;
import java.sql.Time;



public class WorkDTO {
	
	private int id;
	private String member_id;
	private String name;
	private Date date;
	private Time time_go;
	private Time time_end;
	private Time update_time;
	private String type;
	private String reason;
	private int approval;
	private String dept_name;
	private String job_name;
	
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	public Time getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(Time update_time) {
		this.update_time = update_time;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public int getApproval() {
		return approval;
	}
	public void setApproval(int approval) {
		this.approval = approval;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public Time getTime_go() {
		return time_go;
	}
	public void setTime_go(Time time_go) {
		this.time_go = time_go;
	}
	public Time getTime_end() {
		return time_end;
	}
	public void setTime_end(Time time_end) {
		this.time_end = time_end;
	}
	
	

}
