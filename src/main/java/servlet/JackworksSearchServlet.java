/**
 * JackWorks検索機能
 * 
 * 作成者：青木美波
 * 
 * 作成日 2025/07/15
 * 最終更新日：2025/08/21
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

		// エラー用コマンド
		String error = "";
		// エラー文格納用
		String message = "";
		// 画面遷移用コマンド
		String cmd = "";
		String cmd2 = "";
		// 遷移先のパス
		String path = "/monthJackworks";

		//オブジェクト生成
		JackworksDAO jackworksDAO = new JackworksDAO();
		ArrayList<Jackworks> jackList = new ArrayList<Jackworks>();

		try {
			//検索された値をkeywordで受け取る
			String keyword = request.getParameter("keyword");

			//選択された年月を受け取る
			String start = request.getParameter("start_month");
			String end = request.getParameter("end_month");

			//jackworksRequest.jspからcmd=requestを受け取る
			cmd2 = request.getParameter("cmd");

			//ぬるぽ対策
			if (cmd2 == null) {
				cmd2 = "";
			}

			//年月検索
			if (start != null && !start.isEmpty() && end != null && !end.isEmpty()) {
				Timestamp startMonth = Timestamp.valueOf(start);
				Timestamp endMonth = Timestamp.valueOf(end);
				jackList = jackworksDAO.selectByDateFilter(startMonth, endMonth);
			} else if (keyword != null && !keyword.isEmpty()) {
				//キーワード検索
				jackList = jackworksDAO.search(keyword);
			}

			//検索結果が0件の場合
			if (jackList.size() == 0) {
				cmd = "no-result";
			} else {
				cmd = "search";
			}

			//検索結果の情報を格納
			request.setAttribute("jack_list", jackList);
			request.setAttribute("keyword", keyword);
			request.setAttribute("startMonth", start);
			request.setAttribute("endMonth", end);

		} catch (IllegalStateException e) {
			message = "システムの一時的な問題により、検索結果の読み込みができませんでした。";
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

				//申請一覧画面へ遷移
				if (cmd2.equals("request")) {
					path = "/view/jackworksRequest.jsp";
				}
			}

			request.getRequestDispatcher(path).forward(request, response);
		}
	}

}
