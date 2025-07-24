package servlet;

import java.io.IOException;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/userSearch")
public class UserSearchServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// エラー文を格納用
		String error = "";
		// 例外判定用
		String cmd = "";
		// 遷移先のパス
		String path = "/view/userList.jsp";

		try {
			// パラメータの取得
			

			// DAOオブジェクトの宣言
			UserDAO userDAO = new UserDAO();

			// メソッドを呼び出し
			
			
			

			// リクエストスコープに登録
			//request.setAttribute("user", user);

		} catch (IllegalStateException e) {
			error = "DB接続エラーのため、検索結果は表示できませんでした。";
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
