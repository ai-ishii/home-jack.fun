package bean;

import java.sql.Timestamp;

public class TeamGoal {

	
	private String teamId;				//グループ目標ID
	private int userId;					//ユーザー情報ID
	private String managementTheme;		//経営テーマ
	private String departmentGoal;		//部目標
	private String groupGoal;			//グループ目標
	private Timestamp registDate;		//登録日時
	private Timestamp updateDate;		//更新日時
	
	
	public String getTeamId() {
		return teamId;
	}
	public void setTeamId(String teamId) {
		this.teamId = teamId;
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
