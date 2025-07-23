package bean;

import java.sql.Timestamp;

public class Request {
	
		private int requestId;       		//申請ID
		private int applicantId;          	//申請者ID
		private int approverId;        	//承認者ID
		private String name;               //氏名
		private Timestamp requestDate;  	//申請日時
		private int requestTypeFlag;		//申請種類フラグ(0,住所 1,氏名 2,勤務状況 3,資格)
		private int requestFlag; 			//申請フラグ(0,申請中 1,承認済み 2,申請拒否)
		
		
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
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public Timestamp getRequestDate() {
			return requestDate;
		}
		public void setRequestDate(Timestamp requestDate) {
			this.requestDate = requestDate;
		}
		public int getRequestTypeFlag() {
			return requestTypeFlag;
		}
		public void setRequestTypeFlag(int requestTypeFlag) {
			this.requestTypeFlag = requestTypeFlag;
		}
		public int getRequestFlag() {
			return requestFlag;
		}
		public void setRequestFlag(int requestFlag) {
			this.requestFlag = requestFlag;
		}

}
