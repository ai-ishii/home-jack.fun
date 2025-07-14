package servlet;

import java.io.IOException;
import java.util.ArrayList;

import bean.Announce;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/index")
public class IndexServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String error = "";
		String cmd = "";
		
		ArrayList<Announce> importantList = new ArrayList<Announce>();
		ArrayList<Announce> announceList = new ArrayList<Announce>();
		ArrayList<Announce> activityList = new ArrayList<Announce>();
		
		
	}
}
