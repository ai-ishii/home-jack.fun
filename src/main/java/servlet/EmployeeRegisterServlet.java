//<!-- 社員紹介 登録機能（作：石井） -->
//<!-- 作成日：7/17　最終更新日：8/12 14:00 -->

package servlet;

import java.io.File;
import java.io.IOException;

import bean.Account;
import bean.Employee;
import bean.User;
import dao.AccountDAO;
import dao.EmployeeDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/employeeRegister")
public class EmployeeRegisterServlet extends HttpServlet {

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

		// 変数宣言
		String error = "";
		String cmd = "";

		// オブジェクト生成
		EmployeeDAO employeeDAO = new EmployeeDAO();
		UserDAO userDAO = new UserDAO();

		HttpSession session = request.getSession();
		try {
			// 1. セッションから情報を取り出す
			Employee employeeRegister = (Employee) session.getAttribute("employeeConfirm");
			String tempFilePath = (String) session.getAttribute("tempFilePath");
			User userRegister = (User) session.getAttribute("userConfirm");

			// 2. もし一時ファイルが存在すれば、正式な場所に移動する
			if (tempFilePath != null && employeeRegister.getPhoto() != null) {
				File tempFile = new File(tempFilePath);
				if (tempFile.exists()) {
					String finalDir = getServletContext().getRealPath("/file");
					File finalDirFile = new File(finalDir);
					if (!finalDirFile.exists()) {
						finalDirFile.mkdirs();
					}
					String finalFilePath = finalDir + File.separator + employeeRegister.getPhoto();

					// ファイルを移動 (renameToは移動としても機能します)
					tempFile.renameTo(new File(finalFilePath));
				}
			}

			AccountDAO accountDAO = new AccountDAO();
			Account account = new Account();

			AccountDAO.insert();

			userDAO.insert(userRegister);

			int newUserId = userDAO.selectLastInsertId();

			// 3. DAOを呼び出してDBに登録
			int sessionUserId = (int) session.getAttribute("user_id");
			employeeDAO.regist(employeeRegister, newUserId);
			//    userDAO.regist(userRegister,sessionUserId);

		} catch (Exception e) {
			cmd = "";
			error = "予期せぬエラーが発生しました。" + e;
		} finally {
			// エラーがあれば
			if (error != "") {
				request.setAttribute("cmd", cmd);
				request.setAttribute("error", error);
				request.getRequestDispatcher("/view/error.jsp").forward(request, response);
			} else { // エラーがなければ
				// 社員紹介一覧画面に遷移する
				request.getRequestDispatcher("/employee").forward(request, response);
			}
		}

	}

}
