package servlet;

import java.io.IOException;
import java.util.ArrayList;

import bean.Announce;
import dao.AnnounceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/announceDetail")
public class AnnounceDetailServlet extends HttpServlet {

	public void doGet(HttpServletRequest request,
			HttpServletResponse response)
			throws ServletException, IOException {

		// 変数宣言
		String error = "";
		String cmd = "";

		// オブジェクト生成
		Announce announce = new Announce();
		AnnounceDAO announceDAO = new AnnounceDAO();
		ArrayList<Announce> announceList = new ArrayList<Announce>();

		// jspファイルからパラメータ取得
		int announceId = Integer.parseInt(request.getParameter("announceId"));
		cmd = request.getParameter("cmd");

		try {
			// メソッドからSQL実行
			announce = announceDAO.selectByAnnounceId(announceId);

			if (cmd.equals("detail")) {

				// メソッドからSQL実行
				announceList = announceDAO.selectAll();

			}

		} catch (Exception e) {

		} finally {
			if (error != "") {
				request.setAttribute("cmd", cmd);
				request.setAttribute("error", error);
				request.getRequestDispatcher("#").forward(request, response);
			}
			// お知らせ詳細画面に遷移する条件式
			if (cmd.equals("detail")) {
				request.setAttribute("announce", announce);
				request.setAttribute("announceList", announceList);
				request.getRequestDispatcher("/view/announceDetail.jsp").forward(request, response);
			}
			// お知らせ更新画面に遷移する条件式
			if (cmd.equals("update")) {
				request.setAttribute("announce", announce);
				request.getRequestDispatcher("/view/announceUpdate.jsp").forward(request, response);
			}

		}
	}
}
