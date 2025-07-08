package bean;



public class Monthjack {

	private int monthJackworksId;			//今月のJackWorksID
	private int userId;						//ユーザー情報ID
	private String image;					//画像
	private String theme;					//今月のテーマ
	private String note;					//備考
	
	
	public int getMonthJackworksId() {
		return monthJackworksId;
	}
	public void setMonthJackworksId(int monthJackworksId) {
		this.monthJackworksId = monthJackworksId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
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
