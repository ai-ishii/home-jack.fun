/**
 * 社員情報登録機能
 * 
 * 作成者：月向亮太
 * 
 * 作成日：8月18日
 * 
 * 最終更新日：8月27日
 * 
 */
package servlet;

import java.io.IOException;

import bean.User;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/userRegister")
public class UserRegisterServlet extends HttpServlet {

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

		// エラー用フラグ
		boolean error = false;
		// 画面遷移用コマンド
		String cmd = "";
		// エラー文格納用
		String message = "";
		// 遷移先のパス
		String path = "/home";

		//オブジェクトの生成
		UserDAO userDAO = new UserDAO();
		HttpSession session = request.getSession();

		try {
			//セッションからユーザー情報を取得
			User user = (User) session.getAttribute("user");

			//ユーザー情報がなければ
			if (user == null) {
				path = "/index.jsp";
			}

			//ユーザー情報の更新処理
			userDAO.updateProfile(user);

			//セッション登録
			session.setAttribute("profile", true);
			session.setAttribute("user", user);

			/*
			session.setAttribute("user_id", user.getUserId());
			session.setAttribute("user_name", user.getName());
			*/

		} catch (IllegalStateException e) {
			error = true;
			cmd = "logout";
			message = "システムの一時的な問題により、個人情報の登録ができませんでした。";
		} catch (Exception e) {
			error = true;
			cmd = "logout";
			message = "予期せぬエラーが発生しました。" + e;
		} finally {

			if (error) {
				// 例外が発生する場合エラー文をリクエストスコープに"error"という名前で格納する
				request.setAttribute("message", message);
				// error.jspにフォワード
				path = "/view/error.jsp";
			}

			request.setAttribute("cmd", cmd);
			// pathにフォワード
			request.getRequestDispatcher(path).forward(request, response);
		}
	}
}
