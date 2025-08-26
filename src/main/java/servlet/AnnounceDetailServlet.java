/**
 * お知らせの詳細情報を表示するサーブレット
 * 
 * 作成者 : 大北直弥
 * 
 * 作成日 : 2025/07/14
 * 更新日 : 2025/08/25
 */
package servlet;

import java.io.IOException;
import java.util.ArrayList;

import bean.Announce;
import dao.AnnounceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/announceDetail")
public class AnnounceDetailServlet extends HttpServlet {

	public void doGet(HttpServletRequest request,
			HttpServletResponse response)
			throws ServletException, IOException {

		// エラー用コマンド
		String error = "";
		// エラー文格納用
		String message = "";
		// 画面遷移用コマンド
		String cmd = "";
		// 遷移先のパス
		String path = "";

		// オブジェクト生成
		Announce announce = new Announce();
		AnnounceDAO announceDAO = new AnnounceDAO();
		ArrayList<Announce> announceList = new ArrayList<Announce>();

		// jspファイルからパラメータ取得
		int announceId = Integer.parseInt(request.getParameter("announceId"));
		cmd = request.getParameter("cmd");

		try {
			// メソッドからSQL実行
			announce = announceDAO.selectByAnnounceId(announceId);

			if (announce.getAnnounceId() == 0) {
				message = "このお知らせは、すでに削除されています。";
				//お知らせ一覧画面へ遷移
				path = "/announce";
				return;
			}
			
			if (cmd.equals("detail")) {
				// メソッドからSQL実行
				announceList = announceDAO.selectAll();
			}

		} catch (IllegalStateException e) {
			message = "システムの一時的な問題により、お知らせの読み込みができませんでした。";
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
			
			//削除エラーの有無判定
			if (!("").equals(path)) {
				request.setAttribute("message", message);
			} else {
				// お知らせ詳細画面に遷移する条件式
				if (cmd.equals("detail")) {
					request.setAttribute("announce", announce);
					request.setAttribute("announceList", announceList);
					path = "/view/announceDetail.jsp";
				}
				// お知らせ更新画面に遷移する条件式
				if (cmd.equals("update")) {
					request.setAttribute("announce", announce);
					path = "/view/announceUpdate.jsp";
				}
			}

			request.getRequestDispatcher(path).forward(request, response);
		}
	}
}
