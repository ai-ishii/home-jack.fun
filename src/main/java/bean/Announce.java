package bean;

import java.sql.Timestamp;

public class Announce {

	private int announceId; 			//お知らせID
	private int userId; 				//ユーザー情報ID
	private String name;				//編集者名
	private Timestamp registDate;		//登録日時
	private Timestamp updateDate;		//更新日時
	private String title; 				//タイトル
	private String text; 				//本文
	private String comment; 			//コメント
	private int likeFlag; 				//いいねフラグ
	private int announceFlag; 			//お知らせ表示フラグ
	private int announceCategoryId; 	//カテゴリ
	private String tag; 				//タグ


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


	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public int getLikeFlag() {
		return likeFlag;
	}

	public void setLikeFlag(int likeFlag) {
		this.likeFlag = likeFlag;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAnnounceFlag() {
		return announceFlag;
	}

	public void setAnnounceFlag(int announceFlag) {
		this.announceFlag = announceFlag;
	}

	public int getAnnounceCategoryId() {
		return announceCategoryId;
	}

	public void setAnnounceCategoryId(int announceCategoryId) {
		this.announceCategoryId = announceCategoryId;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	
}
