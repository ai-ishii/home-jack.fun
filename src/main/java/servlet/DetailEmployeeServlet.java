//<!-- 社員紹介 詳細機能（作：石井） -->
//<!-- 作成日：7/11　最終更新日：8/1 11:58 -->

package servlet;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;

import bean.Employee;
import bean.User;
import dao.EmployeeDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/detailEmployee")
public class DetailEmployeeServlet extends HttpServlet {
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		
		// 変数宣言
		String error = "";
		String cmd = "";
		
		try {
		// オブジェクト生成
		UserDAO userDAO = new UserDAO();
		EmployeeDAO employeeDAO = new EmployeeDAO();
		Employee employee = new Employee();
		User user = new User();
		ArrayList<User> userListBySameBelong = new ArrayList<User>();
		ArrayList<User> userListBySameJoinDate = new ArrayList<User>();
		
		// JSPから情報を取得
		int userId = Integer.parseInt(request.getParameter("userId"));
		
		// メソッドからSQL実行
		employee = employeeDAO.selectByUserId(userId);
		user = userDAO.selectByUserId(userId);
		
		// 選択された社員の部・グループを取得し、メソッド実行
		int department = user.getDepartmentId();
		int group = user.getGroupId();
		userListBySameBelong = userDAO.selectByDepartmentGroup(department, group);
		
		// 選択された社員の入社年月を取得し、メソッド実行
		Timestamp joiningDate = user.getJoiningDate();
		userListBySameJoinDate = userDAO.selectByJoiningDate(joiningDate);
		
		// 取得してきた社員情報をjspに送るためセットする
		request.setAttribute("Employee", employee);
		request.setAttribute("User", user);
		request.setAttribute("userId", userId);
		request.setAttribute("UserListBySameBelong", userListBySameBelong);
		request.setAttribute("UserListBySameJoinDate", userListBySameJoinDate);
			
		} catch(IllegalStateException e) {
			cmd = "";
			error = "DB接続エラーのため、社員詳細は表示できませんでした。";
		} catch (Exception e) {
			cmd = "";
			error = "予期せぬエラーが発生しました。" + e;
		} finally {
			// エラーが空じゃなければ（エラーがあれば）
			if (error != "") {
				request.setAttribute("cmd", cmd);
				request.setAttribute("error", error);
				request.getRequestDispatcher("/view/error.jsp").forward(request, response);
			} else {	// エラーがなければ
				// 社員詳細画面に遷移する
				request.getRequestDispatcher("/view/detailEmployee.jsp").forward(request, response);
			}
		}
		
	}

}