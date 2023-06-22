package kr.co.cc.message.dto;

import java.sql.Date;

public class MessageDTO {

	private String id;
	private String from_id;
	private String to_id;
	private String title;
	private String content;
	private String send_date;
	private boolean del_chk;
	private boolean read_chk;
	private String formattedDate;
	
	public String getSend_date() {
		return send_date;
	}
	public void setSend_date(String send_date) {
		this.send_date = send_date;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getFrom_id() {
		return from_id;
	}
	public void setFrom_id(String from_id) {
		this.from_id = from_id;
	}
	public String getTo_id() {
		return to_id;
	}
	public void setTo_id(String to_id) {
		this.to_id = to_id;
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

	public boolean isDel_chk() {
		return del_chk;
	}
	public void setDel_chk(boolean del_chk) {
		this.del_chk = del_chk;
	}
	public boolean isRead_chk() {
		return read_chk;
	}
	public void setRead_chk(boolean read_chk) {
		this.read_chk = read_chk;
	}
    public String getFormattedDate() {
        return formattedDate;
    }

    public void setFormattedDate(String formattedDate) {
        this.formattedDate = formattedDate;
    }
	
}
