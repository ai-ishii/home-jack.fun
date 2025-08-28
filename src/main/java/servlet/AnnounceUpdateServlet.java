/**
 * お知らせを編集するサーブレット
 * 
 * 作成者 : 大北直弥
 * 
 * 作成日 : 2025/07/14
 * 更新日 : 2025/08/26
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

@WebServlet("/announceUpdate")
public class AnnounceUpdateServlet extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response)
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
		Announce announce = new Announce();
		AnnounceDAO announceDAO = new AnnounceDAO();

		try {

			// jspファイルからパラメータ取得
			int announceId = Integer.parseInt(request.getParameter("announce_id"));
			String title = request.getParameter("title");
			String text = request.getParameter("text");
			int announceFlag = Integer.parseInt(request.getParameter("announce_flag"));
			int categoryId = Integer.parseInt(request.getParameter("category_id"));
			//遷移前の更新日時
			String updateDate = request.getParameter("update_date");
			Timestamp updateDateBefore = Timestamp.valueOf(updateDate);

			// メソッドからSQL実行
			announce = announceDAO.selectByAnnounceId(announceId);
			
			//データベース上の更新日時
			Timestamp updateDateNow = announce.getUpdateDate();

			if (announce.getAnnounceId() == 0) {
				error = true;
				cmd = "announce";
				message = "対象のお知らせが存在しません。";
				//お知らせ一覧画面へ遷移
				return;
			}
			
			//遷移前の更新日時とデータベース上の更新日時を比較
			//違う場合
			if (!updateDateBefore.equals(updateDateNow)) {
				error = true;
				cmd = "announce";
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

		} catch (NumberFormatException e) {
			error = true;
			cmd = "announce";
			message = "不正な操作を検知しました。";
		} catch (IllegalStateException e) {
			error = true;
			//ログイン画面へ遷移
			cmd = "logout";
			message = "システムの一時的な問題により、お知らせ情報の更新ができませんでした。";

		} catch (Exception e) {
			error = true;
			cmd= "logout";
			message = "予期せぬエラーが発生しました。" + e;

		} finally {
			
			if (error) {
				if (!"announce".equals(cmd)) {
					// error.jspにフォワード先を指定
					path = "/view/error.jsp";
				}
				
				// 例外が発生する場合エラー種類をリクエストスコープに"cmdという名前で格納する
				request.setAttribute("cmd", cmd);
				
			}
			request.setAttribute("message", message);
			
			request.getRequestDispatcher(path).forward(request, response);
		}
	}

}
