package bean;

import java.security.Timestamp;

public class Todo {

	
	private int todo_id;					//TodoID
	private int user_id;					//ユーザー情報ID
	private String task;					//タスク名
	private String text;					//タスク内容
	private String deadline;				//回答期限
	private int check_flag;					//チェックフラグ
	private Timestamp regist_date;			//登録日時
	private Timestamp update_date;			//更新日時
	
	

		public int getTodo_id() {
			return todo_id;
		}
		

		public void setTodo_id(int todo_id) {
			this.todo_id = todo_id;
		}


		public int getUser_id() {
			return user_id;
		}


		public void setUser_id(int user_id) {
			this.user_id = user_id;
		}


		public String getTask() {
			return task;
		}


		public void setTask(String task) {
			this.task = task;
		}


		public String getText() {
			return text;
		}


		public void setText(String text) {
			this.text = text;
		}


		public String getDeadline() {
			return deadline;
		}


		public void setDeadline(String deadline) {
			this.deadline = deadline;
		}


		public int getCheck_flag() {
			return check_flag;
		}


		public void setCheck_flag(int check_flag) {
			this.check_flag = check_flag;
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


		



