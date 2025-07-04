package bean;

import java.security.Timestamp;

public class Wiki {

	
	private int Wiki_id;				//社内WikiID
	private int user_id;				//ユーザー情報ID
	private String title;				//タイトル
	private String text;				//本文
	private String category;;			//カテゴリ
	public int getUser_id() {
		return user_id;
	}


	public void setUser_id(int user_id) {
		this.user_id = user_id;
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


	public Timestamp getUpdate_date() {
		return update_date;
	}


	public void setUpdate_date(Timestamp update_date) {
		this.update_date = update_date;
	}


	private Timestamp regist_date;		//登録日t時
	private Timestamp update_date;		//更新日時
	

		public int getWiki_id() {
			return Wiki_id;
		}
		

		public void setWiki_id(int Wiki_id) {
			this.Wiki_id = Wiki_id;
		}


		
}


		



