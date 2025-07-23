package bean;

import java.sql.Timestamp;

public class LicenseRequest {

	private int licenseId; //資格申請ID
	private int requestId; //申請ID
	private String licenseName; //	資格名
	private String image; //画像
	private Timestamp examDate; //受験日
	private int examTime; //受験回数
	
	
	
	public int getLicenseId() {
		return licenseId;
	}
	public void setLicenseId(int licenseId) {
		this.licenseId = licenseId;
	}
	public int getRequestId() {
		return requestId;
	}
	public void setRequestId(int requestId) {
		this.requestId = requestId;
	}
	public String getLicenseName() {
		return licenseName;
	}
	public void setLicenseName(String licenseName) {
		this.licenseName = licenseName;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
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

	
}
