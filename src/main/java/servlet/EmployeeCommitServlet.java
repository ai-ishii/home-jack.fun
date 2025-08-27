/*
 * 社員紹介情報の更新を確定させるサーブレット
 * 
 * 作成者：大北直弥
 * 
 * 作成日：8/22
 * 更新日：8/26
 */
package servlet;

import java.io.IOException;

import dao.EmployeeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/employeeCommit")
public class EmployeeCommitServlet extends HttpServlet {

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

		// エラー用コマンド
		String error = "";
		// エラー文格納用
		String message = "";
		// 画面遷移用コマンド
		String cmd = "";
		// 遷移先のパス
		String path = "";

		int userId = 0;

		EmployeeDAO employeeDAO = new EmployeeDAO();

		String strUserId = request.getParameter("user_id");
		//		String confirm = request.getParameter("confirm");
		//		String complete = request.getParameter("complete");
		String submit = request.getParameter("confirm");

		try {

			// フォームから受け取ったパラメータをint型に変換する
			userId = Integer.parseInt(strUserId);

			if (submit.equals("完了")) {
				// 仮テーブルに保存していたデータを本テーブルに移動させる処理
				employeeDAO.update(userId);
			}

			// 仮テーブルに保存されていたデータを削除する処理
			employeeDAO.delete(userId);

		} catch (IllegalStateException e) {
			message = "システムの一時的な問題により、社員紹介情報の更新ができませんでした。";
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
				request.setAttribute("cmd", cmd);

				if (submit.equals("完了")) {
					// 社員紹介一覧画面に遷移する
					path = "/employee";
				}

				if (submit.equals("BACK")) {
					request.setAttribute("userId", userId);
					path = "/employeeDetail?work=update";
				}
			}

			request.getRequestDispatcher(path).forward(request, response);

		}
	}
}
