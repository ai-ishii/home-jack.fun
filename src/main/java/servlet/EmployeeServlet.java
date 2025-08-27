//<!-- 社員紹介 一覧機能（作：石井） -->
//<!-- 作成日：7/2　最終更新日：8/26 12:00 -->

package servlet;

import java.io.IOException;
import java.util.ArrayList;

import bean.User;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/employee")
public class EmployeeServlet extends HttpServlet {

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

		// エラー用コマンド
		String error = "";
		// エラー文格納用
		String message = "";
		// 画面遷移用コマンド
		String cmd = "";
		// 遷移先のパス
		String path = "/view/employee.jsp";

		// オブジェクト生成
		UserDAO userDAO = new UserDAO();
		ArrayList<User> userList = new ArrayList<User>();

		try {
			// メソッドからSQL実行
			userList = userDAO.selectAll();

			//検索された値をnameで受け取る
			String name = request.getParameter("name");

			if (name != null && !name.isEmpty()) {
			}

			// 社員写真を格納する配列宣言
			// String[][] photos = new String[userList.size()][];
			// for (int i = 0; i < userList.size(); i++) {
			//	photos[i][i] = {employeeDAO.selectPhotoByUserId(userList.get(i).getUserId()), };
			// }

			// 取得してきたユーザー情報をjspに送るためセットする
			request.setAttribute("userList", userList);
			// request.setAttribute("photos", photos);

		} catch (IllegalStateException e) {
			message = "システムの一時的な問題により、社員紹介の読み込みができませんでした。";
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
				// error.jspにフォワード
				path = "/view/error.jsp";
			}

			if (("").equals(error)) {
				request.setAttribute("message", message);
				request.setAttribute("cmd", cmd);
			}

			request.getRequestDispatcher(path).forward(request, response);

		}
	}

}
