package bean;

import java.sql.Timestamp;

public class Employee {

	
	private int employeeId;				//社員紹介ID
	private int userId;					//ユーザー情報ID
	private int devloper;				//開発経験年数
	private String langSkill;			//習得技術（言語）
	private String middleSkill;			//習得技術（ミドルウェア）
	private String hobby;				//趣味
	private String talent;				//特技
	private String intro;				//自己紹介
	private String position;			//役職
	private Timestamp registDate;		//登録日時
	private Timestamp updateDate;		//更新日時
	private String photo;				//社員写真
	
	
	public int getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(int employeeId) {
		this.employeeId = employeeId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getDevloper() {
		return devloper;
	}
	public void setDevloper(int devloper) {
		this.devloper = devloper;
	}
	public String getLangSkill() {
		return langSkill;
	}
	public void setLangSkill(String langSkill) {
		this.langSkill = langSkill;
	}
	public String getMiddleSkill() {
		return middleSkill;
	}
	public void setMiddleSkill(String middleSkill) {
		this.middleSkill = middleSkill;
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
	public Timestamp getRegistDate() {
		return registDate;
	}
	public void setRegistDate(Timestamp registDate) {
		this.registDate = registDate;
	}
	public Timestamp getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Timestamp updateDate) {
		this.updateDate = updateDate;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	
	
	

		
		
}


