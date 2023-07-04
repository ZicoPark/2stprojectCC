package kr.co.cc.work.dto;

import java.sql.Date;
import java.sql.Time;



public class WorkDTO {

	private String user_id;

	private String id;
    private String member_id;
    private int annual_cnt;
    private int use_cnt;
    private int left_cnt;
    private String year;
    private String regist_name;
    private String approval_name;
    
    private String regist_id_user;
    private String approval_id_user;
    
    private String regist_id;
    private Date regist_at;
    private String approval_id;
    private String approval;
    private Date start_at;
    private Date end_at;
    private String reason;
    private String type;
    
    private String name;
    private Date date;
    private Time time_go;
    private Time time_end; 
    
    
    private String working_hour_id;
    private Time update_at;
    private String dept_name;
    

    private String job_name;
    private Date week;
    private String total_time;
    private boolean worn;
    private int total_worn;
    
    
    
    
    
	public String getRegist_id_user() {
		return regist_id_user;
	}
	public void setRegist_id_user(String regist_id_user) {
		this.regist_id_user = regist_id_user;
	}
	public String getApproval_id_user() {
		return approval_id_user;
	}
	public void setApproval_id_user(String approval_id_user) {
		this.approval_id_user = approval_id_user;
	}
	public String getRegist_name() {
		return regist_name;
	}
	public void setRegist_name(String regist_name) {
		this.regist_name = regist_name;
	}
	public String getApproval_name() {
		return approval_name;
	}
	public void setApproval_name(String approval_name) {
		this.approval_name = approval_name;
	}
	public int getTotal_worn() {
		return total_worn;
	}
	public void setTotal_worn(int total_worn) {
		this.total_worn = total_worn;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
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
	public int getAnnual_cnt() {
		return annual_cnt;
	}
	public void setAnnual_cnt(int annual_cnt) {
		this.annual_cnt = annual_cnt;
	}
	public int getUse_cnt() {
		return use_cnt;
	}
	public void setUse_cnt(int use_cnt) {
		this.use_cnt = use_cnt;
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
	public Date getRegist_at() {
		return regist_at;
	}
	public void setRegist_at(Date regist_at) {
		this.regist_at = regist_at;
	}
	public String getApproval_id() {
		return approval_id;
	}
	public void setApproval_id(String approval_id) {
		this.approval_id = approval_id;
	}
	public String getApproval() {
		return approval;
	}
	public void setApproval(String approval) {
		this.approval = approval;
	}
	public Date getStart_at() {
		return start_at;
	}
	public void setStart_at(Date start_at) {
		this.start_at = start_at;
	}
	public Date getEnd_at() {
		return end_at;
	}
	public void setEnd_at(Date end_at) {
		this.end_at = end_at;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
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
	public String getWorking_hour_id() {
		return working_hour_id;
	}
	public void setWorking_hour_id(String working_hour_id) {
		this.working_hour_id = working_hour_id;
	}
	public Time getUpdate_at() {
		return update_at;
	}
	public void setUpdate_at(Time update_at) {
		this.update_at = update_at;
	}
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}
	public Date getWeek() {
		return week;
	}
	public void setWeek(Date week) {
		this.week = week;
	}
	public String getTotal_time() {
		return total_time;
	}
	public void setTotal_time(String total_time) {
		this.total_time = total_time;
	}
	public boolean isWorn() {
		return worn;
	}
	public void setWorn(boolean worn) {
		this.worn = worn;
	}
    
    
    

}
