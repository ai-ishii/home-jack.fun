package bean;

import java.sql.Timestamp;

public class LicenseList{

	
	private int licenseListId;				//資格検定取得ID
	private int userId;						//ユーザー情報ID
	private Timestamp registDate;			//登録日時
	private String image;					//画像
	
	
	public int getLicenseListId() {
		return licenseListId;
	}
	public void setLicenseListId(int licenseListId) {
		this.licenseListId = licenseListId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public Timestamp getRegistDate() {
		return registDate;
	}
	public void setRegistDate(Timestamp registDate) {
		this.registDate = registDate;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	

		

}


		