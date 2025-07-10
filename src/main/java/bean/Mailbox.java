package bean;

import java.sql.Timestamp;

public class Mailbox {
	private int contactId;				//お問い合わせID
	private int adminId;				//管理者ID
	private int senderId;				//送信者ID
	private String text;				//内容
	private String title;				//件名
	private String category;			//カテゴリ
	private String registDate;			//登録日時
	private Timestamp unreadFlag;		//未読フラグ
	
	
	public int getContactId() {
		return contactId;
	}
	public void setContactId(int contactId) {
		this.contactId = contactId;
	}
	public int getAdminId() {
		return adminId;
	}
	public void setAdminId(int adminId) {
		this.adminId = adminId;
	}
	public int getSenderId() {
		return senderId;
	}
	public void setSenderId(int senderId) {
		this.senderId = senderId;
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
	public String getRegistDate() {
		return registDate;
	}
	public void setRegistDate(String registDate) {
		this.registDate = registDate;
	}
	public Timestamp getUnreadFlag() {
		return unreadFlag;
	}
	public void setUnreadFlag(Timestamp unreadFlag) {
		this.unreadFlag = unreadFlag;
	}


	
}