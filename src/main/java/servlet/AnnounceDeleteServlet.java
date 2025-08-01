/**
 * お知らせを削除するサーブレット
 * 
 * 作成者 : 大北直弥
 * 
 * 作成日 : 2025/07/25
 * 更新日 : 2025/07/30
 */
package servlet;

import java.io.IOException;

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

		// 変数宣言
		String error = "";
		String cmd = "";

		// オブジェクト生成
		AnnounceDAO announceDAO = new AnnounceDAO();
		
		try {
			// URLからannounceIdを取得
			int announceId = Integer.parseInt(request.getParameter("announceId"));
			
			// メソッドを呼び出してSQL文実行
			announceDAO.delete(announceId);
			
		} catch (Exception e) {
			cmd = "";
			error = "予期せぬエラーが発生しました。" + e;
		} finally {
			if (error != "") {
				request.setAttribute("cmd", cmd);
				request.setAttribute("error", error);
				request.getRequestDispatcher("#").forward(request, response);
			}
			request.getRequestDispatcher("/announce").forward(request, response);
		}
	}

}
