/*
 * 機能：資格申請DTO
 * 
 * 作成者：桑原岳
 * 
 * 最終更新日：2025/08/01
 * 
 * */

package bean;

import java.time.LocalDate;

import jakarta.servlet.http.Part;

public class LicenseRequest {
	// request_info テーブルのフィールド
	private int requestId; 			//申請ID
	private int applicantId; 			//申請者ID
	private int approverId; 			//承認者ID
	private String applicant; 			//申請者名
	private String approver; 			//承認者名
	private LocalDate requestDate; 		//申請日時
	private LocalDate approvalDate; 	//承認日時
	private int requestFlag; 			//申請フラグ(0,申請中 1,承認済み 2,申請拒否)

	// license_request_info テーブルのフィールド
	private int licenseRequestId; 		//資格申請ID
	private int groupId; 				//所属グループID
	private int departmentId; 			//部ID
	private int licenseId; 			//資格ID
	private LocalDate examDate; 		//受験日
	private int examTime; 				//受験回数
	private Part receipt; 				//領収書画像
	private Part passing; 				//合格証画像

	private String groupName; 			//グループ名 (group_infoより)
	private String departmentName; 		// 部名 (department_infoより)
	private String licenseName;	 		// 資格名 (license_infoより)
	public int getRequestId() {
		return requestId;
	}
	public void setRequestId(int requestId) {
		this.requestId = requestId;
	}
	public int getApplicantId() {
		return applicantId;
	}
	public void setApplicantId(int applicantId) {
		this.applicantId = applicantId;
	}
	public int getApproverId() {
		return approverId;
	}
	public void setApproverId(int approverId) {
		this.approverId = approverId;
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
	public LocalDate getRequestDate() {
		return requestDate;
	}
	public void setRequestDate(LocalDate requestDate) {
		this.requestDate = requestDate;
	}
	public LocalDate getApprovalDate() {
		return approvalDate;
	}
	public void setApprovalDate(LocalDate approvalDate) {
		this.approvalDate = approvalDate;
	}
	public int getRequestFlag() {
		return requestFlag;
	}
	public void setRequestFlag(int requestFlag) {
		this.requestFlag = requestFlag;
	}
	public int getLicenseRequestId() {
		return licenseRequestId;
	}
	public void setLicenseRequestId(int licenseRequestId) {
		this.licenseRequestId = licenseRequestId;
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
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public String getDepartmentName() {
		return departmentName;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	public String getLicenseName() {
		return licenseName;
	}
	public void setLicenseName(String licenseName) {
		this.licenseName = licenseName;
	}

	
	
	
}