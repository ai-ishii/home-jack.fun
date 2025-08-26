/*
 * 機能：資格申請フォームに氏名、部名、グループ名をわたす機能
 * 
 * 作者：桑原岳
 * 
 * 最終更新日：2025/08/26
 * 
 **/

package servlet;

import java.io.IOException;
import java.util.ArrayList;

import bean.LicenseName;
import bean.LicenseRequestExclusive;
import dao.RequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/licenseFormPrepare")

public class LicenseFormPrepareServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		// セッションからuseridを取得する
		HttpSession session = request.getSession(false);
		int userId = (int) session.getAttribute("user_id");
		
		// オブジェクト化
		RequestDAO requestDAO = new RequestDAO();
		ArrayList<LicenseRequestExclusive> userList = new ArrayList<LicenseRequestExclusive>();
		
		// useridを引数にして氏名、部名、グループ名を取得しリストに格納する
		userList = requestDAO.selectUserId(userId);
		
		// requestName を取得し、リストに格納する
		ArrayList<LicenseName> licenseNameList = new ArrayList<LicenseName>();
		licenseNameList = requestDAO.selectAllLicenseName();
		
		// リストを licenseForm.jsp に送る
		session.setAttribute("userList", userList);
		session.setAttribute("licenseNameList", licenseNameList);
		request.getRequestDispatcher("/view/licenseForm.jsp").forward(request, response);
	}
}
