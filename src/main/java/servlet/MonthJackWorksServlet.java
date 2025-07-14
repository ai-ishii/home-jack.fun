/**
 * 今月のJackWorks機能
 * 
 * 作成者：青木美波
 * 
 * 作成日 2025/06/19
 */

package servlet;

import java.io.IOException;
import java.util.ArrayList;

import bean.Jackworks;
import bean.Monthjack;
import dao.MonthJackDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/monthJackWorks")
public class MonthJackWorksServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// エラー文を格納用
		String error = null;
		// 例外判定用
		String cmd = null;
		// 遷移先のパス
		String path = "/jackWorks";

		//オブジェクト生成
		MonthJackDAO monthJackDAO = new MonthJackDAO();
		Monthjack monthJack = new Monthjack();

		try {
			
			//JackWorksの全情報が格納されたjack_listを受け取る
			ArrayList<Jackworks> jackList = (ArrayList<Jackworks>) request.getAttribute("jack_list");

			cmd = request.getParameter("cmd");
			
			if (cmd == null) {
				cmd = "";
			}

			//更新情報を受け取る
			if (cmd.equals("update")) {
				String image = request.getParameter("image");
				monthJack.setImage(image);
				String theme = request.getParameter("theme");
				monthJack.setTheme(theme);
				String note = request.getParameter("note");
				monthJack.setNote(note);

				//JackWorksの全情報を更新するメソッド
				monthJackDAO.update(monthJack);

			}

			//JackWorksの全情報を取得するメソッド
			monthJack = monthJackDAO.selectAll();

			// 取得したListをリクエストスコープに"jack_list"という名前で格納する
			request.setAttribute("monthJack", monthJack);
			
			// cmdをリクエストスコープに"cmd"という名前で格納する
			request.setAttribute("cmd", cmd);
			
			if(jackList != null) {
			// 取得したjackListリクエストスコープに"jack_list"という名前で格納する
			request.setAttribute("jack_list", jackList);
			}

		} catch (IllegalStateException e) {
			error = "DB接続エラーのため、今月のJackWorksは表示できませんでした。";
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
