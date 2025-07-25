package servlet;

import java.io.IOException;
import java.util.Collections;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;

import bean.Account;
import dao.AccountDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

	private static final String CLIENT_ID = "534918220824-ejk2iu9vqoh1oq6lpb5avgprak4hl05f.apps.googleusercontent.com";

	public void doGet (HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		commonProcess(request, response);
	}
	
	public void doPost (HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		commonProcess(request, response);
	}

	public void commonProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/plain; charset=UTF-8");
		
		//セッション登録準備
		HttpSession session = request.getSession(true);
		
		String idTokenString = request.getParameter("idtoken");
		
		//DAO宣言
		AccountDAO accountDAO = new AccountDAO();
		UserDAO userDAO = new UserDAO();
		
		//DTO宣言
		Account account = new Account();
		
		String error = "";
		String cmd = "";
		
		int userId = -1;
		String name = "";

		try {
			//idTokenが正しいものか検証するルールの設定
			GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(), new GsonFactory())
					.setAudience(Collections.singletonList(CLIENT_ID))
					.build();

			//検証の実行
			GoogleIdToken idToken = verifier.verify(idTokenString);
			
			//検証成功の場合
			if (idToken != null) {
				//googleユーザー情報の取得
				GoogleIdToken.Payload payload = idToken.getPayload();
				
				
				//ユーザー情報からID、メールアドレスを取得
				String accountId = payload.getSubject();
				String email = payload.getEmail();
				account = accountDAO.selectByAccountId(accountId);
				
				//アカウントが存在しない場合登録を行う
				if(account.getAccountId() == null) {
					//account_infoに登録
					accountDAO.insert(accountId, email);
					//user.infoに登録
					userDAO.insert(accountId);
					//登録したアカウント情報を取得
					account = accountDAO.selectByAccountId(accountId);
				}
				//ユーザーIDの取得
				userId = userDAO.selectByAccountId(accountId).getUserId();
				//名前の取得
				name = (String)payload.get("name");
				
			} else {
				error = "アカウントが認証できませんでした";
				cmd = "login";
				//ステータスコード(404とか)の取得
				response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
				//リダイレクト先の設定
				String jsonResponse = "{\"success\": false, \"redirectUrl\": \"view/error.jsp\"}";
				response.getWriter().write(jsonResponse);
			}
		} catch (Exception e) {
			error = "接続エラーです";
			cmd = "login";
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			String jsonResponse = "{\"success\": false, \"redirectUrl\": \"view/error.jsp\"}";
			response.getWriter().write(jsonResponse);
			e.printStackTrace();

		} finally {
			if (!error.equals("")) {			// エラーがない場合 homeにフォワード
				//セッション登録
				session.setAttribute("account", account);
				session.setAttribute("user_id", userId);
				session.setAttribute("user_name", name);
				String jsonResponse = "{\"success\": true, \"redirectUrl\": \"home\"}";
				response.getWriter().write(jsonResponse);
			}
		}
		
	}

}