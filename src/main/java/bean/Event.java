package bean;

import java.security.Timestamp;

public class Event {

	
	private int event_id;				//お知らせID
	private int user_id;				//ユーザー情報ID
	private Timestamp event_date;		//イベント日時
	private Timestamp regist_date;		//登録日時
	private Timestamp update_date;		//更新日時
	private String event;				//イベント名
	private String summary;				//イベント概要
	private int join_flag;				//参加フラグ
	private String event_time;			//イベント時間
	private String place;				//会場名
	private int fee;					//参加費
	private String url;					//参加費
	private int display_flag;			//非表示フラグ
	private int read_flag;				//未読フラグ
	private String deadline;			//回答期限
	private String note;				//備考
	
	

		public int getEvent_id() {
			return event_id;
		}
		

		public void setEvent_id(int event_id) {
			this.event_id = event_id;
		}


		public int getUser_id() {
			return user_id;
		}


		public void setUser_id(int user_id) {
			this.user_id = user_id;
		}


		public Timestamp getEvent_date() {
			return event_date;
		}


		public void setEvent_date(Timestamp event_date) {
			this.event_date = event_date;
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


		public String getEvent() {
			return event;
		}


		public void setEvent(String event) {
			this.event = event;
		}


		public String getSummary() {
			return summary;
		}


		public void setSummary(String summary) {
			this.summary = summary;
		}


		public int getJoin_flag() {
			return join_flag;
		}


		public void setJoin_flag(int join_flag) {
			this.join_flag = join_flag;
		}


		public String getEvent_time() {
			return event_time;
		}


		public void setEvent_time(String event_time) {
			this.event_time = event_time;
		}


		public String getPlace() {
			return place;
		}


		public void setPlace(String place) {
			this.place = place;
		}


		public int getFee() {
			return fee;
		}


		public void setFee(int fee) {
			this.fee = fee;
		}


		public String getUrl() {
			return url;
		}


		public void setUrl(String url) {
			this.url = url;
		}


		public int getDisplay_flag() {
			return display_flag;
		}


		public void setDisplay_flag(int display_flag) {
			this.display_flag = display_flag;
		}


		public int getRead_flag() {
			return read_flag;
		}


		public void setRead_flag(int read_flag) {
			this.read_flag = read_flag;
		}


		public String getDeadline() {
			return deadline;
		}


		public void setDeadline(String deadline) {
			this.deadline = deadline;
		}


		public String getNote() {
			return note;
		}


		public void setNote(String note) {
			this.note = note;
		}


		
}


