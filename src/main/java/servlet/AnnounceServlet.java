/**
 * お知らせを一覧表示するサーブレット
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
import bean.CategoryMap;
import dao.AnnounceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/announce")
public class AnnounceServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 共通処理メソッドの呼び出し
		commonProcess(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 共通処理メソッドの呼び出し
		commonProcess(request, response);
	}

	private void commonProcess(HttpServletRequest request,
			HttpServletResponse response)
			throws ServletException, IOException {

		// エラー用コマンド
		String error = "";
		// エラー文格納用
		String message = "";
		// 遷移先のパス
		String path = "/view/announce.jsp";

		// オブジェクト生成
		AnnounceDAO announceDAO = new AnnounceDAO();
		ArrayList<Announce> announceList = new ArrayList<Announce>();
		ArrayList<CategoryMap> categoryList = new ArrayList<CategoryMap>();

		try {
			//エラー文を受け取る
			message = (String) request.getAttribute("message");

			// メソッドを呼び出してSQL文実行
			announceList = announceDAO.selectAll();
			categoryList = announceDAO.selectCategoryAll();

		} catch (IllegalStateException e) {
			message = "システムの一時的な問題により、お知らせの読み込みができませんでした。";
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
				request.setAttribute("announceList", announceList);
				request.setAttribute("categoryList", categoryList);
				request.setAttribute("message", message);
			}
			
			request.getRequestDispatcher(path).forward(request, response);
		}
	}

}
