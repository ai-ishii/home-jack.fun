package bean;

import java.security.Timestamp;

public class Mailbox {
	private int contact_id;				//お問い合わせID
	private int admin_id;				//管理者ID
	private int sender_id;				//送信者ID
	private String text;				//内容
	private String title;				//件名
	private String category;			//カテゴリ
	private String regist_date;			//登録日時
	private Timestamp unread_flag;		//未読フラグ


	//contact_idのゲッターメソッド
	public int getContact_id() {
		return contact_id;
	}
	
	//contact_idのセッターメソッド
	public void setContact_id(int contact_id) {
		this.contact_id = contact_id;
	}

	//admin_idのゲッターメソッド
	public int getAdmin_id() {
		return admin_id;
	}

	//admin_idのセッターメソッド
	public void setAdmin_id(int admin_id) {
		this.admin_id = admin_id;
	}

	//sender_idのゲッターメソッド
	public int getSender_id() {
		return sender_id;
	}

	//sender_idのセッターメソッド
	public void setSender_id(int sender_id) {
		this.sender_id = sender_id;
	}

	//textのゲッターメソッド
	public String getText() {
		return text;
	}

	//textのセッターメソッド
	public void setText(String text) {
		this.text = text;
	}

	//titleのゲッターメソッド
	public String getTitle() {
		return title;
	}

	//titleのセッターメソッド
	public void setTitle(String title) {
		this.title = title;
	}

	//categoryのゲッターメソッド
	public String getCategory() {
		return category;
	}

	//categoryのセッターメソッド
	public void setCategory(String category) {
		this.category = category;
	}

	//regist_dateのゲッターメソッド
	public String getRegist_date() {
		return regist_date;
	}

	//regist_dateのセッターメソッド
	public void setRegist_date(String regist_date) {
		this.regist_date = regist_date;
	}

	//unread_flagのゲッターメソッド
	public Timestamp getUnread_flag() {
		return unread_flag;
	}

	//unread_flagのセッターメソッド
	public void setUnread_flag(Timestamp unread_flag) {
		this.unread_flag = unread_flag;
	}
}