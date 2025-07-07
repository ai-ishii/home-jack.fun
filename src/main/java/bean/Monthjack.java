package bean;



public class Monthjack {

	private int month_jackworks_id;			//今月のJackWorksID
	private int user_id;					//ユーザー情報ID
	private String image;					//画像
	private String theme;					//今月のテーマ
	private String note;					//備考
	
	public int getMonth_jackworks_id() {
		return month_jackworks_id;
	}
	

	public void setMonth_jackworks_id(int month_jackworks_id) {
		this.month_jackworks_id = month_jackworks_id;
	}


	public int getUser_id() {
		return user_id;
	}


	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}


	public String getImage() {
		return image;
	}


	public void setImage(String image) {
		this.image = image;
	}


	public String getTheme() {
		return theme;
	}


	public void setTheme(String theme) {
		this.theme = theme;
	}


	public String getNote() {
		return note;
	}


	public void setNote(String note) {
		this.note = note;
	}
	
	
}
