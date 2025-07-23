package servlet;

import java.io.IOException;

import bean.Account;
import bean.User;
import dao.AccountDAO;
import dao.UserDAO;
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
		
		//セッションの型宣言
		HttpSession session = request.getSession();
		
		//DAO宣言
		AccountDAO accountDAO = new AccountDAO();
		UserDAO userDAO = new UserDAO();
		
		//DTO宣言
		Account account = new Account();
		User user = new User();
		
		int userId = 0;
		String name = "";
		
		try {
			//メールアドレスの取得
			String email = request.getParameter("email");
			
			//アカウント情報を取得
			account = accountDAO.selectByEmail(email);
			String accountId = account.getAccountId();
			
			if(accountId == null) {
				error = "このアカウントは登録されていません";
				cmd = "login";
				return;
			}
			
			//ユーザー情報を取得
			user = userDAO.selectByAccountId(accountId);
			
			//名前とユーザーIDを格納
			userId = user.getUserId();
			name = user.getName();
			
			
			
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
