package bean;

public class QuaterGoal {

	
	private int quaterGoal_id;				//四半期目標ID
	private int goal_id;					//個人目標ID
	private int user_id;					//ユーザー情報ID
	private String small_goal;				//小目標
	private String judge_material;			//判断基準・材料
	private String achieve_rate;			//達成率
	private String report;					//報告内容
	private String achieve_rate_reviewer;	//達成率（評価者）
	private String evaluation;				//評価
	private int quaterly_flag;				//四半期判断フラグ
	
	

		public int getQuaterGoal_id() {
			return quaterGoal_id;
		}
		

		public void setQuaterGoal_id(int quaterGoal_id) {
			this.quaterGoal_id = quaterGoal_id;
		}


		public int getGoal_id() {
			return goal_id;
		}


		public void setGoal_id(int goal_id) {
			this.goal_id = goal_id;
		}


		public int getUser_id() {
			return user_id;
		}


		public void setUser_id(int user_id) {
			this.user_id = user_id;
		}


		public String getSmall_goal() {
			return small_goal;
		}


		public void setSmall_goal(String small_goal) {
			this.small_goal = small_goal;
		}


		public String getJudge_material() {
			return judge_material;
		}


		public void setJudge_material(String judge_material) {
			this.judge_material = judge_material;
		}


		public String getAchieve_rate() {
			return achieve_rate;
		}


		public void setAchieve_rate(String achieve_rate) {
			this.achieve_rate = achieve_rate;
		}


		public String getReport() {
			return report;
		}


		public void setReport(String report) {
			this.report = report;
		}


		public String getAchieve_rate_reviewer() {
			return achieve_rate_reviewer;
		}


		public void setAchieve_rate_reviewer(String achieve_rate_reviewer) {
			this.achieve_rate_reviewer = achieve_rate_reviewer;
		}


		public String getEvaluation() {
			return evaluation;
		}


		public void setEvaluation(String evaluation) {
			this.evaluation = evaluation;
		}


		public int getQuaterly_flag() {
			return quaterly_flag;
		}


		public void setQuaterly_flag(int quaterly_flag) {
			this.quaterly_flag = quaterly_flag;
		}
}


		



