/*
 * 機能：修正ボタンが押されたときに入力内容を確認する機能
 * 
 * 作成者：桑原岳
 * 
 * 最終更新日：2025/08/22
 * 
 * */

package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

	@WebServlet("/licenseRetouching")
	public class LicenseRetouchingServlet extends HttpServlet {

		protected void doPost(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
			
			// 1. 文字コードを設定
			request.setCharacterEncoding("UTF-8");

			 // フォームから全データを受け取る
	        String name = request.getParameter("name");
	        String department = request.getParameter("department");
	        String group = request.getParameter("group");
	        String license = request.getParameter("license");
	        String examDate = request.getParameter("exam-date");
	        String examTime = request.getParameter("exam-time");
	        String receiptTempFileName = request.getParameter("receiptTempFileName");
	        String passingTempFileName = request.getParameter("passingTempFileName");
			
			// 3. 受け取ったデータを「リクエストスコープ」に格納する
			//    こうすることで、次のJSPでこの値を表示できる
	     // requestスコープにデータをセット
	        request.setAttribute("name", name);
	        request.setAttribute("department", department);
	        request.setAttribute("group", group);
	        request.setAttribute("license", license);
	        request.setAttribute("examDate", examDate);
	        request.setAttribute("examTime", examTime);
	        request.setAttribute("receiptTempFileName", receiptTempFileName);
	        request.setAttribute("passingTempFileName", passingTempFileName);
			// 4. 確認画面JSPに処理を引き継ぐ（フォワード）
			getServletContext().getRequestDispatcher("/view/licenseForm.jsp").forward(request, response);
		}
	}
