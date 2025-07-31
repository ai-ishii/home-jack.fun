package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/page")
public class pageServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//エラー文を格納する用の変数設定
		String error = null;
		//例外と遷移先情報を格納する用の変数設定
		String cmd = "";
		//遷移先のパスを設定
		String path = "/monthJackworks";

		
		
		try {
			//ページ番号を受け取る
			String pageNum =request.getParameter("page");
			
			
		} catch (IllegalStateException e) {
			error = "DB接続エラーのため、ページネーションは実行できませんでした。";
			cmd = "home";
		} catch (Exception e) {
			error = "予期せぬエラーが発生しました。" + e;
			cmd = "logout";
		} finally {
			if (error != null) {
				// 例外を発生する場合エラー文をリクエストスコープに"error"という名前で格納する
				request.setAttribute("error", error);
				// 例外を発生する場合エラー種類をリクエストスコープに"cmdという名前で格納する
				request.setAttribute("cmd", cmd);
				// error.jspにフォワード
				path = "/view/error.jsp";
			}
			//jackWorks.jspにフォワード
			request.getRequestDispatcher(path).forward(request, response);
		}
	}
}
