package bean;

import java.sql.Timestamp;

public class QuarterGoal {

	
	private int quarterGoalId;				//四半期目標ID
	private int goalId;						//個人目標ID
	private int userId;						//ユーザー情報ID
	private String smallGoal;				//小目標
	private String judgeMaterial;			//判断基準・材料
	private String achieveRate;				//達成率
	private String report;					//報告内容
	private String achieveRateReviewer;		//達成率（評価者）
	private String evaluation;				//評価
	private int quarterlyFlag;				//四半期判断フラグ
	private Timestamp registDate;			//登録日時
	private Timestamp updateDate;			//更新日時
	
	

	
	
	
	public int getQuarterGoalId() {
		return quarterGoalId;
	}
	public void setQuarterGoalId(int quarterGoalId) {
		this.quarterGoalId = quarterGoalId;
	}
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
	public String getSmallGoal() {
		return smallGoal;
	}
	public void setSmallGoal(String smallGoal) {
		this.smallGoal = smallGoal;
	}
	public String getJudgeMaterial() {
		return judgeMaterial;
	}
	public void setJudgeMaterial(String judgeMaterial) {
		this.judgeMaterial = judgeMaterial;
	}
	public String getAchieveRate() {
		return achieveRate;
	}
	public void setAchieveRate(String achieveRate) {
		this.achieveRate = achieveRate;
	}
	public String getReport() {
		return report;
	}
	public void setReport(String report) {
		this.report = report;
	}
	public String getAchieveRateReviewer() {
		return achieveRateReviewer;
	}
	public void setAchieveRateReviewer(String achieveRateReviewer) {
		this.achieveRateReviewer = achieveRateReviewer;
	}
	public String getEvaluation() {
		return evaluation;
	}
	public void setEvaluation(String evaluation) {
		this.evaluation = evaluation;
	}
	public int getQuarterlyFlag() {
		return quarterlyFlag;
	}
	public void setQuarterlyFlag(int quarterlyFlag) {
		this.quarterlyFlag = quarterlyFlag;
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


		



