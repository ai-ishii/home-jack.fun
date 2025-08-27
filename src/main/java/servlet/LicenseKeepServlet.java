/*
 * 機能:確定ボタンを押したときに確定情報をDBに登録する機能
 * 作成者：桑原岳
 * 最終更新日：2025/08/27
 */
package servlet;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;

import bean.LicenseRequestExclusive;
import dao.RequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/licenseKeep")
public class LicenseKeepServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		RequestDAO requestDAO = new RequestDAO();

		int applicantId = (int) session.getAttribute("user_id");

		String name = request.getParameter("name");
		
		String strRequestId = request.getParameter("requestId");
		int requestId = Integer.parseInt(strRequestId);
		
		// オブジェクト化
		LicenseRequestExclusive licenseRequestExclusive = new LicenseRequestExclusive();

		// 現在時刻を取得し、licenseRequestExclusiveにセットする
		LocalDateTime nowDate = LocalDateTime.now();
		LocalDate localDate = nowDate.toLocalDate();
		
		//request_infoにuser_idとnameを登録してrequest_idを発行する
		int licenseRequestId = requestDAO.insertApplicantId(applicantId,name,localDate);
		
		// license_request_test_infoからrequestIdと一致する情報を取り出す
		licenseRequestExclusive = requestDAO.selectRequestTestInfo(requestId);
		
		// licenseRequestExclusiveにlicenseRequestIdを加える
		licenseRequestExclusive.setRequestId(licenseRequestId);
		
		// license_request_test_infoから取り出した情報をlicense_request_infoに登録する
		boolean success = requestDAO.insertLicenseInfo(licenseRequestExclusive);
		
		// 仮登録した情報を全削除する
		requestDAO.deleteLicenseRequestTest();
		requestDAO.deleteLicenseRequest(applicantId);
		
		// エラーがなければ完了画面に、エラーがあればエラー画面に遷移する
		if (success) {
			request.getRequestDispatcher("/view/licenseCompletion.jsp").forward(request, response);
		}else {
			request.getRequestDispatcher("/view/error.jsp").forward(request, response);
		}
	}
}