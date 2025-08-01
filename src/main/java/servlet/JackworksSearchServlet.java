/**
 * JackWorks検索機能
 * 
 * 作成者：青木美波
 * 
 * 作成日 2025/07/15
 */

package servlet;

import java.io.IOException;
import java.util.ArrayList;

import bean.Jackworks;
import dao.JackworksDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/jackworksSearch")
public class JackworksSearchServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// エラー文を格納用
		String error = null;
		// 例外判定用
		String cmd = null;
		// 遷移先のパス
		String path = "/monthJackworks";

		//オブジェクト生成
		JackworksDAO jackworksDAO = new JackworksDAO();
		ArrayList<Jackworks> jackList = new ArrayList<Jackworks>();

		try {
			//検索された値をnameで受け取る
			String name = request.getParameter("name");

			//選択された年月を受け取る
			String monthSearch = request.getParameter("month-search");
			String yearSearch = request.getParameter("year-search");

			if (name == null) {
				String selectSearch = yearSearch + "-" + monthSearch;
				//選択された年月に該当する情報を検索するメソッド
				jackList = jackworksDAO.selectSearch(selectSearch);
			} else {
				//入力された文字に該当する情報を検索するメソッド
				jackList = jackworksDAO.search(name);
			}

			//検索表示させるためのcmd
			cmd = "search";

			// 取得したjackListリクエストスコープに"jack_list"という名前で格納する
			request.setAttribute("jack_list", jackList);
			request.setAttribute("name", name);
			
			request.setAttribute("monthSearch", monthSearch);
			request.setAttribute("yearSearch", yearSearch);

		} catch (IllegalStateException e) {
			error = "DB接続エラーの為、JackWorks検索結果は表示できませんでした。";
			cmd = "";
		} catch (Exception e) {
			error = "予期せぬエラーが発生しました。" + e;
			cmd = "";
		} finally {
			if (error != null) {
				// 例外を発生する場合エラー文をリクエストスコープに"error"という名前で格納する
				request.setAttribute("error", error);
				// 例外を発生する場合エラー種類をリクエストスコープに"cmdという名前で格納する
				request.setAttribute("cmd", cmd);
				// error.jspにフォワード
				path = "/view/error.jsp";
			}
			// cmdをリクエストスコープに"cmd"という名前で格納する
			request.setAttribute("cmd", cmd);
			// pathにフォワード
			request.getRequestDispatcher(path).forward(request, response);
		}
	}

}
