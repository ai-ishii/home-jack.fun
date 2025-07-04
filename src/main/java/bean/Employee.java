package bean;

import java.security.Timestamp;

public class Employee {

	
	private int employee_id;			//社員紹介ID
	private int user_id;				//ユーザー情報ID
	private int devloper;				//開発経験年数
	private String lang_skill;			//習得技術（言語）
	private String middle_skill;		//習得技術（ミドルウェア）
	private String hobby;				//趣味
	private String talent;				//特技
	private String intro;				//自己紹介
	private String position;			//役職
	private Timestamp regist_date;		//登録日時
	private Timestamp update_date;		//更新日時
	private String photo;				//社員写真
	
	
	

		public int getEmployee_id() {
			return employee_id;
		}
		

		public void setEmployee_id(int employee_id) {
			this.employee_id = employee_id;
		}


		public int getUser_id() {
			return user_id;
		}


		public void setUser_id(int user_id) {
			this.user_id = user_id;
		}


		public int getDevloper() {
			return devloper;
		}


		public void setDevloper(int devloper) {
			this.devloper = devloper;
		}


		public String getLang_skill() {
			return lang_skill;
		}


		public void setLang_skill(String lang_skill) {
			this.lang_skill = lang_skill;
		}


		public String getMiddle_skill() {
			return middle_skill;
		}


		public void setMiddle_skill(String middle_skill) {
			this.middle_skill = middle_skill;
		}


		public String getHobby() {
			return hobby;
		}


		public void setHobby(String hobby) {
			this.hobby = hobby;
		}


		public String getTalent() {
			return talent;
		}


		public void setTalent(String talent) {
			this.talent = talent;
		}


		public String getIntro() {
			return intro;
		}


		public void setIntro(String intro) {
			this.intro = intro;
		}


		public String getPosition() {
			return position;
		}


		public void setPosition(String position) {
			this.position = position;
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


		public String getPhoto() {
			return photo;
		}


		public void setPhoto(String photo) {
			this.photo = photo;
		}


		


		
}


