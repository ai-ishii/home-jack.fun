/**
 * JackWorks申請機能
 * 
 * 作成者：青木美波
 * 
 * 作成日 2025/07/29
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

@WebServlet("/jackworksRequest")
public class JackworksRequestServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// エラー文を格納用
		String error = null;
		// 例外判定用
		String cmd = null;
		// 遷移先のパス
		String path = "/view/jackworksRequest.jsp";

		//オブジェクト生成
		JackworksDAO jackworksDAO = new JackworksDAO();
		Jackworks jackworks = new Jackworks();

		try {

			//jackworks.jspからcmd=agreeもしくはcmd=denialを受け取る
			cmd = request.getParameter("cmd");
			if (cmd == null) {
				cmd = "";
			} else {
				//JackWorksのJackWorksIDを取得する
				String jackworksId = request.getParameter("jackworksId");
				//JackWorksIdからJackWorksの情報を取得する
				jackworks = jackworksDAO.selectByJackworksId(Integer.parseInt(jackworksId));

				//削除対象の存在チェック
				if (jackworks.getJackworksId() == 0) {
					error = "このJackWorksは、すでに削除されています。";
					cmd = "monthJackworks";
					return;
				} else if (jackworks.getApprovalFlag() == 1) {
					error = "このデータはすでに申請許可がされています。";
					cmd = "monthJackworks";
					return;
				} else if (jackworks.getApprovalFlag() == 2) {
					error = "このデータはすでに差し戻しがされています。";
					cmd = "monthJackworks";
					return;
				}

				if (cmd.equals("agree")) {
					//AdminFlagを申請許可に変更するメソッドの実行
					jackworksDAO.updateApprovalFlag(Integer.parseInt(jackworksId));
				}

				if (cmd.equals("denial")) {
					//AdminFlagを申請却下に変更するメソッドの実行
					jackworksDAO.denial(Integer.parseInt(jackworksId));
				}
			}

			// JackWorksの全情報を取得するメソッドの実行
			ArrayList<Jackworks> jackList = jackworksDAO.selectAll();

			// 取得したjackListリクエストスコープに"jack_list"という名前で格納する
			request.setAttribute("jack_list", jackList);

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
