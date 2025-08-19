/**
 * 個人目標確認機能
 * 
 * 作成者：月向亮太
 * 
 * 作成日：7月8日
 * 
 * 最終更新日：8月18日
 * 
 */
package servlet;

import java.io.IOException;
import java.util.ArrayList;

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
import jakarta.servlet.http.HttpSession;


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
		String cmd = "";
		Integer userId = 0;

		//オブジェクト宣言
		Goal goal = new Goal();
		GoalDepartment goalDepartment = new GoalDepartment();

		//各DAOをインスタンス化し、メソッドを呼び出す
		GoalDAO goalDAO = new GoalDAO();
		GoalQuarterDAO goalQuarterDAO = new GoalQuarterDAO();
		GoalDepartmentDAO goalDepartmentDAO = new GoalDepartmentDAO();
		
		//配列宣言
		ArrayList<GoalQuarter> goalQuarterList = new ArrayList<GoalQuarter>();

		//セッションオブジェクトの生成
		HttpSession session = request.getSession();


		try {
			// getParameterメソッドを使い、取得した値を代入する
			cmd = (String) request.getParameter("cmd");
			
			if (cmd.equals("manager")) {
				userId = Integer.parseInt(request.getParameter("user_id"));
			}
			
			if (cmd.equals("confirm") && cmd.equals("update")) {
				userId = (Integer) session.getAttribute("user_id");
			}
			
			// 目標を呼び出す
			goal = goalDAO.selectByUserId(userId);
			
			// メソッドの引数となる変数をを格納する
			String groupCode = goal.getGroupCode();
			int goalId = goal.getGoalId();	
			
			// 部目標を呼び出す
			goalDepartment = goalDepartmentDAO.selectByGroupCode(groupCode);

			// 四半期目標を呼び出す
			goalQuarterList = goalQuarterDAO.selectByGoalId(goalId);

		} catch (Exception e) {
			error = "エラーです！";

		} finally {
			if (!error.isEmpty()) {
				request.getRequestDispatcher("/view/error.jsp").forward(request, response);
			}
			//リクエストスコープを使ってフォワード
			session.setAttribute("userId",userId);
			request.setAttribute("goalDepartment", goalDepartment);
			request.setAttribute("goal", goal);
			request.setAttribute("goalQuarterList", goalQuarterList);
			
			if (cmd.equals("update")) {
				request.getRequestDispatcher("/view/goalUpdate.jsp").forward(request, response);
			}
			
			if (cmd.equals("confirm") || cmd.equals("manager")) {
				request.getRequestDispatcher("/view/goalConfirm.jsp").forward(request, response);
			}
		}
	}
}
