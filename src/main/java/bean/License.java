package bean;

import java.security.Timestamp;

public class License {

	private int licenseId; 			//資格申請ID
	private int userID;            	//ユーザー情報ID
	private String applicant;			//申請者
	private String approver; 			//承認者
	private String image; 				//画像
	private Timestamp requestDate; 		//申請日時
	private Timestamp examDate; 		//受験日時
	private int examTime;		    	//受験回数
	private int requestFlag; 			//申請フラグ

	public int getLicenseId() {
		return licenseId;
	}

	public void setLicenseId(int licenseId) {
		this.licenseId = licenseId;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public String getApplicant() {
		return applicant;
	}

	public void setApplicant(String applicant) {
		this.applicant = applicant;
	}

	public String getApprover() {
		return approver;
	}

	public void setApprover(String approver) {
		this.approver = approver;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Timestamp getRequestDate() {
		return requestDate;
	}

	public void setRequestDate(Timestamp requestDate) {
		this.requestDate = requestDate;
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

	public int getRequestFlag() {
		return requestFlag;
	}

	public void setRequestFlag(int requestFlag) {
		this.requestFlag = requestFlag;
	}

}
