/**
 * 個人目標更新機能
 * 
 * 作成者：月向亮太
 * 
 * 作成日：7月14日
 * 
 * 最終更新日：7月25日
 * 
 */
package servlet;

import java.io.IOException;
import java.util.ArrayList;

import bean.Goal;
import bean.QuarterGoal;
import bean.TeamGoal;
import dao.GoalDAO;
import dao.QuarterGoalDAO;
import dao.TeamGoalDAO;
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
		int GoalId = 0;

		try {

			//オブジェクトの生成
			TeamGoal teamGoal = new TeamGoal();
			Goal goal = new Goal();

			//各DAOをインスタンス化し、メソッドを呼び出す
			TeamGoalDAO teamGoalDAO = new TeamGoalDAO();
			GoalDAO goalDAO = new GoalDAO();
			QuarterGoalDAO quarterGoalDAO = new QuarterGoalDAO();

			//getParameterメソッドを使い、取得した値を代入する
			String TeamId = request.getParameter("team_id");
			String DepartmentGoal = request.getParameter("department_goal");
			String GroupGoal = request.getParameter("group_goal");
			GoalId = Integer.parseInt(request.getParameter("goal_id"));
			String AnnualGoal = request.getParameter("annual_goal");
			String SituationChallenge = request.getParameter("situation_challenge");
			String Result = request.getParameter("result");
			String ResultComment = request.getParameter("result_comment");
			String ResultReviewer = request.getParameter("result_reviewer");
			String ResultCommentReviewer = request.getParameter("result_comment_reviewer");

			//セッターメソッドを呼び出す
			teamGoal.setTeamId(TeamId);
			teamGoal.setDepartmentGoal(DepartmentGoal);
			teamGoal.setGroupGoal(GroupGoal);
			goal.setGoalId(GoalId);
			goal.setAnnualGoal(AnnualGoal);
			goal.setSituationChallenge(SituationChallenge);
			goal.setResult(Result);
			goal.setResultComment(ResultComment);
			goal.setResultReviewer(ResultReviewer);
			goal.setResultCommentReviewer(ResultCommentReviewer);
			
			//updateメソッドを呼び出す
			teamGoalDAO.update(teamGoal);
			goalDAO.update(goal);

			for (int i = 1; i <= 4; i++) {
				//QuarterGoalオブジェクトの生成
				QuarterGoal quarterGoal = new QuarterGoal();

				//getParameterメソッドを呼び出す
				int QuarterGoalId = Integer.parseInt(request.getParameter("quarter_goal_id" + (i)));
				String SmallGoal = request.getParameter("small_goal" + (i));
				String JudgeMaterial = request.getParameter("judge_material" + (i));
				String AchieveRate = request.getParameter("achieve_rate" + (i));
				String Report = request.getParameter("report" + (i));
				String AchieveRateReviewer = request.getParameter("achieve_rate_reviewer" + (i));
				String Evaluation = request.getParameter("evaluation" + (i));
				int QuarterlyFlag = Integer.parseInt(request.getParameter("quarterly_flag" + (i)));

				//セッターメソッドを使って格納する
				quarterGoal.setQuarterGoalId(QuarterGoalId);
				quarterGoal.setSmallGoal(SmallGoal);
				quarterGoal.setJudgeMaterial(JudgeMaterial);
				quarterGoal.setAchieveRate(AchieveRate);
				quarterGoal.setReport(Report);
				quarterGoal.setAchieveRateReviewer(AchieveRateReviewer);
				quarterGoal.setEvaluation(Evaluation);
				quarterGoal.setQuarterlyFlag(QuarterlyFlag);

				//quarterGoalを引数にupdateメソッドを呼び出す
				quarterGoalDAO.update(quarterGoal);
			}

		} catch (Exception e) {
			error = "エラーです！";
		} finally {
			if (error != "" ) {
				request.getRequestDispatcher("/view/error.jsp").forward(request, response);
			}
			//フォワードする
			request.getRequestDispatcher("/goalConfirm").forward(request, response);
		}
	}
}
