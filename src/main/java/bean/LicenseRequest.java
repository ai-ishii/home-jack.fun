package bean;

import java.sql.Timestamp;

public class LicenseRequest {

	private int licenseRequestId; 			//資格申請ID
	private int requestId; 				//申請ID
	private int groupId;	 				//所属グループID
	private int departmentId; 				//部ID
	private int licenseId; 				//資格ID
	private Timestamp examDate; 			//受験日
	private int examTime; 					//受験回数
	private String receipt; 				//領収書画像
	private String certificate ; 			//合格証画像
	
	
	
	public int getLicenseRequestId() {
		return licenseRequestId;
	}
	public void setLicenseRequestId(int licenseRequestId) {
		this.licenseRequestId = licenseRequestId;
	}
	public int getRequestId() {
		return requestId;
	}
	public void setRequestId(int requestId) {
		this.requestId = requestId;
	}
	public int getGroupId() {
		return groupId;
	}
	public void setGroupId(int groupId) {
		this.groupId = groupId;
	}
	public int getDepartmentId() {
		return departmentId;
	}
	public void setDepartmentId(int departmentId) {
		this.departmentId = departmentId;
	}
	public int getLicenseId() {
		return licenseId;
	}
	public void setLicenseId(int licenseId) {
		this.licenseId = licenseId;
	}
	public Timestamp getExamDate() {
		return examDate;
	}
	public void setExamDate(Timestamp examDate) {
		this.examDate = examDate;
	}
	public int getExamTime() {
		return examTime;
	}
	public void setExamTime(int examTime) {
		this.examTime = examTime;
	}
	public String getReceipt() {
		return receipt;
	}
	public void setReceipt(String receipt) {
		this.receipt = receipt;
	}
	public String getCertificate() {
		return certificate;
	}
	public void setCertificate(String certificate) {
		this.certificate = certificate;
	}
	
	
	
	
	
}
