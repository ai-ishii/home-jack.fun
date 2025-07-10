package bean;

import java.sql.Timestamp;

public class Question {

	
	private int questionId;					//質問者ID
	private int userId;						//ユーザー情報ID
	private String text;					//質問内容
	private String answer;					//回答
	private Timestamp questionDate;			//質問日時
	private Timestamp answerDate;			//回答日時

	
	public int getQuestionId() {
		return questionId;
	}
	public void setQuestionId(int questionId) {
		this.questionId = questionId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public Timestamp getQuestionDate() {
		return questionDate;
	}
	public void setQuestionDate(Timestamp questionDate) {
		this.questionDate = questionDate;
	}
	public Timestamp getAnswerDate() {
		return answerDate;
	}
	public void setAnswerDate(Timestamp answerDate) {
		this.answerDate = answerDate;
	}
	
	

	
		
}


		



