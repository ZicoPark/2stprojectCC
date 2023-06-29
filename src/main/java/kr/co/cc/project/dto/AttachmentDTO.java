package kr.co.cc.project.dto;

public class AttachmentDTO {

	private String id;
	private String ori_file_name;
	private String new_file_name;
	private String classification;
	private String identify_value;
	
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
