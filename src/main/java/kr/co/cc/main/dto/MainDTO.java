package kr.co.cc.main.dto;

import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;

public class MainDTO {
	
	
	private String id;
	private String m_id;
	private String d_id;
	private String jl_id;
	private String user_id;
	private String name;
	private String m_name;
	private String d_name;
	private String jl_name;
	private String a_id;
	private String admin_chk;

    private Date date;
    private String time_go;
    private String time_end; 
    
    
    private String working_hour_id;
    private Time update_at;
    private String dept_name;
    

    private String job_name;
    private Date week;
    private String total_time;
	
	
	public String getAdmin_chk() {
		return admin_chk;
	}
	public void setAdmin_chk(String admin_chk) {
		this.admin_chk = admin_chk;
	}
	public String getTime_go() {
		return time_go;
	}
	public void setTime_go(String time_go) {
		this.time_go = time_go;
	}
	public String getTime_end() {
		return time_end;
	}
	public void setTime_end(String time_end) {
		this.time_end = time_end;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
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
	public String getA_id() {
		return a_id;
	}
	public void setA_id(String a_id) {
		this.a_id = a_id;
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
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public String getD_id() {
		return d_id;
	}
	public void setD_id(String d_id) {
		this.d_id = d_id;
	}
	public String getJl_id() {
		return jl_id;
	}
	public void setJl_id(String jl_id) {
		this.jl_id = jl_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getM_name() {
		return m_name;
	}
	public void setM_name(String m_name) {
		this.m_name = m_name;
	}
	public String getD_name() {
		return d_name;
	}
	public void setD_name(String d_name) {
		this.d_name = d_name;
	}
	public String getJl_name() {
		return jl_name;
	}
	public void setJl_name(String jl_name) {
		this.jl_name = jl_name;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
