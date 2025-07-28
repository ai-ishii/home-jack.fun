/**
 * JackWorks削除機能
 * 
 * 作成者：青木美波
 * 
 * 作成日 2025/07/09
 */

package servlet;

import java.io.IOException;

import dao.JackworksDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/jackworksDelete")
public class JackworksDeleteServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// エラー文を格納用
		String error = null;
		// 例外判定用
		String cmd = null;
		// 遷移先のパス
		String path = "/monthJackworks";

		//オブジェクト生成
		JackworksDAO jackworksDAO = new JackworksDAO();

		try {
			//JackWorksのJackWorksIDを取得する
			String jackworksId = request.getParameter("jackworksId");

			//取得したJackWorksの情報を削除するメソッド
			jackworksDAO.delete(Integer.parseInt(jackworksId));

		} catch (IllegalStateException e) {
			error = "DB接続エラーのため、JackWorksは削除できませんでした。";
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
			// jackWorks.jspにフォワード
			request.getRequestDispatcher(path).forward(request, response);
		}
	}

}
