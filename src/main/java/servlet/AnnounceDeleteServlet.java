/**
 * お知らせを削除するサーブレット
 * 
 * 作成者 : 大北直弥
 * 
 * 作成日 : 2025/07/25
 * 更新日 : 2025/08/27
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

		// エラー用フラグ
		boolean error = false;
		// 画面遷移用コマンド
		String cmd = "";
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
				message = "このお知らせは存在しないか、すでに削除されています。";
				return;
			}

			// メソッドを呼び出してSQL文実行
			announceDAO.delete(announceId);

		
		} catch (NumberFormatException e) {
			error = true;
			cmd = "logout";
			message = "不正な操作を検知しました。";
		} catch (IllegalStateException e) {
			error = true;
			cmd = "logout";
			message = "システムの一時的な問題により、お知らせ情報の削除ができませんでした。";
			
		} catch (Exception e) {
			error = true;
			cmd = "logout";
			message = "予期せぬエラーが発生しました。" + e;
			
		} finally {
			
			if (error) {
				// 画面遷移を制御するcmdを格納する
				request.setAttribute("cmd", cmd);
				// error.jspにフォワード先を指定
				path = "/view/error.jsp";
			}

			// エラー文を格納する
			request.setAttribute("message", message);
			
			request.getRequestDispatcher(path).forward(request, response);
		}
	}
}
