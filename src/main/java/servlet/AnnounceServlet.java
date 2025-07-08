package servlet;

import java.io.IOException;
import java.util.ArrayList;

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

		AnnounceDAO announceDAO = new AnnounceDAO();

		ArrayList announceList = announceDAO.selectAnnounceAll();

		// request.setAttribute("announceList", announceList);
		request.getRequestDispatcher("/view/announce.jsp").
		forward(request, response);
	}

}
