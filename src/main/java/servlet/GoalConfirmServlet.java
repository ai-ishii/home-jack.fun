/**
 * 個人目標確認機能
 * 
 * 作成者：月向亮太
 * 
 * 作成日：7月8日
 * 
 * 最終更新日：8月12日
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
			//getParameterメソッドを使い、取得した値を代入する
			cmd = request.getParameter("cmd");
			userId = (Integer) session.getAttribute("user_id");

			//※ここは後で絶対に変える文章なので覚えておいてください
			if (cmd == null) {
				cmd = ""; 
			}
			
			// 目標を呼び出す
			goal = goalDAO.selectByUserId(userId);
			
			// メソッドの引数となる変数をを格納する
			String groupCode = goal.getGroupCode();
			int goalId = goal.getGoalId();	
			
			// 部目標を呼び出す
			goalDepartment = goalDepartmentDAO.selectByGroupCode(groupCode);

			// 四半期目標を呼び出す(ここから テーブルにuserIdがないため修正要
			goalQuarterList = goalQuarterDAO.selectByGoalId(goalId);

		} catch (Exception e) {
			error = "エラーです！";

		} finally {
			if (!error.isEmpty()) {
				request.getRequestDispatcher("/view/error.jsp").forward(request, response);
			}
			//リクエストスコープを使ってフォワード
			session.setAttribute("user_id",userId);
			request.setAttribute("goal_department", goalDepartment);
			request.setAttribute("goal", goal);
			request.setAttribute("goal_quarter_list", goalQuarterList);
			request.getRequestDispatcher("/view/goalConfirm.jsp").forward(request, response);
		}
	}
}
