/**
 * 社員情報登録機能
 * 
 * 作成者：月向亮太
 * 
 * 作成日：8月18日
 * 
 * 最終更新日：8月27日
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

		// エラー用フラグ
		boolean error = false;
		// 画面遷移用コマンド
		String cmd = "";
		// エラー文格納用
		String message = "";
		// 遷移先のパス
		String path = "/view/userDetail.jsp";
		//詳細を表示をするユーザーのID
		int userId = 0;
		//ログインしているユーザーのID
		int myUserId = 0;

		//オブジェクト生成
		User user = new User();
		UserDAO userDAO = new UserDAO();
		AuthorityDAO authorityDAO = new AuthorityDAO();

		ArrayList<Authority> authorityList = new ArrayList<Authority>();
		ArrayList<AuthorityHaving> authorityHavingList = new ArrayList<AuthorityHaving>();

		HttpSession session = request.getSession();

		try {

			//ユーザーIDをJSPから受け取る
			String strUserId = request.getParameter("userId");
			//セッションからユーザーIDを取得
			myUserId = (Integer) session.getAttribute("user_id");

			//ユーザーIDがなければ
			if (strUserId == null) {
				//ログインしたユーザーの情報を取得
				user = userDAO.selectByUserId(myUserId);
			} else {
				userId = Integer.parseInt(strUserId);
				//ユーザーIDで該当のユーザー情報を取得
				user = userDAO.selectByUserId(userId);
			}

			//権限の名称を取得
			authorityList = authorityDAO.selectAllAuthority();
			//ユーザーの持っている権限を取得
			authorityHavingList = authorityDAO.selectByUserId(myUserId);

			request.setAttribute("user", user);
			request.setAttribute("authority_list", authorityList);
			request.setAttribute("authority_having_list", authorityHavingList);

		} catch (IllegalStateException e) {
			error = true;
			cmd = "logout";
			message = "システムの一時的な問題により、個人情報の読み込みができませんでした。";
		} catch (Exception e) {
			error = true;
			cmd = "logout";
			message = "予期せぬエラーが発生しました。" + e;
		} finally {

			if (error) {
				// 例外が発生する場合エラー文をリクエストスコープに"error"という名前で格納する
				request.setAttribute("message", message);
				// error.jspにフォワード
				path = "/view/error.jsp";
			}

			request.setAttribute("cmd", cmd);
			// pathにフォワード
			request.getRequestDispatcher(path).forward(request, response);
		}
	}

}