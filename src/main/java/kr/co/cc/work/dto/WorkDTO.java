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
	private String approval;
	private String dept_name;
	private String job_name;
	private Time total_time;
	private boolean worn;
	private Date week;
	private int total_worn;
	
	private String regist_id;
	private Date regist_date;
	private String approval_id;
	private Date start_date;
	private Date end_date;
	private int use_cnt;
	
	private int annual_cnt;
	private int left_cnt;
	private String year;
	
	
	public int getAnnual_cnt() {
		return annual_cnt;
	}
	public void setAnnual_cnt(int annual_cnt) {
		this.annual_cnt = annual_cnt;
	}
	public int getLeft_cnt() {
		return left_cnt;
	}
	public void setLeft_cnt(int left_cnt) {
		this.left_cnt = left_cnt;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getRegist_id() {
		return regist_id;
	}
	public void setRegist_id(String regist_id) {
		this.regist_id = regist_id;
	}
	public Date getRegist_date() {
		return regist_date;
	}
	public void setRegist_date(Date regist_date) {
		this.regist_date = regist_date;
	}
	public String getApproval_id() {
		return approval_id;
	}
	public void setApproval_id(String approval_id) {
		this.approval_id = approval_id;
	}
	public Date getStart_date() {
		return start_date;
	}
	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	public int getUse_cnt() {
		return use_cnt;
	}
	public void setUse_cnt(int use_cnt) {
		this.use_cnt = use_cnt;
	}
	public int getTotal_worn() {
		return total_worn;
	}
	public void setTotal_worn(int total_worn) {
		this.total_worn = total_worn;
	}
	public Date getWeek() {
		return week;
	}
	public void setWeek(Date week) {
		this.week = week;
	}
	public boolean isWorn() {
		return worn;
	}
	public void setWorn(boolean worn) {
		this.worn = worn;
	}
	public Time getTotal_time() {
		return total_time;
	}
	public void setTotal_time(Time total_time) {
		this.total_time = total_time;
	}
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
	public String getApproval() {
		return approval;
	}
	public void setApproval(String approval) {
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
