package bean;

import java.security.Timestamp;

public class Talk {

	
	private int talk_id;				//雑談ID
	private String nickname;			//ニックネーム
	private String text;				//本文
	private Timestamp post_date;		//投稿日時

		public int getTalk_id() {
			return talk_id;
		}
		

		public void setTalk_id(int talk_id) {
			this.talk_id = talk_id;
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


		public Timestamp getPost_date() {
			return post_date;
		}


		public void setPost_date(Timestamp post_date) {
			this.post_date = post_date;
		}


		


		
}


		



