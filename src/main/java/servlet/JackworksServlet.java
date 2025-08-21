/**
 * JackWorks機能
 * 
 * 作成者：青木美波
 * 
 * 作成日：2025/07/08
 * 更新日：2025/08/21
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

		// エラー用コマンド
		String error = "";
		// エラー文格納用
		String message = "";
		// 画面遷移用コマンド
		String cmd = "";
		// 遷移先のパス
		String path = "/view/jackworks.jsp";

		//オブジェクト生成
		JackworksDAO jackworksDAO = new JackworksDAO();
		ArrayList<Jackworks> jackList = new ArrayList<Jackworks>();

		try {

			// JackWorksの全情報を取得するメソッド
			jackList = jackworksDAO.selectAll();

			// 取得したListをリクエストスコープに"jack_list"という名前で格納する
			request.setAttribute("jack_list", jackList);

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
				request.setAttribute("cmd", cmd);
			}

			request.getRequestDispatcher(path).forward(request, response);
		}
	}

}
