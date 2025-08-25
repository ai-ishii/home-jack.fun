//<!-- 社員紹介 詳細機能（作：石井） -->
//<!-- 作成日：7/11　最終更新日：8/22 17:00 -->

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

@WebServlet("/employeeDetail")
public class DetailEmployeeServlet extends HttpServlet {
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		commonProcess(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		commonProcess(request, response);
	}

	private void commonProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		// 変数宣言
		String error = "";
		String cmd = "";
		String path = "";
		
		int userId = 0;
		String strUserId = "";
		
		try {
			// オブジェクト生成
			User user = new User();
			UserDAO userDAO = new UserDAO();
			Employee employee = new Employee();
			EmployeeDAO employeeDAO = new EmployeeDAO();
			ArrayList<User> userListBySameBelong = new ArrayList<User>();
			ArrayList<User> userListBySameJoinDate = new ArrayList<User>();
			
			// JSPから情報を取得
			String work = request.getParameter("work");
			
			// URLからパラメータを取得
			strUserId = request.getParameter("user_id");
			
			// パラメータが存在した場合、int型に変換する
			if (strUserId != null) {
				userId = Integer.parseInt(strUserId);
			} 
			
			// パラメータをもとに社員情報を取得する
			user = userDAO.selectByUserId(userId);
			employee = employeeDAO.selectByUserId(userId);
			
			// リクエストスコープに保存、画面遷移
			request.setAttribute("user", user);
			request.setAttribute("employee", employee);

			
			if (work.equals("detail")) {
				// 選択された社員の部・グループを取得し、メソッド実行
				int department = user.getDepartmentId();
				int group = user.getGroupId();
				userListBySameBelong = userDAO.selectByDepartmentGroup(department, group);
				
				// 選択された社員の入社年月を取得し、メソッド実行
				Timestamp joiningDate = user.getJoiningDate();
				userListBySameJoinDate = userDAO.selectByJoiningDate(joiningDate);
				
				request.setAttribute("UserListBySameBelong", userListBySameBelong);
				request.setAttribute("UserListBySameJoinDate", userListBySameJoinDate);
				
				// 遷移先の指定
				path = "/view/detailEmployee.jsp";
			}
			
			if (work.equals("update")) {
				
				// 遷移先の指定
				path = "/view/employeeUpdate.jsp";
			}
			
			// 取得してきた社員情報をjspに送るためセットする
			request.setAttribute("User", user);
			request.setAttribute("Employee", employee);
			
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
				request.getRequestDispatcher(path).forward(request, response);
			}
		}
		
	}

}