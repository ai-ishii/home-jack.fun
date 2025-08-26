/**
 * お知らせを編集するサーブレット
 * 
 * 作成者 : 大北直弥
 * 
 * 作成日 : 2025/07/14
 * 更新日 : 2025/08/25
 */
package servlet;

import java.io.IOException;
import java.sql.Timestamp;

import bean.Announce;
import dao.AnnounceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.MyFormat;

@WebServlet("/announceUpdate")
public class AnnounceUpdateServlet extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// エラー用コマンド
		String error = "";
		// エラー文格納用
		String message = "";
		// 遷移先のパス
		String path = "/announce";

		// オブジェクト生成
		Announce announce = new Announce();
		AnnounceDAO announceDAO = new AnnounceDAO();
		MyFormat myFormat = new MyFormat();

		try {

			// jspファイルからパラメータ取得
			int announceId = Integer.parseInt(request.getParameter("announce_id"));
			String title = request.getParameter("title");
			String text = request.getParameter("text");
			int announceFlag = Integer.parseInt(request.getParameter("announce_flag"));
			int categoryId = Integer.parseInt(request.getParameter("category_id"));
			String updateDateBefore = request.getParameter("update_date");

			// メソッドからSQL実行
			announce = announceDAO.selectByAnnounceId(announceId);
			
			Timestamp timestamp = announce.getUpdateDate();
			String updateDate = myFormat.dateTimeFormat(timestamp);

			if (announce.getAnnounceId() == 0) {
				message = "対象のお知らせが存在しません。";
				//お知らせ一覧画面へ遷移
				return;
			}
			
			//遷移前の更新日時とデータベース上の更新日時を比較
			//違う場合
			if (!updateDateBefore.equals(updateDate)) {
				message = "このデータはすでに変更されています。";
				return;
			}

			// パラメータをAnnounceに格納する
			announce.setAnnounceId(announceId);
			announce.setTitle(title);
			announce.setText(text);
			announce.setAnnounceFlag(announceFlag);
			announce.setAnnounceCategoryId(categoryId);

			// メソッドを呼び出してSQL文実行
			announceDAO.update(announce);

		} catch (IllegalStateException e) {
			message = "システムの一時的な問題により、お知らせ情報の更新ができませんでした。";
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
