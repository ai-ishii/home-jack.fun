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
		Jackworks jack = new Jackworks();

		try {
			
			cmd = request.getParameter("cmd");
			
			if(cmd == null) {
				cmd="";
			}
			
			if(cmd.equals("agree")) {
			//JackWorksのJackWorksIDを取得する
			String jackworksId = request.getParameter("jackworksId");
			jackworksDAO.updateAdminFlag(Integer.parseInt(jackworksId));
			}
			
			// JackWorksの全情報を取得するメソッド
			ArrayList<Jackworks> jackList = jackworksDAO.selectAll();
			
			// 取得したjackListリクエストスコープに"jack_list"という名前で格納する
			request.setAttribute("jack_list", jackList);

		} catch (IllegalStateException e) {
			error = "DB接続エラーのため、JackWorksの登録は表示できませんでした。";
			cmd = "home";
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
			// 例外を発生する場合エラー種類をリクエストスコープに"cmdという名前で格納する
			request.setAttribute("cmd", cmd);

			request.getRequestDispatcher(path).forward(request, response);
		}

	}
}
