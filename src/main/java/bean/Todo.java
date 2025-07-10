package bean;

import java.sql.Timestamp;

public class Todo {

	
	private int todoId;						//TodoID
	private int userId;						//ユーザー情報ID
	private String task;					//タスク名
	private String text;					//タスク内容
	private String deadline;				//回答期限
	private int checkFlag;					//チェックフラグ
	private Timestamp registDate;			//登録日時
	private Timestamp updateDate;			//更新日時
	
	
	public int getTodoId() {
		return todoId;
	}
	public void setTodoId(int todoId) {
		this.todoId = todoId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
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
	public int getCheckFlag() {
		return checkFlag;
	}
	public void setCheckFlag(int checkFlag) {
		this.checkFlag = checkFlag;
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
	
	

		
}


		



