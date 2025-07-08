package bean;

import java.sql.Timestamp;

public class Announce {

	private int announceId; 			//お知らせID
	private int userId; 				//ユーザー情報ID
	private Timestamp registDate;		//登録日時
	private Timestamp updateDate;		//更新日時
	private String title; 				//タイトル
	private String text; 				//本文
	private String image; 				//画像
	private String comment; 			//コメント
	private int iineFlag; 				//いいねフラグ
	private int announceFlag; 			//お知らせ表示フラグ
	private int favoriteFlag; 			//お気に入りフラグ
	private int category; 				//カテゴリ
	private String tag; 				//タグ
	private String file; 				//ファイル

	public int getAnnounceId() {
		return announceId;
	}

	public void setAnnounceId(int announceId) {
		this.announceId = announceId;
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

	public Timestamp getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Timestamp updateDate) {
		this.updateDate = updateDate;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public int getIineFlag() {
		return iineFlag;
	}

	public void setIineFlag(int iine_flag) {
		this.iineFlag = iine_flag;
	}

	public int getAnnounceFlag() {
		return announceFlag;
	}

	public void setAnnounceFlag(int announceFlag) {
		this.announceFlag = announceFlag;
	}

	public int getFavoriteFlag() {
		return favoriteFlag;
	}

	public void setFavoriteFlag(int favoriteFlag) {
		this.favoriteFlag = favoriteFlag;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public String getFile() {
		return file;
	}

	public void setFile(String file) {
		this.file = file;
	}

	
}
