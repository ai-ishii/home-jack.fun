package bean;

import java.security.Timestamp;

public class Contact {



	
	private int contact_id;				//お問い合わせ情報ID
	private int announce_id;			//お知らせID
	private int user_id;				//ユーザー情報ID
	private String text;				//本文
	private String title;				//タイトル
	private String category;			//カテゴリ
	private Timestamp regist_date;		//登録日時
	private int unread_flag;			//未読フラグ
	
	
	

		public int getContact_id() {
			return contact_id;
		}
		

		public void setContact_id(int contact_id) {
			this.contact_id = contact_id;
		}


		public int getAnnounce_id() {
			return announce_id;
		}


		public void setAnnounce_id(int announce_id) {
			this.announce_id = announce_id;
		}


		public int getUser_id() {
			return user_id;
		}


		public void setUser_id(int user_id) {
			this.user_id = user_id;
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


		public Timestamp getRegist_date() {
			return regist_date;
		}


		public void setRegist_date(Timestamp regist_date) {
			this.regist_date = regist_date;
		}


		public int getUnread_flag() {
			return unread_flag;
		}


		public void setUnread_flag(int unread_flag) {
			this.unread_flag = unread_flag;
		}


		
}


