/**
 * お知らせを編集するサーブレット
 * 
 * 作成者 : 大北直弥
 * 
 * 作成日 : 2025/07/14
 * 更新日 : 2025/08/19
 */
package servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;

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

		// 変数宣言
		String error = "";
		String cmd = "";

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
			String updateDateBefore = request.getParameter("update_date");

			// メソッドからSQL実行
			announce = announceDAO.selectByAnnounceId(announceId);

			if (announce.getAnnounceId() == 0) {
				error = "対象のお知らせが存在しません。更新してもう一度お試しください。";
				//お知らせ一覧画面へ遷移
				cmd = "announce";
				return;
			}
			
			//データベース上の更新日時を取得
			SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");
			String updateDateAfter = format.format(announce.getUpdateDate());
			
			//遷移前の更新日時とデータベース上の更新日時を比較
			//違う場合
			if (!updateDateBefore.equals(updateDateAfter)) {
				error = "このデータはすでに変更されています。更新してもう一度お試しください。";
				cmd = "announce";
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
			error = "DB接続エラーのため、お知らせの更新はできませんでした。";
			//ログイン画面へ遷移
			cmd = "logout";

		} catch (Exception e) {
			error = "予期せぬエラーが発生しました。" + e;
			cmd = "logout";

		} finally {
			if (error != "") {
				request.setAttribute("cmd", cmd);
				request.setAttribute("error", error);
				request.getRequestDispatcher("/view/error.jsp").forward(request, response);
			}
			request.getRequestDispatcher("/announce").forward(request, response);
		}
	}

}
