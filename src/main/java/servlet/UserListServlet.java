/*
 * プログラム名：Home-Jack.ver.2.0
 * 作成者：占部虎司郎
 * 作成日：2025/7/4
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

@WebServlet("/userList")
public class UserListServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		// エラー文を格納用
		String error = "";
		// 例外判定用
		String cmd = "";
		// 遷移先のパス
		String path = "/view/userList.jsp";
		
		try {
			//UserDAOをインスタンス化し、メソッドを呼び出す。
			UserDAO userDAO = new UserDAO();
			ArrayList<User> userList = userDAO.selectAll();
			
			//取得したリストをuser_Listという名前でリクエストスコープに登録
			request.setAttribute("user_List", userList);
			
		} catch (IllegalStateException e) {
			error = "DB接続エラーのため、個人情報一覧は表示出来ませんでした。";
			cmd = "logout";
		} catch (Exception e) {
			error = "予期せぬエラーが発生しました。" + e;
			cmd = "logout";
		} finally {
			if (error != "") {
				// 例外を発生する場合エラー文をリクエストスコープに"error"という名前で格納する
				request.setAttribute("error", error);
				// 例外を発生する場合エラー種類をリクエストスコープに"cmdという名前で格納する
				request.setAttribute("cmd", cmd);
				// error.jspにフォワード
				path = "/view/error.jsp";
			}
			// pathにフォワード
			request.getRequestDispatcher(path).forward(request, response);
		}
		
	}
}
