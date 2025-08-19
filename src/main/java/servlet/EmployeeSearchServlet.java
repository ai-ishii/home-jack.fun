/**
 * 社員紹介検索機能
 * 
 * 作成者：月向亮太
 * 
 * 作成日 2025/08/13
 * 
 * 最終更新日：2025/08/19
 */

package servlet;

import java.io.IOException;
import java.util.ArrayList;

import bean.User;
import dao.EmployeeDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/employeeSearch")
public class EmployeeSearchServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// エラー文を格納用
		String error = "";
		// 例外判定用
		String cmd = "";
		//検索用の変数
		String keyword = "";

		//オブジェクト生成
		UserDAO userDAO = new UserDAO();
		EmployeeDAO employeeDAO = new EmployeeDAO();
		ArrayList<User> userList = new ArrayList<User>();

		try {
			keyword = request.getParameter("keyword");
			if (keyword == null) {
				keyword = "";
			}

			userList = userDAO.searchEmployee(keyword);
			
			// 社員写真を格納する配列宣言
			String[] photos = new String[userList.size()];
			for (int i = 0; i < userList.size(); i++) {
				photos[i] = employeeDAO.selectPhotoByUserId(userList.get(i).getUserId());
			}
			
			
			// 取得してきたユーザー情報をjspに送るためセットする
			request.setAttribute("photos", photos);

			//jackworksRequest.jspからcmd=requestを受け取る
			cmd = request.getParameter("cmd");

			if (cmd == null) {
				cmd = "";
			}

		} catch (IllegalStateException e) {
			error = "DB接続エラーの為、JackWorks検索結果は表示できませんでした。";
			cmd = "";
		} catch (Exception e) {
			error = "予期せぬエラーが発生しました。" + e;
			cmd = "";
		} finally {
			if (error != "") {
				request.setAttribute("cmd", cmd);
				request.setAttribute("error", error);
				request.getRequestDispatcher("/view/error.jsp").forward(request, response);
			}
			// cmdをリクエストスコープに"cmd"という名前で格納する
			request.setAttribute("cmd", cmd);
			request.setAttribute("userList", userList);
			request.setAttribute("keyword", keyword);

			// pathにフォワード
			request.getRequestDispatcher("/view/employee.jsp").forward(request, response);
		}
	}

}
