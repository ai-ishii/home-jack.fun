/**
 * お知らせの詳細情報を表示するサーブレット
 * 
 * 作成者 : 大北直弥
 * 
 * 作成日 : 2025/07/14
 * 更新日 : 2025/08/27
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

		// エラー用フラグ
		boolean error = false;
		// 画面遷移用コマンド
		String cmd = "";
		// エラー文格納用
		String message = "";
		// 遷移先のパス
		String path = "";

		// オブジェクト生成
		Announce announce = new Announce();
		AnnounceDAO announceDAO = new AnnounceDAO();
		ArrayList<Announce> announceList = new ArrayList<Announce>();

		try {
			// jspファイルからパラメータ取得
			int announceId = Integer.parseInt(request.getParameter("announceId"));
			cmd = request.getParameter("cmd");
			
			// メソッドからSQL実行
			announce = announceDAO.selectByAnnounceId(announceId);

			
			if (announce.getAnnounceId() == 0) {
				message = "このお知らせは、すでに削除されています。";
				//お知らせ一覧画面へ遷移先を指定
				path = "/announce";
				return;
			}
			
			if (("detail").equals(cmd)) {
				// メソッドからSQL実行
				announceList = announceDAO.selectAll();
				//お知らせ詳細画面へ遷移先を指定
				path = "/view/announceDetail.jsp";
				return;
			}
			
			if (("update").equals(cmd)) {
				//お知らせ更新画面へ遷移先を指定
				path = "/view/announceUpdate.jsp";
				return;
			}
			//それ以外の場合
			if (!error){
				error = true;
				//ログイン画面へ遷移先を指定
				cmd = "logout";
				message = "不正な操作を検知しました。";
			}
			

		} catch (NumberFormatException e) {
			error = true;
			cmd = "announce";
			message = "不正な操作を検知しました。";
		} catch (IllegalStateException e) {
			error = true;
			cmd = "logout";
			message = "システムの一時的な問題により、お知らせ情報の読み込みができませんでした。";
			
		} catch (Exception e) {
			error = true;
			cmd = "logout";
			message = "予期せぬエラーが発生しました。" + e;

		} finally {


			if (error) {
				
				// 例外が発生する場合エラー種類をリクエストスコープに"cmdという名前で格納する
				request.setAttribute("cmd", cmd);
				// error.jspにフォワード
				path = "/view/error.jsp";
			}
			
			if (!error) {
				// お知らせ詳細画面遷移の場合
				if (("detail").equals(cmd)) {
					//お知らせ情報を格納
					request.setAttribute("announceList", announceList);
				}
				
				request.setAttribute("announce", announce);
			}
			
			// エラー文を格納する
			request.setAttribute("message", message);
				
			request.getRequestDispatcher(path).forward(request, response);
		}
	}
}
