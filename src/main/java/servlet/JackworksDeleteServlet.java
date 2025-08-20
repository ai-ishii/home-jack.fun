/**
 * JackWorks削除機能
 * 
 * 作成者：青木美波
 * 
 * 作成日 2025/07/09
 * 更新日 2025/08/19
 */

package servlet;

import java.io.IOException;

import bean.Jackworks;
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
		String error = "";
		// 例外判定用
		String cmd = "";
		// 遷移先のパス
		String path = "/monthJackworks";

		//オブジェクト生成
		JackworksDAO jackworksDAO = new JackworksDAO();
		Jackworks jackworks = new Jackworks();

		try {
			//JackWorksのJackWorksIDを取得する
			String jackworksId = request.getParameter("jackworksId");
			//jackworksRequest.jspからcmd=denialを受け取る
			cmd = request.getParameter("cmd");

			//JackWorksIdからJackWorksの情報を取得する
			jackworks = jackworksDAO.selectByJackworksId(Integer.parseInt(jackworksId));

			//削除対象の存在チェック
			if (jackworks.getJackworksId() == 0) {
				error = "このJackWorksは、すでに削除されています。";
				cmd = "monthJackworks";
			}

			if (cmd.equals("denial")) {
				path = "/jackworksRequest";
			}

			//取得したJackWorksの情報を削除するメソッド
			jackworksDAO.delete(Integer.parseInt(jackworksId));

		} catch (IllegalStateException e) {
			error = "システムの一時的な問題により、\\r\\nJackWorks情報の削除ができませんでした。";
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
			// pathにフォワード
			request.getRequestDispatcher(path).forward(request, response);
		}
	}

}
