package bean;

import java.security.Timestamp;

public class Gourmet {

	
	private int gourmet_id;				//グルメマップID
	private String store;				//店名
	private String address;				//住所
	private String post;				//郵便番号
	private String business_hours;		//営業時間
	private String url;					//URL
	private String image1;				//画像1
	private String imagae2;				//画像2
	private String image3;				//画像3
	private int category;				//カテゴリ
	private String comment;				//コメント
	private double assessment_point;	//評価点
	private int favorite_flag;			//お気に入りフラグ
	private int display_flag;			//非表示フラグ
	private Timestamp regist_date;		//登録日時
	private Timestamp update_date;		//更新日時
	
	

		public int getGourmet_id() {
			return gourmet_id;
		}
		

		public void setGourmet_id(int gourmet_id) {
			this.gourmet_id = gourmet_id;
		}


		public String getStore() {
			return store;
		}


		public void setStore(String store) {
			this.store = store;
		}


		public String getAddress() {
			return address;
		}


		public void setAddress(String address) {
			this.address = address;
		}


		public String getPost() {
			return post;
		}


		public void setPost(String post) {
			this.post = post;
		}


		public String getBusiness_hours() {
			return business_hours;
		}


		public void setBusiness_hours(String business_hours) {
			this.business_hours = business_hours;
		}


		public String getUrl() {
			return url;
		}


		public void setUrl(String url) {
			this.url = url;
		}


		public String getImage1() {
			return image1;
		}


		public void setImage1(String image1) {
			this.image1 = image1;
		}


		public String getImagae2() {
			return imagae2;
		}


		public void setImagae2(String imagae2) {
			this.imagae2 = imagae2;
		}


		public String getImage3() {
			return image3;
		}


		public void setImage3(String image3) {
			this.image3 = image3;
		}


		public int getCategory() {
			return category;
		}


		public void setCategory(int category) {
			this.category = category;
		}


		public String getComment() {
			return comment;
		}


		public void setComment(String comment) {
			this.comment = comment;
		}


		public double getAssessment_point() {
			return assessment_point;
		}


		public void setAssessment_point(double assessment_point) {
			this.assessment_point = assessment_point;
		}


		public int getFavorite_flag() {
			return favorite_flag;
		}


		public void setFavorite_flag(int favorite_flag) {
			this.favorite_flag = favorite_flag;
		}


		public int getDisplay_flag() {
			return display_flag;
		}


		public void setDisplay_flag(int display_flag) {
			this.display_flag = display_flag;
		}


		public Timestamp getRegist_date() {
			return regist_date;
		}


		public void setRegist_date(Timestamp regist_date) {
			this.regist_date = regist_date;
		}


		public Timestamp getUpdate_date() {
			return update_date;
		}


		public void setUpdate_date(Timestamp update_date) {
			this.update_date = update_date;
		}

}


		



