package bean;

import java.sql.Timestamp;

public class Contact {

	private int contactId; //お問い合わせ情報ID
	private int announceId; //お知らせID
	private int userId; //ユーザー情報ID
	private String text; //本文
	private String title; //タイトル
	private String category; //カテゴリ
	private Timestamp registDate; //登録日時
	private int unreadFlag; //未読フラグ

	public int getContactId() {
		return contactId;
	}

	public void setContactId(int contactId) {
		this.contactId = contactId;
	}

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

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public Timestamp getRegistDate() {
		return registDate;
	}

	public void setRegistDate(Timestamp registDate) {
		this.registDate = registDate;
	}

	public int getUnreadFlag() {
		return unreadFlag;
	}

	public void setUnreadFlag(int unreadFlag) {
		this.unreadFlag = unreadFlag;
	}

	

}
