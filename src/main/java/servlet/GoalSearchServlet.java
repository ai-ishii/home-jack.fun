/**
 * 個人目標一覧機能（マネージャー）
 * 
 * 作成者：月向亮太
 * 
 * 作成日：7月8日
 * 
 * 最終更新日：8月7日
 * 
 */
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

@WebServlet("/goalSearch")
public class GoalSearchServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String error = "";
		String cmd = "";
		
		//DAO宣言
		UserDAO userDAO = new UserDAO();
		
		//配列宣言
		ArrayList<User> userList = new ArrayList<User>();
		
		
		try {
			
			//getParameterメソッドを呼び出す
			cmd = request.getParameter("cmd");
			

			if (cmd == null) {
				cmd = ""; //※ここは後で絶対に変える文章なので覚えておいてください
			}


			//selectAllメソッドを呼び出す
			userList = userDAO.selectAll();
			
			System.out.print(userList);
			
		} catch (Exception e) {
			error = "エラーです。";
		} finally {
			if (!error.isEmpty()) {
				request.getRequestDispatcher("/view/error.jsp").forward(request, response);
			}
			//リクエストスコープを使ってフォワード
			request.setAttribute("userList", userList);
			request.getRequestDispatcher("/view/goal.jsp").forward(request, response);
		}
	}
}
