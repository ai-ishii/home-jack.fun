package bean;

public class AnnounceFile {

	private int announceImageId;	//お知らせ画像ID
	private int announceId;			//お知らせID
	private String file;			//お知らせ添付ファイル
	
	
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
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
}
