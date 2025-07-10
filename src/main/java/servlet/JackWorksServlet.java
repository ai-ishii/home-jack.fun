/**
 * JackWorks機能
 * 
 * 作成者：青木美波
 * 
 * 作成日 2025/06/19
 */

package servlet;

import java.io.IOException;
import java.util.ArrayList;

import bean.Jackworks;
import dao.JackWorksDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/jackWorks")
public class JackWorksServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// エラー文を格納用
		String error = null;
		// 例外判定用
		String cmd = null;
		// 遷移先のパス
		String path = "/view/jackWorks.jsp";

		//オブジェクト生成
		JackWorksDAO jackworksDAO = new JackWorksDAO();

		try {

			//JackWorksの全情報を取得するメソッド
			ArrayList<Jackworks> jackList = jackworksDAO.selectAll();
			
			// 取得したListをリクエストスコープに"jack_list"という名前で格納する
			request.setAttribute("jack_list", jackList);

		} catch (IllegalStateException e) {
			error = "DB接続エラーのため、JackWorksは表示できませんでした。";
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
