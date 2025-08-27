/**
 * 社員紹介検索機能
 * 
 * 作成者：月向亮太
 * 
 * 作成日 2025/08/13
 * 
 * 最終更新日：2025/08/22
 */

package servlet;

import java.io.IOException;
import java.util.ArrayList;

import bean.User;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/employeeSearch")
public class EmployeeSearchServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// エラー用コマンド
		String error = "";
		// エラー文格納用
		String message = "";
		// 画面遷移用コマンド
		String cmd = "";
		// 遷移先のパス
		String path = "/view/employee.jsp";
		//検索用の変数
		String keyword = "";

		//オブジェクト生成
		UserDAO userDAO = new UserDAO();
		ArrayList<User> userList = new ArrayList<User>();

		try {
			keyword = request.getParameter("keyword");

			if (keyword == null) {
				keyword = "";
			}

			userList = userDAO.searchEmployee(keyword);

			//jackworksRequest.jspからcmd=requestを受け取る
			cmd = request.getParameter("cmd");

			if (cmd == null) {
				cmd = "";
			}

		} catch (IllegalStateException e) {
			message = "システムの一時的な問題により、検索結果の読み込みができませんでした。";
			error = "logout";
		} catch (Exception e) {
			message = "予期せぬエラーが発生しました。" + e;
			error = "logout";
		} finally {

			if (!("").equals(error)) {
				// 例外が発生する場合エラー文をリクエストスコープに"error"という名前で格納する
				request.setAttribute("error", message);
				// 例外が発生する場合エラー種類をリクエストスコープに"cmdという名前で格納する
				request.setAttribute("cmd", error);
				// error.jspにフォワード
				path = "/view/error.jsp";
			}

			if (("").equals(error)) {
				// cmdをリクエストスコープに"cmd"という名前で格納する
				request.setAttribute("cmd", cmd);
				request.setAttribute("userList", userList);
				request.setAttribute("keyword", keyword);
			}

			request.getRequestDispatcher(path).forward(request, response);

		}
	}

}
