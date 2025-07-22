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
		
		String idTokenString = request.getParameter("idtoken");
		
		//DAO宣言
		AccountDAO accountDAO = new AccountDAO();
		UserDAO userDAO = new UserDAO();

		try {
			GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(), new GsonFactory())
					.setAudience(Collections.singletonList(CLIENT_ID))
					.build();

			GoogleIdToken idToken = verifier.verify(idTokenString);
			if (idToken != null) {
				// 成功した場合、成功したこととリダイレクト先のURLをJSONで返す
				GoogleIdToken.Payload payload = idToken.getPayload();
				// (セッションにユーザー情報を保存するなどの処理をここに追加できる)
				HttpSession session = request.getSession(true);
				
				
				String accountId = payload.getSubject();
				String email = payload.getEmail();
				Account account = accountDAO.selectByAccountId(accountId);
				
				if(account.getAccountId() == null) {
					int count = accountDAO.insert(accountId, email);
					userDAO.insert(accountId);
					account = accountDAO.selectByAccountId(accountId);
				}
				int userId = userDAO.selectByAccountId(accountId).getUserId();
				
				session.setAttribute("account", account);
				session.setAttribute("user_id", userId);
				session.setAttribute("user_name", payload.get("name"));
				
				String jsonResponse = "{\"success\": true, \"redirectUrl\": \"home\"}";
				response.getWriter().write(jsonResponse);
			} else {
				// 失敗した場合、失敗したことをJSONで返す
				response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
				String jsonResponse = "{\"success\": false, \"redirectUrl\": \"view/error.jsp\"}";
				response.getWriter().write(jsonResponse);
			}
		} catch (Exception e) {
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			String jsonResponse = "{\"success\": false, \"redirectUrl\": \"view/error.jsp\"}";
			response.getWriter().write(jsonResponse);
			e.printStackTrace();

		}
		
	}

}