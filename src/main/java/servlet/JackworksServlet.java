/**
 * JackWorks機能
 * 
 * 作成者：青木美波
 * 
 * 作成日 2025/07/08
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

@WebServlet("/jackworks")
@SuppressWarnings("unchecked") //コンパイルエラーがでなくなっているので注意
public class JackworksServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		commonProcess(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		commonProcess(request, response);
	}

	public void commonProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// エラー文を格納用
		String error = null;
		// 例外判定用
		String cmd = "";
		// 遷移先のパス
		String path = "/view/jackworks.jsp";

		//オブジェクト生成
		JackworksDAO jackworksDAO = new JackworksDAO();
		ArrayList<Jackworks> jackList = new ArrayList<Jackworks>();

		try {
			//SearchJackworksからcmd=search もしくはmonthJackworks.jspからcmd=update受け取る
			cmd = (String) request.getAttribute("cmd");

			if (cmd == null) {
				cmd = "";
			}

			if (cmd.equals("search")) {
				//jackWorksの検索結果が格納されたjack_listを受け取る
				jackList = (ArrayList<Jackworks>) request.getAttribute("jack_list");
			} else {
				// JackWorksの全情報を取得するメソッド
				jackList = jackworksDAO.selectAll();
			}
			

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