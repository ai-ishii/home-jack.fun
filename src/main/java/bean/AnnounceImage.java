package bean;

public class AnnounceImage {

	private int announceImageId;	//お知らせ画像ID
	private int announceId;			//お知らせID
	private String image;			//お知らせ画像
	
	
	public int getAnnounceImageId() {
		return announceImageId;
	}
	public void setAnnounceImageId(int announceImageId) {
		this.announceImageId = announceImageId;
	}
	public int getAnnounceId() {
		return announceId;
	}
	public void setAnnounceId(int announceId) {
		this.announceId = announceId;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	
}
