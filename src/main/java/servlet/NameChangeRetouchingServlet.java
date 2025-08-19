/*
 * 機能：修正ボタンが押されたときに入力内容を確認する機能
 * 
 * 作成者：桑原岳
 * 
 * 最終更新日：2025/08/19
 * 
 * */

package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

	@WebServlet("/nameChangeRetouching")
	public class NameChangeRetouchingServlet extends HttpServlet {

		protected void doPost(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
			
			// 1. 文字コードを設定
			request.setCharacterEncoding("UTF-8");

			// 2. フォームから送られてきたデータを全て受け取る
			String oldName = request.getParameter("oldname");
			String oldNameKana = request.getParameter("oldnamekana");
			String newName = request.getParameter("newname");
			String newNameKana = request.getParameter("newnamekana");
			
			// 3. 受け取ったデータを「リクエストスコープ」に格納する
			//    こうすることで、次のJSPでこの値を表示できる
			request.setAttribute("oldName", oldName);
			request.setAttribute("oldNameKana", oldNameKana);
			request.setAttribute("newName", newName);
			request.setAttribute("newNameKana", newNameKana);
			// 4. 確認画面JSPに処理を引き継ぐ（フォワード）
			getServletContext().getRequestDispatcher("/view/nameChangeForm.jsp").forward(request, response);
		}
	}

