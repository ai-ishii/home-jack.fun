/*
 * 機能：資格申請DTO
 * 
 * 作成者：桑原岳
 * 
 * 更新者：大北直弥
 * 
 * 最終更新日：2025/08/25
 * 
 * */

package bean;

import java.time.LocalDate;

import jakarta.servlet.http.Part;

public class LicenseRequest {

	private int licenseRequestId; 		//資格申請ID
	private int requestId;				//申請ID
	private int groupId; 				//所属グループID
	private int departmentId; 			//部ID
	private int licenseId; 			//資格ID
	private LocalDate examDate; 		//受験日
	private int examTime; 				//受験回数
	private Part receipt; 				//領収書画像
	private Part passing; 				//合格証画像

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
	public LocalDate getExamDate() {
		return examDate;
	}
	public void setExamDate(LocalDate examDate) {
		this.examDate = examDate;
	}
	public int getExamTime() {
		return examTime;
	}
	public void setExamTime(int examTime) {
		this.examTime = examTime;
	}
	public Part getReceipt() {
		return receipt;
	}
	public void setReceipt(Part receipt) {
		this.receipt = receipt;
	}
	public Part getPassing() {
		return passing;
	}
	public void setPassing(Part passing) {
		this.passing = passing;
	}

}