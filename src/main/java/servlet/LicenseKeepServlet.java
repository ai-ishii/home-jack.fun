/*
 * 機能：資格申請の内容を保存する機能
 * 
 * 作成者：桑原岳
 * 
 * 最終更新日：2025/08/18
 * 
 * */

package servlet;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

import bean.LicenseRequest;
import dao.RequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/licenseKeep")
public class LicenseKeepServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 1. 文字コードを設定
		request.setCharacterEncoding("UTF-8");

		// 2. フォームから送られてきたデータを全て受け取る
		String name = request.getParameter("name");
		String department = request.getParameter("department");
		String group = request.getParameter("group");
		String license = request.getParameter("license");
		String strExamDate = request.getParameter("exam-date");
		String strExamTime = request.getParameter("exam-time");
		Part receiptPart = request.getPart("receipt");
		Part passingPart = request.getPart("passing");

		// --- 受験日 (String) を LocalDate に変換 ---
		LocalDate examDate = null;
		try {
		    // 文字列 "2025-08-18" を LocalDate オブジェクトに変換するだけ
		    examDate = LocalDate.parse(strExamDate);
		    
		} catch (DateTimeParseException e) {
		    // 日付の形式が正しくない場合のエラーハンドリング
		    e.printStackTrace();
		    // (例: エラーメッセージをセットしてフォームに戻す)
		}


		// --- 受験回数 (String) を int に変換 ---
		int examTime = 0; // エラー時のデフォルト値
		try {
		    examTime = Integer.parseInt(strExamTime);
		} catch (NumberFormatException e) {
		    // 数値の形式が正しくない場合のエラーハンドリング
		    e.printStackTrace();
		    // (例: エラーメッセージをセットしてフォームに戻す)
		}

		// 3.送られてきたデータをセットする
		LicenseRequest licenseRequest = new LicenseRequest();
		licenseRequest.setApplicant(name);
		licenseRequest.setDepartmentName(department);
		licenseRequest.setGroupName(group);
		licenseRequest.setLicenseName(license);
		licenseRequest.setExamDate(examDate);
		licenseRequest.setExamTime(examTime);
		licenseRequest.setReceipt(receiptPart);
		licenseRequest.setPassing(passingPart);

		// 4.RequestDAO をオブジェクト化し、 insertNameChangeメソッドを利用して
		//   データをDBに登録する
		RequestDAO requestDAO = new RequestDAO();
		boolean success = requestDAO.insertLicenseRequest(licenseRequest);

		// 5.確認画面JSPに処理を引き継ぐ（フォワード）
		if (success) {
			request.setAttribute("licenseRequest", licenseRequest);
			getServletContext().getRequestDispatcher("/view/licenseCompletion.jsp").forward(request, response);
		} else {
			getServletContext().getRequestDispatcher("/view/error.jsp").forward(request, response);
		}
	}
}
