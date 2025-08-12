/*
 * 四半期目標を管理するDTOファイル
 * 
 * 作成者:月向亮太
 * 
 * 更新日:2025/08/12
 */
package bean;

public class GoalQuarter {

	private int GoalQuarterId;			// 四半期目標ID
	private int goalId;				// 個人目標ID
	private String smallGoal;			// 小目標
	private String judgeMaterial;		// 判断基準・材料
	private int achieveRate;			// 達成率
	private String report;				// 報告内容
	private int achieveRateReviewer;	// 達成率(評価者)
	private String evaluation;			// 評価
	private int quarterlyFlag;			// 四半期判断フラグ

	public int getGoalQuarterId() {
		return GoalQuarterId;
	}

	public void setGoalQuarterId(int goalQuarterId) {
		GoalQuarterId = goalQuarterId;
	}

	public int getGoalId() {
		return goalId;
	}

	public void setGoalId(int goalId) {
		this.goalId = goalId;
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

	public int getAchieveRate() {
		return achieveRate;
	}

	public void setAchieveRate(int achieveRate) {
		this.achieveRate = achieveRate;
	}

	public String getReport() {
		return report;
	}

	public void setReport(String report) {
		this.report = report;
	}

	public int getAchieveRateReviewer() {
		return achieveRateReviewer;
	}

	public void setAchieveRateReviewer(int achieveRateReviewer) {
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

}
