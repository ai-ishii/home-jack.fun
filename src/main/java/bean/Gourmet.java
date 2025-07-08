package bean;

import java.sql.Timestamp;

public class Gourmet {

	
	private int gourmetId;				//グルメマップID
	private String store;				//店名
	private String address;				//住所
	private String post;				//郵便番号
	private String businessHours;		//営業時間
	private String url;					//URL
	private String image1;				//画像1
	private String imagae2;				//画像2
	private String image3;				//画像3
	private int category;				//カテゴリ
	private String comment;				//コメント
	private double assessmentPoint;		//評価点
	private int favoriteFlag;			//お気に入りフラグ
	private int displayFlag;			//非表示フラグ
	private Timestamp registDate;		//登録日時
	private Timestamp updateDate;		//更新日時
	
	
	public int getGourmetId() {
		return gourmetId;
	}
	public void setGourmetId(int gourmetId) {
		this.gourmetId = gourmetId;
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
	public String getBusinessHours() {
		return businessHours;
	}
	public void setBusinessHours(String businessHours) {
		this.businessHours = businessHours;
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
	public double getAssessmentPoint() {
		return assessmentPoint;
	}
	public void setAssessmentPoint(double assessmentPoint) {
		this.assessmentPoint = assessmentPoint;
	}
	public int getFavoriteFlag() {
		return favoriteFlag;
	}
	public void setFavoriteFlag(int favoriteFlag) {
		this.favoriteFlag = favoriteFlag;
	}
	public int getDisplayFlag() {
		return displayFlag;
	}
	public void setDisplayFlag(int displayFlag) {
		this.displayFlag = displayFlag;
	}
	public Timestamp getRegistDate() {
		return registDate;
	}
	public void setRegistDate(Timestamp registDate) {
		this.registDate = registDate;
	}
	public Timestamp getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Timestamp updateDate) {
		this.updateDate = updateDate;
	}
	
	

		
}


		



