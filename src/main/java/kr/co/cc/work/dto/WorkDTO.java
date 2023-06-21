package kr.co.cc.work.dto;

import java.sql.Date;
import java.sql.Time;

import org.apache.ibatis.type.Alias;

@Alias("workdto") 
public class WorkDTO {
	
	private int id;
	private String member_id;
	private String name;
	private Date date;
	private Time time_go;
	private Time time_end;
	
	
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
