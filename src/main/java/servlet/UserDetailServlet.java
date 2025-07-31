/*
 * プログラム名：Home-Jack.ver.2.0
 * 				 個人情報詳細を取得する処理
 * 作成者：占部虎司郎
 * 作成日：2025/7/11
 * 更新日：2025/7/25
 */

package servlet;

import java.io.IOException;

import bean.User;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/userDetail")
public class UserDetailServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		// エラー文を格納用
		String error = "";
		// 例外判定用
		String cmd = "";
		// 遷移先のパス
		String path = "/view/userDetail.jsp";
		
		try {
			//cmdの取得(削除か詳細表示か判断する用)
			cmd = (String)request.getParameter("cmd");
			
			if(cmd == null) {
				cmd = "";
			}
			
			// パラメータの取得
			int userId = Integer.parseInt(request.getParameter("userId"));
			
			// DAOオブジェクトの宣言
			UserDAO userDAO = new UserDAO();
			
			//削除の場合は疑似削除メソッドを実行
			if(cmd.equals("delete")) {
				userDAO.delete(userId);
				//遷移先を一覧に変更
				path = "/userList";
				return;
			}

			// 詳細取得メソッドを呼び出し
			User user = userDAO.selectByUserId(userId);

			// 取得した情報をリクエストスコープに登録
			request.setAttribute("user", user);
			
			} catch (IllegalStateException e) {
				error = "DB接続エラーのため、個人情報詳細は表示できませんでした。";
				cmd = "logout";
			} catch (Exception e) {
				error = "予期せぬエラーが発生しました。" + e;
				cmd = "logout";
			} finally {
				if (error != "") {
					// 例外を発生する場合エラー文をリクエストスコープに"error"という名前で格納する
					request.setAttribute("error", error);
					// 例外を発生する場合エラー種類をリクエストスコープに"cmdという名前で格納する
					request.setAttribute("cmd", cmd);
					// error.jspにフォワード
					path = "/view/error.jsp";
				}
					// pathにフォワード
					request.getRequestDispatcher(path).forward(request, response);
			}
	}
}
