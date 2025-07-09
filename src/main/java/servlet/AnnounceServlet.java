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

@WebServlet("/announce")
public class AnnounceServlet extends HttpServlet {

	public void doGet(HttpServletRequest request,
			HttpServletResponse response)
			throws ServletException, IOException {

		String error = "";
		String cmd = "";

		ArrayList<Announce> announceList = new ArrayList<Announce>();

		try {
			AnnounceDAO announceDAO = new AnnounceDAO();

			announceList = announceDAO.selectAnnounceAll();
		} catch (Exception e) {
			cmd = "";
			error = "予期せぬエラーが発生しました。" + e;
		} finally {
			if (error != "") {
				request.setAttribute("cmd", cmd);
				request.setAttribute("error", error);
				request.getRequestDispatcher("#").forward(request, response);
			} else {
				request.setAttribute("announceList", announceList);
				request.getRequestDispatcher("/view/announce.jsp").forward(request, response);
			}
		}
	}

}
