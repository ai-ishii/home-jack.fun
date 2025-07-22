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

@WebServlet("/announceSearch")
public class AnnounceSearchServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 変数宣言
		String error = "";
		String cmd = "";

		AnnounceDAO announceDAO = new AnnounceDAO();
		ArrayList<Announce> announceList = new ArrayList<Announce>();

		// フォームから送信した検索方法をを受け取る
		cmd = request.getParameter("cmd");

		try {
			if (cmd.equals("keyword")) {
				String keyword = request.getParameter("keyword");

				announceList = announceDAO.selectByKeyword(keyword);
			}

		} catch (Exception e) {
			cmd = "";
			error = "予期せぬエラーが発生しました。" + e;
		} finally {
			if (error != "") {
				request.setAttribute("cmd", cmd);
				request.setAttribute("error", error);
				request.getRequestDispatcher("").forward(request, response);
			}

			if (cmd.equals("keyword")) {
				request.setAttribute("announceList", announceList);
				request.getRequestDispatcher("/view/announce.jsp").forward(request, response);
			}
		}
	}

}
