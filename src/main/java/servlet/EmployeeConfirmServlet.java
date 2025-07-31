//<!-- 社員紹介 確認画面など画面遷移のための機能（作：石井） -->
//<!-- 作成日：7/30　最終更新日：7/30 14:52 -->

package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/employeeConfirm")
public class EmployeeConfirmServlet extends HttpServlet {
	
	public void doGet (HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		commonProcess(request, response);
	}
	
	public void doPost (HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		commonProcess(request, response);
	}
		
	private void commonProcess (HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
	
		// 変数宣言
		String error = "";
		String cmd = "";
		String submit = "";
		int userId;
		String path = "";
		
		try {
			// 押されたボタンの種類をjspから取得
			submit = request.getParameter("submit");
			// jspから送られてきたユーザーIDを取得
			userId = Integer.parseInt(request.getParameter("userId"));

			// 登録機能
			if (submit.equals("確認画面へ")) {
				cmd = "confirm";
			} else if (submit.equals("戻る")) {
				cmd = "reRegister";
			} else if (submit.equals("完了")) {
				cmd = "register";
			}
			
			// 遷移先を分ける
			if (cmd.equals("confirm")) {	// 確認画面のとき
				path = "/view/employeeRegister.jsp?cmd=confirm";
			} else if (cmd.equals("reRegister")) {	// 登録画面に戻るとき
				path = "/view/employeeRegister.jsp?cmd=reRegister";
			} else if (cmd.equals("register") ) {	// 登録完了のとき
				path = "/employeeRegister";
			}
			
			
			// 変更機能
			if (submit.equals("確認画面へ")) {
				cmd = "confirm";
			} else if (submit.equals("戻る")) {
				cmd = "reUpdate";
			} else if (submit.equals("完了")) {
				cmd = "update";
			}
			
			// 遷移先を分ける
			if (cmd.equals("confirm")) {	// 確認画面のとき
				path = "/view/employeeUpdate.jsp?cmd=confirm&userId=" + userId;
			} else if (cmd.equals("reUpdate")) {	// 変更画面に戻るとき
				path = "/view/employeeUpdate.jsp?cmd=reUpdate&userId=" + userId;
			} else if (cmd.equals("update") ) {	// 変更完了のとき
				path = "/employeeUpdate";
			}
			
			System.out.println(path);
			
		} catch(IllegalStateException e) {
			cmd = "";
			error = "DB接続エラーのため、社員一覧は表示できませんでした。";
		} catch (Exception e) {
			cmd = "";
			error = "予期せぬエラーが発生しました。" + e;
		} finally {
			// エラーがあれば
			if (error != "") {
				request.setAttribute("cmd", cmd);
				request.setAttribute("error", error);
				request.getRequestDispatcher("/view/error.jsp").forward(request, response);
			} else {	// エラーがなければ
				// cmdで指定した画面に遷移する
				request.setAttribute("cmd", cmd);
				request.getRequestDispatcher(path).forward(request, response);
			}
		}
		
	}


}
