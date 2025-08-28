/*
 * 機能：資格申請一覧に表示する内容を格納するためのDTO
 * 
 * 作成者：桑原岳
 * 
 * 最終更新日：2025/08/27
 * 
 * */

package bean;

import java.sql.Timestamp;
import java.time.LocalDate;

public class LicenseRequestExclusive {

	// request_info テーブルのフィールド
	private int requestId; 				//申請ID
	private int applicantId; 				//申請者ID
	private int approverId; 				//承認者ID
	private String applicant; 				//申請者名
	private String approver; 				//承認者名
	private LocalDate requestDate; 			//申請日時
	private Timestamp approvalDate; 		//承認日時
	private int requestFlag; 				//申請フラグ(0,申請中 1,承認済み 2,申請拒否)

	// license_request_info テーブルのフィールド
	private int licenseRequestId; 			//資格申請ID
	private int groupId; 					//所属グループID
	private int departmentId; 				//部ID
	private int licenseId; 				//資格ID
	private LocalDate  examDate; 			//受験日
	private int examTime; 					//受験回数
	private byte[] receipt; 				//領収書画像
	private byte[] passing; 				//合格証画像
	private String receiptName; 			//領収書画像名
	private String passingName; 			//合格証画像名

	
	private String groupName; 				//グループ名 (group_infoより)
	private String departmentName; 			// 部名 (department_infoより)
	private String licenseName; 			// 資格名 (license_infoより)

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

	public Timestamp getApprovalDate() {
		return approvalDate;
	}

	public void setApprovalDate(Timestamp approvalDate) {
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

	public byte[] getReceipt() {
		return receipt;
	}

	public void setReceipt(byte[] receipt) {
		this.receipt = receipt;
	}


	public byte[] getPassing() {
		return passing;
	}

	public void setPassing(byte[] passing) {
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

	public String getReceiptName() {
		return receiptName;
	}

	public void setReceiptName(String receiptName) {
		this.receiptName = receiptName;
	}

	public String getPassingName() {
		return passingName;
	}

	public void setPassingName(String passingName) {
		this.passingName = passingName;
	}

}
