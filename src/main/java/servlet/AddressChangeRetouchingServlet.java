/*
 * 機能：修正ボタンが押されたときに入力内容を確認する機能
 * 
 * 作成者：桑原岳
 * 
 * 最終更新日：2025/08/14
 * 
 * */

package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

	@WebServlet("/addressChangeRetouching")
	public class AddressChangeRetouchingServlet extends HttpServlet {

		protected void doPost(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
			
			// 1. 文字コードを設定
			request.setCharacterEncoding("UTF-8");

			// 2. フォームから送られてきたデータを全て受け取る
			String employeeNumber = request.getParameter("employeenumber");
			String name = request.getParameter("name");
			String addressChangedDate = request.getParameter("addressChangedDate");
			String oldPost = request.getParameter("oldpost");
			String oldAddress = request.getParameter("oldaddress");
			String newPost = request.getParameter("newpost");
			String newAddress = request.getParameter("newaddress");
			String nearestStation = request.getParameter("neareststation");
			
			// 3. 受け取ったデータを「リクエストスコープ」に格納する
			//    こうすることで、次のJSPでこの値を表示できる
			request.setAttribute("employeeNumber", employeeNumber);
			request.setAttribute("name", name);
			request.setAttribute("addressChangedDate", addressChangedDate);
			request.setAttribute("oldPost", oldPost);
			request.setAttribute("oldAddress", oldAddress);
			request.setAttribute("newPost", newPost);
			request.setAttribute("newAddress", newAddress);
			request.setAttribute("nearestStation", nearestStation);

			// 4. 確認画面JSPに処理を引き継ぐ（フォワード）
			getServletContext().getRequestDispatcher("/view/addressChangeForm.jsp").forward(request, response);
		}
	}
