package kr.co.cc.project.dto;

import java.util.Date;

public class ProjectDTO {

	private int project_id;
	private int public_range;
	private String name;
	private String member_id;
	private Date start_date;
	private String explain; 
	private String step;
	private String status;
	private String priod;
	private String deadlinepriod;
	private String contributors;
	
	public String getContributors() {
        return contributors;
    }

    public void setContributors(String contributors) {
        this.contributors = contributors;
    }

	public int getProject_id() {
		return project_id;
	}
	public void setProject_id(int project_id) {
		this.project_id = project_id;
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
	public Date getStart_date() {
		return start_date;
	}
	public void setStart_date(Date start_date) {
		this.start_date = start_date;
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
	public String getPriod() {
		return priod;
	}
	public void setPriod(String priod) {
		this.priod = priod;
	}
	public String getDeadlinepriod() {
		return deadlinepriod;
	}
	public void setDeadlinepriod(String deadlinepriod) {
		this.deadlinepriod = deadlinepriod;
	}

	
	
	

	
}
