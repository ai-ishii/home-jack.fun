/**
 * 社員情報登録機能
 * 
 * 作成者：月向亮太
 * 
 * 作成日：8月18日
 * 
 * 最終更新日：8月26日
 * 
 */
package servlet;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import bean.User;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/userRegister")
public class UserRegisterServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		commonProcess(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		commonProcess(request, response);
	}

	private void commonProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();

		//オブジェクトの生成
		UserDAO userDAO = new UserDAO();

		try {
			User user = (User) session.getAttribute("user");
			

			if (user == null) {
				request.getRequestDispatcher("/index.jsp").forward(request, response);

			}

			userDAO.updateProfile(user);

			//セッション登録
			session.setAttribute("profile", true);
			session.setAttribute("user", user);
			
			/*
			session.setAttribute("user_id", user.getUserId());
			session.setAttribute("user_name", user.getName());

			*/

			request.getRequestDispatcher("/home").forward(request, response);
	
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "登録処理中にエラーが発生しました。");
			request.getRequestDispatcher("/view/error.jsp").forward(request, response);
		}

	}
}
