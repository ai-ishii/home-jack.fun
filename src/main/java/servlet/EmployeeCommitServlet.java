/*
 * 社員紹介情報の更新を確定させるサーブレット
 * 
 * 作成者：大北直弥
 * 
 * 作成日：8/22
 * 更新日：8/22
 */
package servlet;

import java.io.IOException;

import dao.EmployeeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/employeeCommit")
public class EmployeeCommitServlet extends HttpServlet {
	
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
		
		int userId = 0;

		EmployeeDAO employeeDAO = new EmployeeDAO();
		
		String strUserId = request.getParameter("user_id");
//		String confirm = request.getParameter("confirm");
//		String complete = request.getParameter("complete");
		String submit = request.getParameter("confirm");
		
		try {
			
			// フォームから受け取ったパラメータをint型に変換する
			userId = Integer.parseInt(strUserId);
			
			if (submit.equals("完了")) {
				// 仮テーブルに保存していたデータを本テーブルに移動させる処理
				employeeDAO.update(userId);
			}
			
			// 仮テーブルに保存されていたデータを削除する処理
			employeeDAO.delete(userId);
			
		} catch (Exception e) {
			cmd = "";
			error = "予期せぬエラーが発生しました。" + e;
		} finally {
			request.setAttribute("cmd", cmd);
			// エラーが空じゃなければ（エラーがあれば）
			if (error != "") {
				request.setAttribute("error", error);
				request.getRequestDispatcher("/view/error.jsp").forward(request, response);
			} else { // エラーがなければ
				
				if (submit.equals("完了")) {
					// 社員紹介一覧画面に遷移する
					request.getRequestDispatcher("/employee").forward(request, response);
				}
				
				if (submit.equals("BACK")) {
					request.setAttribute("userId", userId);
					request.getRequestDispatcher("/employeeDetail?work=update").forward(request, response);
				}
			}
		}
	}

}
