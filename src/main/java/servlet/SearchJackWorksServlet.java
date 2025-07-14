/**
 * JackWorksソート機能
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

@WebServlet("/searchJackWorks")
public class SearchJackWorksServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// エラー文を格納用
		String error = null;
		// 例外判定用
		String cmd = null;
		// 遷移先のパス
		String path = "/monthJackWorks";

		try {

			JackWorksDAO jackworksDAO = new JackWorksDAO();

			String name = request.getParameter("name");

			//入力された情報を検索するメソッド
			ArrayList<Jackworks> jackList = jackworksDAO.search(name);
			
			//検索表示させるためのcmd
			cmd = "search";
			
			// 取得したjackListリクエストスコープに"jack_list"という名前で格納する
			request.setAttribute("jack_list", jackList);
			
			// cmdをリクエストスコープに"cmd"という名前で格納する
			request.setAttribute("cmd", cmd);

		} catch (IllegalStateException e) {
			error = "DB接続エラーの為、JackWorks検索結果は表示できませんでした。";
			cmd = "detail";
		} catch (Exception e) {
			error = "予期せぬエラーが発生しました。" + e;
			cmd = "logout";
		} finally {
			// pathにフォワード
			request.getRequestDispatcher(path).forward(request, response);
		}
	}

}
