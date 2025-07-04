package bean;

import java.security.Timestamp;

public class Goal {

	
	private int goal_id;					//お知らせID
	private int user_id;					//ユーザー情報ID
	private String management_theme;		//イベント名
	private String department_goal;			//イベント概要
	private String group_goal;				//参加フラグ
	private String annual_goal;				//イベント時間
	private String situation_challenge;		//会場名
	private String result;					//参加費
	private String result_comment;			//参加費
	private int result_reviewer;			//非表示フラグ
	private Timestamp regist_date;			//登録日時
	private Timestamp update_date;			//更新日時
	
	

		public int getGoal_id() {
			return goal_id;
		}
		

		public void setGoal_id(int goal_id) {
			this.goal_id = goal_id;
		}


		public int getUser_id() {
			return user_id;
		}


		public void setUser_id(int user_id) {
			this.user_id = user_id;
		}


		public String getManagement_theme() {
			return management_theme;
		}


		public void setManagement_theme(String management_theme) {
			this.management_theme = management_theme;
		}


		public String getDepartment_goal() {
			return department_goal;
		}


		public void setDepartment_goal(String department_goal) {
			this.department_goal = department_goal;
		}


		public String getGroup_goal() {
			return group_goal;
		}


		public void setGroup_goal(String group_goal) {
			this.group_goal = group_goal;
		}


		public String getAnnual_goal() {
			return annual_goal;
		}


		public void setAnnual_goal(String annual_goal) {
			this.annual_goal = annual_goal;
		}


		public String getSituation_challenge() {
			return situation_challenge;
		}


		public void setSituation_challenge(String situation_challenge) {
			this.situation_challenge = situation_challenge;
		}


		public String getResult() {
			return result;
		}


		public void setResult(String result) {
			this.result = result;
		}


		public String getResult_comment() {
			return result_comment;
		}


		public void setResult_comment(String result_comment) {
			this.result_comment = result_comment;
		}


		public int getResult_reviewer() {
			return result_reviewer;
		}


		public void setResult_reviewer(int result_reviewer) {
			this.result_reviewer = result_reviewer;
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



}


		



