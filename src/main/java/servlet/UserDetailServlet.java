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
import java.util.ArrayList;

import bean.Authority;
import bean.AuthorityHaving;
import bean.User;
import dao.AuthorityDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/userDetail")
public class UserDetailServlet extends HttpServlet {

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

		String cmd = "";
		String path = "";
	
		HttpSession session = request.getSession();
		
		//オブジェクト生成
		User user = new User();
		UserDAO userDAO = new UserDAO();
		Authority authority = new Authority();
		AuthorityDAO authorityDAO = new AuthorityDAO();
		
		ArrayList<Authority> authorityList = new ArrayList<Authority>();
		ArrayList<AuthorityHaving> authorityHavingList = new ArrayList<AuthorityHaving>();

	
		

		try {
			
			 Integer userId = (Integer) session.getAttribute("user_id");

			user = userDAO.selectByUserId(userId);
			authorityList = authorityDAO.selectAllAuthority();
			authorityHavingList = authorityDAO.selectByUserId(userId);
			
			
			
			request.setAttribute("user", user);
			request.setAttribute("authority_list",authorityList);
			request.setAttribute("authority_having_list", authorityHavingList);
			
			request.getRequestDispatcher("/view/userDetail.jsp").forward(request,response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "登録処理中にエラーが発生しました。");
			request.getRequestDispatcher("/view/error.jsp").forward(request, response);
		}
	}

}