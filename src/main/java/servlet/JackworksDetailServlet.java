/**
 * JackWorks詳細機能
 * 
 * 作成者：青木美波
 * 
 * 作成日 2025/07/08
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

@WebServlet("/jackworksDetail")
public class JackworksDetailServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// エラー文を格納用
		String error = null;
		// 例外判定用
		String cmd = "";
		// 遷移先のパス
		String path = "/view/jackworksDetail.jsp";

		//オブジェクト生成
		JackworksDAO jackworksDAO = new JackworksDAO();
		Jackworks jackworks = new Jackworks();

		try {

			//jackworksRequest.jspからcmd=requestを受け取る
			cmd = request.getParameter("cmd");

			//JackWorksのJackWorksIDを取得する
			String jackworksId = request.getParameter("jackworksId");

			//JackWorksIdからJackWorksの情報を取得する
			jackworks = jackworksDAO.selectByJackworksId(Integer.parseInt(jackworksId));

			//削除対象の存在チェック
			if (jackworks.getJackworksId() == 0) {
				error = "このJackWorksは、すでに削除されています。";
				cmd = "monthJackworks";
			}

			//取得したJackWorksの情報詳細を表示するメソッド
			jackworks = jackworksDAO.selectByJackworksId(Integer.parseInt(jackworksId));

			// 取得したListをリクエストスコープに"jack_list"という名前で格納する
			request.setAttribute("jackworks", jackworks);

		} catch (IllegalStateException e) {
			error = "システムの一時的な問題により、\\r\\nJackWorksの読み込みができませんでした。";
			cmd = "logout";
		} catch (Exception e) {
			error = "予期せぬエラーが発生しました。" + e;
			cmd = "logout";
		} finally {
			if (error != null) {
				// 例外を発生する場合エラー文をリクエストスコープに"error"という名前で格納する
				request.setAttribute("error", error);
				// error.jspにフォワード
				path = "/view/error.jsp";
			}
			// 画面遷移分けのcmdを格納する
			request.setAttribute("cmd", cmd);
			// pathにフォワード
			request.getRequestDispatcher(path).forward(request, response);
		}
	}
}
