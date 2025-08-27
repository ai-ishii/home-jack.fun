/*
 * 機能：氏名申請フォームに旧氏名、旧氏名(かな)をわたす機能
 * 
 * 作者：桑原岳
 * 
 * 最終更新日：2025/08/26
 * 
 **/

package servlet;

import java.io.IOException;

import bean.User;
import dao.RequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/nameChangeFormPrepare")

public class NameChangeFormPrepareServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		// セッションからuseridを取得する
		HttpSession session = request.getSession(false);
		int userId = (int) session.getAttribute("user_id");
		
		// オブジェクト化
		RequestDAO requestDAO = new RequestDAO();
		User userName = new User();
		
		// useridを引数にして旧氏名、旧氏名(かな)を取得しリストに格納する
		userName = requestDAO.selectUserName(userId);
		
		// リストを licenseForm.jsp に送る
		session.setAttribute("userName", userName);
		request.getRequestDispatcher("/view/nameChangeForm.jsp").forward(request, response);
	}
}
