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
		String TeamId = "";
		String DepartmentGoal = "";
		String GroupGoal = "";
		String AnnualGoal = "";
		String SituationChallenge = "";
		String SmallGoal = "";
		String JudgeMaterial = "";
		String AchieveRate = "";
		String Report = "";
		String AchieveRateReviewer = "";
		String Evaluation = "";
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
			TeamId = request.getParameter("team_id");
			DepartmentGoal = request.getParameter("department_goal");
			GroupGoal = request.getParameter("group_goal");
			GoalId = Integer.parseInt(request.getParameter("goal_id"));
			AnnualGoal = request.getParameter("annual_goal");
			SituationChallenge = request.getParameter("situation_challenge");

			//セッターメソッドを呼び出す
			teamGoal.setTeamId(TeamId);
			teamGoal.setDepartmentGoal(DepartmentGoal);
			teamGoal.setGroupGoal(GroupGoal);
			goal.setGoalId(GoalId);
			goal.setAnnualGoal(AnnualGoal);
			goal.setSituationChallenge(SituationChallenge);

			//updateメソッドを呼び出す
			teamGoalDAO.update(teamGoal);
			goalDAO.update(goal);

			for (int i = 1; i <= 4; i++) {
				//QuarterGoalオブジェクトの生成
				QuarterGoal quarterGoal = new QuarterGoal();

				//getParameterメソッドを呼び出す
				int QuarterGoalId = Integer.parseInt(request.getParameter("quarter_goal_id" + (i)));
				SmallGoal = request.getParameter("small_goal" + (i));
				JudgeMaterial = request.getParameter("judge_material" + (i));
				AchieveRate = request.getParameter("achieve_rate" + (i));
				Report = request.getParameter("report" + (i));
				AchieveRateReviewer = request.getParameter("achieve_rate_reviewer" + (i));
				Evaluation = request.getParameter("evaluation" + (i));
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
