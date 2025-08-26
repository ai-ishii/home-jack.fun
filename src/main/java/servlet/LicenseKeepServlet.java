/*
 * 機能:確定ボタンを押したときに確定情報をDBに登録する機能
 * 作成者：桑原岳
 * 最終更新日：2025/08/22
 */
package servlet;

import java.io.IOException;

import dao.RequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/licenseKeep")
public class LicenseKeepServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		RequestDAO requestDAO = new RequestDAO();

		//  文字コードを設定
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
		String receiptFileId = request.getParameter("receiptFileId");
		String passingFileId = request.getParameter("passingFileId");
		String requestId = request.getParameter("requestId");
		

	}
}