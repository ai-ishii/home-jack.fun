package servlet;

import java.io.IOException;

import bean.Account;
import dao.AccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/loginDammy")
public class LoginDammyServlet extends HttpServlet {

	public void doGet (HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String error = "";
		String cmd = "";
		
		HttpSession session = request.getSession();
		
		AccountDAO accountDAO = new AccountDAO();
		
		Account account = new Account();
		
		try {
			
			String email = request.getParameter("email");
			
			account = accountDAO.selectByEmail(email);
			
			if(account.getAccountId() == null) {
				error = "このアカウントは登録されていません";
				cmd = "login";
			}
			
		} catch (IllegalStateException e) {
			error = "DB接続エラーの為、一覧表示は行えませんでした。";
			cmd = "menu";
		} catch (Exception e) {
			error = "予期せぬエラーが発生しました。" + e;
			cmd = "";
		} finally {
			if (!error.equals("")) {	// エラーがある場合 error.jspにフォワード
				request.setAttribute("error", error);
				request.setAttribute("cmd", cmd);
				request.getRequestDispatcher("/view/error.jsp").forward(request, response);
			
			} else {					// エラーがない場合 homeにフォワード
				session.setAttribute("account", account);
				request.getRequestDispatcher("/home").forward(request, response);
			}
		}
		
	}
}
