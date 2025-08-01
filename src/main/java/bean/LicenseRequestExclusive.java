package bean;

import java.sql.Timestamp;

public class LicenseRequestExclusive {

	// request_info テーブルのフィールド
	private int requestId; 				//申請ID
	private int applicantId; 				//申請者ID
	private int approverId; 				//承認者ID
	private String applicant; 				//申請者名
	private String approver; 				//承認者名
	private Timestamp requestDate; 			//申請日時
	private Timestamp approvalDate; 		//承認日時
	private int requestFlag; 				//申請フラグ(0,申請中 1,承認済み 2,申請拒否)

	// license_request_info テーブルのフィールド
	private int licenseRequestId; 			//資格申請ID
	private int groupId; 					//所属グループID
	private int departmentId; 				//部ID
	private int licenseId; 				//資格ID
	private Timestamp examDate; 			//受験日
	private int examTime; 					//受験回数
	private String receipt; 				//領収書画像
	private String passing; 				//合格証画像

	
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

	public Timestamp getRequestDate() {
		return requestDate;
	}

	public void setRequestDate(Timestamp requestDate) {
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


	public String getPassing() {
		return passing;
	}

	public void setPassing(String passing) {
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
