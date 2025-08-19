/**
 * 個人目標一覧機能（マネージャー）
 * 
 * 作成者：月向亮太
 * 
 * 作成日：7月8日
 * 
 * 最終更新日：8月7日
 * 
 */
package servlet;

import java.io.IOException;
import java.util.ArrayList;

import bean.GoalDepartment;
import bean.User;
import dao.GoalDepartmentDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/goal")
public class GoalServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 変数宣言
		String error = "";
		String cmd = "";
		
		String groupCode = "";
		String groupName = "";
		// 一旦Stringで取得して後でint型に変換する
		String strDepartmentId = "";
		String strGroupId = "";
		int departmentId = 0;
		int groupId = 0;

		//DAO宣言
		UserDAO userDAO = new UserDAO();
		GoalDepartmentDAO goalDepartmentDAO = new GoalDepartmentDAO();
		
		//配列宣言
		ArrayList<User> userListByGroup = new ArrayList<User>();
		ArrayList<GoalDepartment> goalDepartmentList = new ArrayList<GoalDepartment>();
		ArrayList<String> userNameList = new ArrayList<String>();
		ArrayList<Integer> userIdList = new ArrayList<Integer>();
		ArrayList<String> groupCodeList = new ArrayList<String>();
		
		// オブジェクト生成
		GoalDepartment goalDepartment = new GoalDepartment();

		try {
			// userDAO.selectAll();
			
			groupCode = request.getParameter("groupCode");
			strDepartmentId = request.getParameter("d");
			strGroupId = request.getParameter("g");
			
			// 初期値を入れておいて、最初のアクセス時に表示するグループを確定しておく
			if (groupCode == null) {
				groupCode = "BS1001";
			}
			
			// パラメータを取得してnullだったら初期値を入れ、int型に変換
			if(strDepartmentId == null && strGroupId == null) {
				strDepartmentId = "1";
				strGroupId = "2";
			}
			departmentId = Integer.parseInt(strDepartmentId);
			groupId = Integer.parseInt(strGroupId);
			
			// グループコードをもとに所属名を取得
			goalDepartment = goalDepartmentDAO.selectByGroupCode(groupCode);
			groupName = goalDepartment.getName();
			
			// 部とグループのIDをもとに所属社員の名前とユーザーIDを取得して可変長配列に代入
			userListByGroup = userDAO.selectByDepartmentGroup(departmentId, groupId);
			for (int i = 0; i < userListByGroup.size(); i++) {
				userNameList.add(userListByGroup.get(i).getName());
				userIdList.add(userListByGroup.get(i).getUserId());
			}
			
			// グループコードをすべて取得して可変長配列に代入
			goalDepartmentList = goalDepartmentDAO.selectAll();
			for (int i = 0; i < goalDepartmentList.size(); i++) {
				groupCodeList.add(goalDepartmentList.get(i).getGroupCode());
			}
			
		} catch (Exception e) {
			error = "エラーです。";
		} finally {
			if (!error.isEmpty()) {
				request.setAttribute("cmd", cmd);
				request.setAttribute("error", error);
				request.getRequestDispatcher("/view/error.jsp").forward(request, response);
			}
			//リクエストスコープを使ってフォワード
			request.setAttribute("groupName", groupName);
			request.setAttribute("groupCodeList", groupCodeList);
			request.setAttribute("userNameList", userNameList);
			request.setAttribute("userIdList", userIdList);
			request.getRequestDispatcher("/view/goal.jsp").forward(request, response);
		}
	}
}
