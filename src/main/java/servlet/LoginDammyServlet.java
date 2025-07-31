/**
 * ダミーデータログイン後アカウント情報やユーザー情報をセッション登録するサーブレット
 * 
 * 作成者：石田允彦
 * 
 * 作成日：2025/07/18
 * 最終更新日：2025/07/29
 */

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
		
		//セッション準備
		HttpSession session = request.getSession();
		
		//DAO宣言
		AccountDAO accountDAO = new AccountDAO();
		UserDAO userDAO = new UserDAO();
		
		//DTO宣言
		Account account = new Account();
		User user = new User();
		
		try {
			//email受け取り
			String email = request.getParameter("email");
			
			//emailからアカウント情報を取得
			account = accountDAO.selectByEmail(email);
			String accountId = account.getAccountId();
			
			if(accountId == null) {
				error = "このアカウントは登録されていません";
				cmd = "login";
				
				return;
			}
			//ユーザー情報を取得
			user = userDAO.selectByAccountId(accountId);
			
		} catch (IllegalStateException e) {
			error = "DB接続エラーの為、一覧表示は行えませんでした。";
			cmd = "login";
		} catch (Exception e) {
			error = "予期せぬエラーが発生しました。" + e;
			cmd = "login";
		} finally {
			if (!error.equals("")) {	// エラーがある場合 error.jspにフォワード
				request.setAttribute("error", error);
				request.setAttribute("cmd", cmd);
				request.getRequestDispatcher("/view/error.jsp").forward(request, response);
			
			} else {					// エラーがない場合 homeにフォワード
				session.setAttribute("account", account);
				session.setAttribute("user_id", user.getUserId());
				session.setAttribute("name", user.getName());
				request.getRequestDispatcher("/home").forward(request, response);
			}
		}
		
	}
}
