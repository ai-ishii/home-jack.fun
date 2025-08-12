/*
 * チーム名・チーム目標を管理するDTOファイル
 * 
 * 作成者:月向亮太
 * 
 * 更新日:2025/08/08
 */
package bean;

import java.sql.Timestamp;

public class GoalDepartment {

	private int goalDepartmentId;		// 部署目標ID
	private String groupCode;			// グループコード
	private String name;				// 部・グループ名
	private String managementTheme;		// 経営テーマ
	private String departmentGoal;		// 部目標
	private String groupGoal;			// グループ目標
	private Timestamp startDate;		// 開始日時
	private Timestamp endDate;			// 終了日時
	private Timestamp updateDate;		// 編集日時

	public int getGoalDepartmentId() {
		return goalDepartmentId;
	}

	public void setGoalDepartmentId(int goalDepartmentId) {
		this.goalDepartmentId = goalDepartmentId;
	}

	public String getGroupCode() {
		return groupCode;
	}

	public void setGroupCode(String groupCode) {
		this.groupCode = groupCode;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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
