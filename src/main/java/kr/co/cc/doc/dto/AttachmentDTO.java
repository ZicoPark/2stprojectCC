package kr.co.cc.doc.dto;

public class AttachmentDTO {

	private String id;
	private String oriFileName;
	private String newFileName;
	private String classification;
	private String identifyValue;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOriFileName() {
		return oriFileName;
	}
	public void setOriFileName(String oriFileName) {
		this.oriFileName = oriFileName;
	}
	public String getNewFileName() {
		return newFileName;
	}
	public void setNewFileName(String newFileName) {
		this.newFileName = newFileName;
	}
	public String getClassification() {
		return classification;
	}
	public void setClassification(String classification) {
		this.classification = classification;
	}
	public String getIdentifyValue() {
		return identifyValue;
	}
	public void setIdentifyValue(String identifyValue) {
		this.identifyValue = identifyValue;
	}
	
}
