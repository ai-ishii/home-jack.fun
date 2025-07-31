package servlet;

import java.io.IOException;

import dao.EmployeeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/employeeDelete")
public class EmployeeDeleteServlet extends HttpServlet {
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			
			// 変数宣言
			String error = "";
			String cmd = "";
			
			try {
			// オブジェクト生成
			EmployeeDAO employeeDAO = new EmployeeDAO();
			
			// JSPから情報を取得
			int userId = Integer.parseInt(request.getParameter("userId"));
			
			// メソッドからSQL実行
			employeeDAO.delete(userId);
			
			} catch(IllegalStateException e) {
				cmd = "";
				error = "DB接続エラーのため、社員詳細は表示できませんでした。";
			} catch (Exception e) {
				cmd = "";
				error = "予期せぬエラーが発生しました。" + e;
			} finally {
				// エラーが空じゃなければ（エラーがあれば）
				if (error != "") {
					request.setAttribute("cmd", cmd);
					request.setAttribute("error", error);
					request.getRequestDispatcher("/view/error.jsp").forward(request, response);
				} else {	// エラーがなければ
					// 社員一覧画面に遷移する
					request.getRequestDispatcher("/employee").forward(request, response);
				}
			}
			
		}

}