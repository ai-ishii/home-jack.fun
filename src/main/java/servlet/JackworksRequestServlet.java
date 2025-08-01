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

		try {

			//jackworks.jspからcmd=agreeもしくはcmd=denialを受け取る
			cmd = request.getParameter("cmd");

			if (cmd == null) {
				cmd = "";
			}

			if (cmd.equals("agree")) {
				//JackWorksのJackWorksIDを取得する
				String jackworksId = request.getParameter("jackworksId");
				//AdminFlagを申請許可に変更するメソッドの実行
				jackworksDAO.updateAdminFlag(Integer.parseInt(jackworksId));
			}

			if (cmd.equals("denial")) {
				//JackWorksのJackWorksIDを取得する
				String jackworksId = request.getParameter("jackworksId");
				//AdminFlagを申請却下に変更するメソッドの実行
				jackworksDAO.denial(Integer.parseInt(jackworksId));
			}

			// JackWorksの全情報を取得するメソッドの実行
			ArrayList<Jackworks> jackList = jackworksDAO.selectAll();

			// 取得したjackListリクエストスコープに"jack_list"という名前で格納する
			request.setAttribute("jack_list", jackList);

		} catch (IllegalStateException e) {
			error = "DB接続エラーのため、JackWorksの登録は表示できませんでした。";
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
			// pathにフォワード
			request.getRequestDispatcher(path).forward(request, response);
		}

	}
}
