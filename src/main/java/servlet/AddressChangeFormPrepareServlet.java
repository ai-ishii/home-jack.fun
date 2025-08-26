/*
 * 機能：住所申請フォームに社員番号、氏名、旧郵便番号、旧住所をわたす機能
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

@WebServlet("/addressChangeFormPrepare")

public class AddressChangeFormPrepareServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		// セッションからuseridを取得する
		HttpSession session = request.getSession(false);
		int userId = (int) session.getAttribute("user_id");
		
		// オブジェクト化
		RequestDAO requestDAO = new RequestDAO();
		User userAddress = new User();
		
		// useridを引数にして社員番号、氏名、旧郵便番号、旧住所を取得しリストに格納する
		userAddress = requestDAO.selectUserAddress(userId);
		
		// リストを addressChangeForm.jsp に送る
		session.setAttribute("userAddress", userAddress);
		request.getRequestDispatcher("/view/addressChangeForm.jsp").forward(request, response);
	}
}
