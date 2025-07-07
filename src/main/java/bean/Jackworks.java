package bean;

import java.security.Timestamp;

public class Jackworks{

	
	private int jackworks_id;				//JackWorksID
	private int user_id;					//ユーザー情報ID
	private String category;				//カテゴリ
	private String assessment;				//評価項目
	private int point;						//付与ポイント
	private Timestamp points_get_date;		//ポイント取得年月日
	private String note;					//備考
	private String imagae;					//画像
	
		public int getJackworks_id() {
			return jackworks_id;
		}


		public void setJackworks_id(int jackworks_id) {
			this.jackworks_id = jackworks_id;
		}


		public int getUser_id() {
			return user_id;
		}


		public void setUser_id(int user_id) {
			this.user_id = user_id;
		}


		public String getCategory() {
			return category;
		}


		public void setCategory(String category) {
			this.category = category;
		}


		public String getAssessment() {
			return assessment;
		}


		public void setAssessment(String assessment) {
			this.assessment = assessment;
		}


		public int getPoint() {
			return point;
		}


		public void setPoint(int point) {
			this.point = point;
		}


		public Timestamp getPoints_get_date() {
			return points_get_date;
		}


		public void setPoints_get_date(Timestamp points_get_date) {
			this.points_get_date = points_get_date;
		}


		public String getNote() {
			return note;
		}


		public void setNote(String note) {
			this.note = note;
		}


		public String getImagae() {
			return imagae;
		}


		public void setImagae(String imagae) {
			this.imagae = imagae;
		}


		

}


		



