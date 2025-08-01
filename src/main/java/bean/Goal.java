package bean;

import java.sql.Timestamp;

public class Goal {

	
	private int goalId;							//個人目標ID
	private int userId;							//ユーザー情報ID
	private String managementTheme;				//経営テーマ
	private String departmentGoal;				//部目標
	private String groupGoal;					//グループ目標
	private String annualGoal;					//年間目標
	private String situationChallenge;			//現状と課題
	private String result;						//年間結果達成率
	private String resultComment;				//年間結果コメント
	private String resultReviewer;				//年間結果達成率（評価者）
	private String resultCommentReviewer; 		//年間結果コメント（評価者）
	private Timestamp registDate;				//登録日時
	private Timestamp updateDate;				//更新日時
	
	
	public int getGoalId() {
		return goalId;
	}
	public void setGoalId(int goalId) {
		this.goalId = goalId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getManagementTheme() {
		return managementTheme;
	}
	public void setManagementTheme(String managementTheme) {
		this.managementTheme = managementTheme;
	}
	public String getDepartmentGoal() {
		return departmentGoal;
	}
	public void setDepartmentGoal(String departmentGoal) {
		this.departmentGoal = departmentGoal;
	}
	public String getGroupGoal() {
		return groupGoal;
	}
	public void setGroupGoal(String groupGoal) {
		this.groupGoal = groupGoal;
	}
	public String getAnnualGoal() {
		return annualGoal;
	}
	public void setAnnualGoal(String annualGoal) {
		this.annualGoal = annualGoal;
	}
	public String getSituationChallenge() {
		return situationChallenge;
	}
	public void setSituationChallenge(String situationChallenge) {
		this.situationChallenge = situationChallenge;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public String getResultComment() {
		return resultComment;
	}
	public void setResultComment(String resultComment) {
		this.resultComment = resultComment;
	}
	public String getResultReviewer() {
		return resultReviewer;
	}
	public void setResultReviewer(String resultReviewer) {
		this.resultReviewer = resultReviewer;
	}
	public String getResultCommentReviewer() {
		return resultCommentReviewer;
	}
	public void setResultCommentReviewer(String resultCommentReviewer) {
		this.resultCommentReviewer = resultCommentReviewer;
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


		



