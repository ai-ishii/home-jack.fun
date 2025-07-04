package bean;

import java.security.Timestamp;

public class Question {

	
	private int question_id;				//質問者ID
	private int user_id;					//ユーザー情報ID
	private String text;					//質問内容
	private String answer;					//回答
	private Timestamp question_date;		//質問日時
	private Timestamp answer_date;			//回答日時
	
	

		public int getQuestion_id() {
			return question_id;
		}
		

		public void setQuestion_id(int question_id) {
			this.question_id = question_id;
		}


		public int getUser_id() {
			return user_id;
		}


		public void setUser_id(int user_id) {
			this.user_id = user_id;
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


		public Timestamp getQuestion_date() {
			return question_date;
		}


		public void setQuestion_date(Timestamp question_date) {
			this.question_date = question_date;
		}


		public Timestamp getAnswer_date() {
			return answer_date;
		}


		public void setAnswer_date(Timestamp answer_date) {
			this.answer_date = answer_date;
		}


		
}


		



