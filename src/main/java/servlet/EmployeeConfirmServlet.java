//<!-- 社員紹介 確認画面など画面遷移のための機能（作：石井） -->
//<!-- 作成日：7/30　最終更新日：8/22 14:00 -->

package servlet;

import java.io.IOException;

import bean.Employee;
import bean.User;
import dao.EmployeeDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/employeeConfirm")
@MultipartConfig
public class EmployeeConfirmServlet extends HttpServlet {

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

		String error = "";
		String cmd = "";

		// セッション情報を取得
		// HttpSession session = request.getSession();

		// オブジェクト宣言
		User user = new User();
		Employee employee = new Employee();
		UserDAO userDAO = new UserDAO();
		EmployeeDAO employeeDAO = new EmployeeDAO();

		int userId = 0;
		String strUserId = "";

		try {
			
			// URLからパラメータを取得
			strUserId = request.getParameter("user_id");
			
			// パラメータが存在した場合、int型に変換する
			if (strUserId != null) {
				userId = Integer.parseInt(strUserId);
			} else {
				// エラー処理してね！
				return;
			}
			
			// パラメータをもとに社員情報を取得する
			user = userDAO.selectByUserId(userId);
			employee = employeeDAO.selectByUserId(userId);
			
			cmd = "update";
			
			// リクエストスコープに保存、画面遷移
			request.setAttribute("user", user);
			request.setAttribute("employee", employee);

		} catch (Exception e) {
			e.printStackTrace();
			error = "予期せぬエラーが発生しました。入力内容を確認してください。";
			request.setAttribute("error", error);
			request.getRequestDispatcher("/view/error.jsp").forward(request, response);
		} finally {
			
			request.setAttribute("cmd", cmd);
			request.getRequestDispatcher("/view/employeeUpdate.jsp").forward(request, response);

		}
		
	}

}
