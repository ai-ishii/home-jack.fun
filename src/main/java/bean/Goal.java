/*
 * 個人目標を管理するDTOファイル
 * 
 * 作成者:月向亮太
 * 
 * 更新日:2025/08/12
 */
package bean;

import java.sql.Timestamp;

public class Goal {

	private int goalId;						//個人目標ID
	private String groupCode;					//グループコード
	private int userId;						//ユーザー情報ID
	private String annualGoal;					//年間目標
	private String situationChallenge;			//現状と課題
	private int result;						//年間結果達成率
	private String resultComment;				//年間結果コメント
	private int resultReviewer;				//年間結果達成率（評価者）
	private String resultCommentReviewer; 		//年間結果コメント（評価者）
	private Timestamp startDate;				//登録日時
	private Timestamp endDate;					//終了日時
	private Timestamp updateDate;				//更新日時
	
	public int getGoalId() {
		return goalId;
	}
	public void setGoalId(int goalId) {
		this.goalId = goalId;
	}
	public String getGroupCode() {
		return groupCode;
	}
	public void setGroupCode(String groupCode) {
		this.groupCode = groupCode;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
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
	public int getResult() {
		return result;
	}
	public void setResult(int result) {
		this.result = result;
	}
	public String getResultComment() {
		return resultComment;
	}
	public void setResultComment(String resultComment) {
		this.resultComment = resultComment;
	}
	public int getResultReviewer() {
		return resultReviewer;
	}
	public void setResultReviewer(int resultReviewer) {
		this.resultReviewer = resultReviewer;
	}
	public String getResultCommentReviewer() {
		return resultCommentReviewer;
	}
	public void setResultCommentReviewer(String resultCommentReviewer) {
		this.resultCommentReviewer = resultCommentReviewer;
	}
	public Timestamp getStartDate() {
		return startDate;
	}
	public void setStartDate(Timestamp startDate) {
		this.startDate = startDate;
	}
	public Timestamp getEndDate() {
		return endDate;
	}
	public void setEndDate(Timestamp endDate) {
		this.endDate = endDate;
	}
	public Timestamp getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Timestamp updateDate) {
		this.updateDate = updateDate;
	}
	
	
}		