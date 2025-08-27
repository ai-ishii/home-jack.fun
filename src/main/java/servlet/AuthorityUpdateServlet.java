/**
 * 権限の更新を行うサーブレット
 * 作成者:石田允彦
 * 
 * 作成日:2025/08/26
 * 更新日:2025/08/26
 */
package servlet;

import java.io.IOException;
import java.util.ArrayList;

import bean.Authority;
import bean.AuthorityHaving;
import dao.AuthorityDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/authUpdate")
public class AuthorityUpdateServlet extends HttpServlet {

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
		String error = "";
		String message = "";
		String path = "/userList";
		
		ArrayList<Authority> authorityList = new ArrayList<Authority>();
		ArrayList<AuthorityHaving> authorityHavingList = new ArrayList<AuthorityHaving>();
		
		AuthorityDAO authorityDAO = new AuthorityDAO();
		
		try {
			//画面から送られてきたデータを取得
			String strUserId = request.getParameter("user_id");
			int userId = Integer.parseInt(strUserId);
			String[] authCodeList = request.getParameterValues("auth_list");
			
			for (String code : authCodeList) {
				AuthorityHaving authorityHaving = new AuthorityHaving();
				authorityHaving.setUserId(userId);
				authorityHaving.setAuthorityCode(code);
				authorityHavingList.add(authorityHaving);
			}
			authorityDAO.updateAuthorityHaving(userId, authorityHavingList);
			
		} catch(IllegalStateException e) {
			message = "DB接続エラーのため、権限振り分け画面は表示できませんでした。";
			error = "logout";
		} catch (Exception e) {
			message = "予期せぬエラーが発生しました。" + e;
			error = "logout";
		} finally {
			if (!("").equals(error)) {
				// 例外が発生する場合エラー文をリクエストスコープに"error"という名前で格納する
				request.setAttribute("error", message);
				// 例外が発生する場合エラー種類をリクエストスコープに"cmdという名前で格納する
				request.setAttribute("cmd", error);
				// error.jspをフォワード先に指定
				path = "/view/error.jsp";
			}
			if (("").equals(error)) {
				request.setAttribute("authority_list", authorityList);
				request.setAttribute("authority_having_list", authorityHavingList);
			}
			
			request.getRequestDispatcher(path).forward(request, response);
		}
	}
}
