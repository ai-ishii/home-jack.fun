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

@WebServlet("/goalConfirm")
public class GoalConfirmServlet extends HttpServlet {
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

		//変数の宣言
		String error = "";
		String strUserId = "";
		String cmd = "";

		//オブジェクト宣言
		Goal goal = new Goal();
		TeamGoal teamGoal = new TeamGoal();

		//各DAOをインスタンス化し、メソッドを呼び出す
		GoalDAO goalDAO = new GoalDAO();
		QuarterGoalDAO quarterGoalDAO = new QuarterGoalDAO();
		TeamGoalDAO teamGoalDAO = new TeamGoalDAO();
		
		//配列宣言
		ArrayList<QuarterGoal> quarterGoalList = new ArrayList<QuarterGoal>();

		try {
			//getParameterメソッドを使い、取得した値を代入する
			strUserId = request.getParameter("user_id");
			cmd = request.getParameter("cmd");

			//セッション登録がまだなため、仮で登録
			strUserId = "5";
			
			//※ここは後で絶対に変える文章なので覚えておいてください
			if (cmd == null) {
				cmd = ""; 
			}
			
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
			request.getRequestDispatcher("/view/goalConfirm.jsp").forward(request, response);
		}
	}
}
