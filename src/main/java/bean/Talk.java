package bean;

import java.sql.Timestamp;

public class Talk {

	
	private int talkId;					//雑談ID
	private String nickname;			//ニックネーム
	private String text;				//本文
	private Timestamp postDate;			//投稿日時
	
	
	public int getTalkId() {
		return talkId;
	}
	public void setTalkId(int talkId) {
		this.talkId = talkId;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public Timestamp getPostDate() {
		return postDate;
	}
	public void setPostDate(Timestamp postDate) {
		this.postDate = postDate;
	}

		
}


		



