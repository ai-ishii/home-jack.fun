/**
 * JackWorks詳細機能
 * 
 * 作成者：青木美波
 * 
 * 作成日 2025/07/08
 * 更新日 2025/08/25
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

		// エラー用コマンド
		String error = "";
		// エラー文格納用
		String message = "";
		// 画面遷移用コマンド
		String cmd = "";
		// 遷移先のパス
		String path = "/view/jackworksDetail.jsp";

		//オブジェクト生成
		JackworksDAO jackworksDAO = new JackworksDAO();
		Jackworks jackworks = new Jackworks();

		try {

			//jackworksRequest.jspからcmd=requestを受け取る
			cmd = request.getParameter("cmd");

			//ぬるぽ対策
			if (cmd == null) {
				cmd = "";
			}

			//JackWorksのJackWorksIDを取得する
			String jackworksId = request.getParameter("jackworksId");

			//JackWorksIdからJackWorksの情報を取得する
			jackworks = jackworksDAO.selectByJackworksId(Integer.parseInt(jackworksId));

			//削除対象の存在チェック
			if (jackworks.getJackworksId() == 0) {
				message = "このJackWorksは、すでに削除されています。";
				path = "/monthJackworks";
			}

			// 取得したListをリクエストスコープに"jack_list"という名前で格納する
			request.setAttribute("jackworks", jackworks);

		} catch (IllegalStateException e) {
			message = "システムの一時的な問題により、JackWorksの読み込みができませんでした。";
			error = "logout";
		} catch (Exception e) {
			message = "予期せぬエラーが発生しました。" + e;
			error = "logout";
		} finally {

			if (!("").equals(error)) {
				// 例外が発生する場合エラー文をリクエストスコープに"error"という名前で格納する
				request.setAttribute("error", message);
				// 例外が発生する場合エラー種類をリクエストスコープに"cmdという名前で格納する
				request.setAttribute("cmd", error);
				// error.jspにフォワード
				path = "/view/error.jsp";
			}

			if (("").equals(error)) {
				request.setAttribute("message", message);
				request.setAttribute("cmd", cmd);

				if (cmd.equals("request")) {
					request.setAttribute("cmd", cmd);
				}
			}

			request.getRequestDispatcher(path).forward(request, response);
		}
	}
}
