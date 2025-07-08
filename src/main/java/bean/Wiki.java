package bean;

import java.sql.Timestamp;

public class Wiki {

	
	private int WikiId;					//社内WikiID
	private int userId	;				//ユーザー情報ID
	private String title;				//タイトル
	private String text;				//本文
	private String category;			//カテゴリ
	
	
	public int getWikiId() {
		return WikiId;
	}
	public void setWikiId(int wikiId) {
		WikiId = wikiId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
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
	
	
		
}


		



