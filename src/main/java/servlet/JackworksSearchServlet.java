/**
 * JackWorks検索機能
 * 
 * 作成者：青木美波
 * 
 * 作成日 2025/07/15
 * 
 * 最終更新日：2025/08/13
 */

package servlet;

import java.io.IOException;
import java.sql.Timestamp;
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
		String cmd = "";
		// 遷移先のパス
		String path = "/jackworks";

		//オブジェクト生成
		JackworksDAO jackworksDAO = new JackworksDAO();
		ArrayList<Jackworks> jackList = new ArrayList<Jackworks>();

		try {
			//検索された値をnameで受け取る
			String name = request.getParameter("name");
			//選択された年月を受け取る
			String start = request.getParameter("start_date");
			String end = request.getParameter("end_date");

			if (start != null && !start.isEmpty() && end != null && !end.isEmpty()) {
				Timestamp startDate = Timestamp.valueOf(start + " 00:00:00");
				Timestamp endDate = Timestamp.valueOf(end + " 23:59:59");
				jackList = jackworksDAO.selectByDateFilter(startDate, endDate);

			} else if (name != null && !name.isEmpty()) {

				// --- キーワード検索 ---
				jackList = jackworksDAO.search(name);
			}

			if (name == null) {
				name = "";
			}

			//jackworksRequest.jspからcmd=requestを受け取る
			cmd = request.getParameter("cmd");

			if (cmd == null) {
				cmd = "";
			}

			if (!cmd.equals("request")) {
				//検索表示させるためのcmd
				cmd = "search";

				path = "/monthJackworks";
			}

			// 取得したjackListリクエストスコープに"jack_list"という名前で格納する
			request.setAttribute("jack_list", jackList);
			request.setAttribute("name", name);
			request.setAttribute("srartDate", start);
			request.setAttribute("end", end);

		} catch (IllegalStateException e) {
			error = "システムの一時的な問題により、\\r\\n検索結果の読み込みができませんでした。";
			cmd = "logout";
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
			// cmdをリクエストスコープに"cmd"という名前で格納する
			request.setAttribute("cmd", cmd);
			// pathにフォワード
			request.getRequestDispatcher(path).forward(request, response);
		}
	}

}
