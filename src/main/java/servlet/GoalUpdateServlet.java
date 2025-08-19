/**
 * 個人目標更新機能
 * 
 * 作成者：月向亮太
 * 
 * 更新者：大北直弥
 * 
 * 作成日：7月14日
 * 
 * 最終更新日：8月18日
 * 
 */
package servlet;

import java.io.IOException;

import bean.Goal;
import bean.GoalDepartment;
import bean.GoalQuarter;
import dao.GoalDAO;
import dao.GoalDepartmentDAO;
import dao.GoalQuarterDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/goalUpdate")
public class GoalUpdateServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		commonProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		commonProcess(request, response);
	}

	//共通メソッド
	private void commonProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String error = "";

		try {

			// オブジェクトの生成
			Goal goal = new Goal();
			GoalDAO goalDAO = new GoalDAO();
			GoalDepartment goalDepartment = new GoalDepartment();

			// 各DAOをインスタンス化し、メソッドを呼び出す
			GoalDepartmentDAO goalDepartmentDAO = new GoalDepartmentDAO();
			GoalQuarterDAO GoalQuarterDAO = new GoalQuarterDAO();

			//getParameterメソッドを使い、取得した値を代入する
			String groupCode = request.getParameter("group_code");
			String departmentGoal = request.getParameter("department_goal");
			String groupGoal = request.getParameter("group_goal");
			String strGoalId = request.getParameter("goal_id");
			String annualGoal = request.getParameter("annual_goal");
			String situationChallenge = request.getParameter("situation_challenge");
			String strResult = request.getParameter("result");
			String resultComment = request.getParameter("result_comment");
			String strResultReviewer = request.getParameter("result_reviewer");
			String resultCommentReviewer = request.getParameter("result_comment_reviewer");
			
			// int型で格納する変数をパースする
			int goalId = Integer.parseInt(strGoalId);	
			int result = Integer.parseInt(strResult);
			int resultReviewer = Integer.parseInt(strResultReviewer);

			// セッターメソッドを呼び出す
			goalDepartment.setGroupCode(groupCode);
			goalDepartment.setDepartmentGoal(departmentGoal);
			goalDepartment.setGroupGoal(groupGoal);
			goal.setGoalId(goalId);
			goal.setAnnualGoal(annualGoal);
			goal.setSituationChallenge(situationChallenge);
			goal.setResult(result);
			goal.setResultComment(resultComment);
			goal.setResultReviewer(resultReviewer);
			goal.setResultCommentReviewer(resultCommentReviewer);
			
			// updateメソッドを呼び出す
			goalDepartmentDAO.update(goalDepartment);
			goalDAO.update(goal);

			for (int i = 1; i <= 4; i++) {
				// GoalQuarterオブジェクトの生成
				GoalQuarter GoalQuarter = new GoalQuarter();

				// getParameterメソッドを呼び出す
				String strGoalQuarterId = request.getParameter("quarter_goal_id" + (i));
				String smallGoal = request.getParameter("small_goal" + (i));
				String judgeMaterial = request.getParameter("judge_material" + (i));
				String strAchieveRate = request.getParameter("achieve_rate" + (i));
				String Report = request.getParameter("report" + (i));
				String strAchieveRateReviewer = request.getParameter("achieve_rate_reviewer" + (i));
				String Evaluation = request.getParameter("evaluation" + (i));
				String strQuarterlyFlag = request.getParameter("quarterly_flag" + (i));
				
				// int型で格納する変数をパースする
				int goalQuarterId = Integer.parseInt(strGoalQuarterId);
				int achieveRate = Integer.parseInt(strAchieveRate);
				int achieveRateReviewer = Integer.parseInt(strAchieveRateReviewer);
				int quarterlyFlag = Integer.parseInt(strQuarterlyFlag);

				//セッターメソッドを使って格納する
				GoalQuarter.setGoalQuarterId(goalQuarterId);
				GoalQuarter.setSmallGoal(smallGoal);
				GoalQuarter.setJudgeMaterial(judgeMaterial);
				GoalQuarter.setAchieveRate(achieveRate);
				GoalQuarter.setReport(Report);
				GoalQuarter.setAchieveRateReviewer(achieveRateReviewer);
				GoalQuarter.setEvaluation(Evaluation);
				GoalQuarter.setQuarterlyFlag(quarterlyFlag);

				//GoalQuarterを引数にupdateメソッドを呼び出す
				GoalQuarterDAO.update(GoalQuarter);
			}

		} catch (Exception e) {
			error = "エラーです！";
		} finally {
			if (!error.isEmpty()) {
				request.getRequestDispatcher("/view/error.jsp").forward(request, response);
			}
			//フォワードする
			request.getRequestDispatcher("/goalConfirm?cmd=confirm").forward(request, response);
		}
	}
}
