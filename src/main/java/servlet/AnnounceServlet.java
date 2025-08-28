/**
 * お知らせを一覧表示するサーブレット
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

		// エラー用フラグ
		boolean error = false;
		// 画面遷移用コマンド
		String cmd = "";
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
			error = true;
			cmd = "logout";
			message = "システムの一時的な問題により、お知らせの読み込みができませんでした。";
			
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
			
			if (!error) {
				request.setAttribute("announceList", announceList);
				request.setAttribute("categoryList", categoryList);
			}
			// エラー文を格納する
			request.setAttribute("message", message);
			
			request.getRequestDispatcher(path).forward(request, response);
		}
	}

}
