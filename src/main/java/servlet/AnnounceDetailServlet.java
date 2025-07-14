package servlet;

import java.io.IOException;

import bean.Announce;
import dao.AnnounceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/detailAnnounce")
public class AnnounceDetailServlet extends HttpServlet {
	
	public void doGet(HttpServletRequest request, 
			HttpServletResponse response)
			throws ServletException, IOException {
		
		String error = "";
		String cmd = "";
		
		Announce announce = new Announce();
		
		int announceId = Integer.parseInt(request.getParameter("announceId"));
		
		try {
			AnnounceDAO announceDAO = new AnnounceDAO();
			
			announce = announceDAO.selectByAnnounceId(announceId);
		} catch (Exception e) {
			
		} finally {
			if (error != "") {
				request.setAttribute("cmd", cmd);
				request.setAttribute("error", error);
				request.getRequestDispatcher("#").forward(request, response);
			} else {
				request.setAttribute("announce", announce);
				request.getRequestDispatcher("/view/announceDetail.jsp").forward(request, response);
			}
		}
	}
}
