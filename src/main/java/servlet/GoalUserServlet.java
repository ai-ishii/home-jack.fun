/**
 * 個人目標詳細機能
 * 
 * 作成者：月向亮太
 * 
 * 作成日：7月18日
 * 
 * 最終更新日：8月1日
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

@WebServlet("/goalUser")
public class GoalUserServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

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
			
			//getParameterメソッドを呼び出す
			strUserId = request.getParameter("user_id");
			cmd = request.getParameter("cmd");
			

			if (cmd == null) {
				cmd = ""; //※ここは後で絶対に変える文章なので覚えておいてください
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
			error = "エラーです。";
		} finally {
			if (!error.isEmpty()) {
					request.getRequestDispatcher("/view/error.jsp").forward(request, response);
				}
				//リクエストスコープを使ってフォワード
				request.setAttribute("teamGoal", teamGoal);
				request.setAttribute("goal", goal);
				request.setAttribute("quarter_goal_list", quarterGoalList);
			request.getRequestDispatcher("/view/goalUser.jsp").forward(request, response);
		}
	}
}
