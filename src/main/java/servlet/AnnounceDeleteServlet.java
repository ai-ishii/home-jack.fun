/**
 * お知らせを削除するサーブレット
 * 
 * 作成者 : 大北直弥
 * 
 * 作成日 : 2025/07/25
 * 更新日 : 2025/08/25
 */
package servlet;

import java.io.IOException;

import bean.Announce;
import dao.AnnounceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/announceDelete")
public class AnnounceDeleteServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// エラー用コマンド
		String error = "";
		// エラー文格納用
		String message = "";
		// 遷移先のパス
		String path = "/announce";

		// オブジェクト生成
		AnnounceDAO announceDAO = new AnnounceDAO();
		Announce announce = new Announce();

		try {
			// URLからannounceIdを取得
			int announceId = Integer.parseInt(request.getParameter("announceId"));

			announce = announceDAO.selectByAnnounceId(announceId);

			if (announce.getAnnounceId() == 0) {
				message = "このお知らせは、すでに削除されています。";
				//お知らせ一覧画面へ遷移
				path = "/announce";
				return;
			}

			// メソッドを呼び出してSQL文実行
			announceDAO.delete(announceId);

		} catch (IllegalStateException e) {
			message = "システムの一時的な問題により、お知らせ情報の削除ができませんでした。";
			//ログイン画面へ遷移
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
				request.setAttribute("message", message);
			}
			
			request.getRequestDispatcher(path).forward(request, response);
		}
	}

}
