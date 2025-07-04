package bean;

import java.security.Timestamp;

public class License{

	
	private int license_id;				//資格申請ID
	private String applicant;			//申請者
	private String approver;			//承認者
	private String image;				//画像
	private Timestamp request_date;		//申請日時
	private Timestamp exam_date;		//受験日時
	private int exam_time;				//受験回数
	private int request_flag;			//申請フラグ
	

		public int getLicense_id() {
			return license_id;
		}
		

		public void setLicense_id(int license_id) {
			this.license_id = license_id;
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


		public Timestamp getRequest_date() {
			return request_date;
		}


		public void setRequest_date(Timestamp request_date) {
			this.request_date = request_date;
		}


		public Timestamp getExam_date() {
			return exam_date;
		}


		public void setExam_date(Timestamp exam_date) {
			this.exam_date = exam_date;
		}


		public int getExam_time() {
			return exam_time;
		}


		public void setExam_time(int exam_time) {
			this.exam_time = exam_time;
		}


		public int getRequest_flag() {
			return request_flag;
		}


		public void setRequest_flag(int request_flag) {
			this.request_flag = request_flag;
		}


		


		

}


		



