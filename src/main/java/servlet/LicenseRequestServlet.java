/* 
 * 機能：資格申請一覧機能
 * 
 * 作成者：桑原岳
 * 
 * 最終更新日：2025/08/01
 * 
 */



package servlet;

import java.io.IOException;
import java.util.ArrayList;

import bean.LicenseRequestExclusive;
import dao.RequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/licenseRequest")
public class LicenseRequestServlet extends HttpServlet {

	//doGetメソッド
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String error = null;
		String cmd = null;

		try {
			//オブジェクト化
			RequestDAO requestDAO = new RequestDAO();
			ArrayList<LicenseRequestExclusive> licenseRequestExclusiveList = requestDAO.selectAllLicense();

			request.setAttribute("licenseRequestExclusiveList", licenseRequestExclusiveList);

			//DB接続エラー	
		} catch (IllegalStateException e) {
			error = "DB接続エラーの為、JackWorks検索結果は表示できませんでした。";
			cmd = "dbError";
		} catch (Exception e) {
			error = "予期せぬエラーが発生しました。" + e;
			cmd = "logout";
		}
		//エラーがない場合は、licenseRequest.jspに遷移する
		if (error == null) {

			request.getRequestDispatcher("/view/licenseRequest.jsp").forward(request, response);
			//エラーがある場合はerror.jspに遷移する
		} else {
			request.setAttribute("error", error);
			request.setAttribute("cmd", cmd);
			request.getRequestDispatcher("/view/Error.jsp").forward(request, response);
		}

	}
}