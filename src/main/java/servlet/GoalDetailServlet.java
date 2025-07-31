/**
 * 個人目標詳細機能
 * 
 * 作成者：月向亮太
 * 
 * 作成日：7月11日
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

@WebServlet("/goalDetail")
public class GoalDetailServlet extends HttpServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//変数の宣言
		String strUserId = "";
		String error = "";

		//オブジェクトの生成
		TeamGoal teamGoal = new TeamGoal();
		Goal goal = new Goal();

		//各DAOをインスタンス化し、メソッドを呼び出す
		TeamGoalDAO teamGoalDAO = new TeamGoalDAO();
		GoalDAO goalDAO = new GoalDAO();
		QuarterGoalDAO quarterGoalDAO = new QuarterGoalDAO();

		//配列宣言
		ArrayList<QuarterGoal> quarterGoalList = new ArrayList<QuarterGoal>();

		try {
			//セッション登録がまだなため、仮で登録してます
			strUserId = "4";

			//userIdをStringからintへキャスト
			int userId = Integer.parseInt(strUserId);

			//部目標を呼び出す
			teamGoal = teamGoalDAO.selectByUserId(userId);

			//目標を呼び出す
			goal = goalDAO.selectByUserId(userId);

			//四半期目標を呼び出す
			quarterGoalList = quarterGoalDAO.selectByUserId(userId);

		} catch (Exception e) {
			error = "エラーです！";
		} finally {
			if (error != "") {
				request.getRequestDispatcher("/view/error.jsp").forward(request, response);
			}
			//リクエストスコープを使ってフォワード
			request.setAttribute("teamGoal", teamGoal);
			request.setAttribute("goal", goal);
			request.setAttribute("quarter_goal_list", quarterGoalList);
			request.getRequestDispatcher("/view/goalUpdate.jsp").forward(request, response);
		}
	}
}
