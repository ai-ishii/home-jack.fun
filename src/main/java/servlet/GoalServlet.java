package servlet;

import java.io.IOException;
import java.util.ArrayList;

import bean.User;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/goal")
public class GoalServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String error = "";
		String strUserId = "";
		String cmd = "";
		
		//オブジェクト宣言
		User user = new User();
		//DAO宣言
		UserDAO userDAO = new UserDAO();
		
		try {
			
			//getParameterメソッドを呼び出す
			strUserId = request.getParameter("user_id");
			cmd = request.getParameter("cmd");

			strUserId = "5";

			if (cmd == null) {
				cmd = ""; //※ここは後で絶対に変える文章なので覚えておいてください
			}
			//userIdをキャスト
			int userId = Integer.parseInt(strUserId);

			//全検索メソッドを呼び出す
			user = userDAO.selectByUserId(userId);

		} catch (Exception e) {

		} finally {
			if (error != "") {
				request.getRequestDispatcher("/view/error.jsp").forward(request, response);
			}
			//リクエストスコープを使ってフォワード
			request.setAttribute("user", user);
			request.getRequestDispatcher("/view/goal.jsp").forward(request, response);
		}
	}
}
