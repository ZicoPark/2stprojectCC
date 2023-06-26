package kr.co.cc.doc.dto;

import java.sql.Date;

public class DocDTO {

		private int id;
		private String subject;
		private String content;
		private int status;
		private int docFormId;
		private Date createDate;
		private String memberId;
		private String deptName;
		private String jobName;
		private String publicRange;
		
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
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
		public int getStatus() {
			return status;
		}
		public void setStatus(int status) {
			this.status = status;
		}
		public int getDocFormId() {
			return docFormId;
		}
		public void setDocFormId(int docFormId) {
			this.docFormId = docFormId;
		}
		public Date getCreateDate() {
			return createDate;
		}
		public void setCreateDate(Date createDate) {
			this.createDate = createDate;
		}
		public String getMemberId() {
			return memberId;
		}
		public void setMemberId(String memberId) {
			this.memberId = memberId;
		}
		public String getDeptName() {
			return deptName;
		}
		public void setDeptName(String deptName) {
			this.deptName = deptName;
		}
		public String getJobName() {
			return jobName;
		}
		public void setJobName(String jobName) {
			this.jobName = jobName;
		}
		public String getPublicRange() {
			return publicRange;
		}
		public void setPublicRange(String publicRange) {
			this.publicRange = publicRange;
		}
	
}
