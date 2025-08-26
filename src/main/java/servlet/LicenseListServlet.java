/*
 * 資格状況一覧　サーブレット
 * 7/14
 * 川上
 * 
 */

package servlet;

import java.io.IOException;
import java.util.ArrayList;

import bean.LicenseRequest;
import bean.Request;
import dao.RequestDAO;
import dao.RequestLicenseDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/licenseList")
public class LicenseListServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String error = "";
		String cmd = "";
		
		// 検索するフラグを１（承認済みの申請）にする
		int requestFlag = 1;
		
		// オブジェクト宣言
		RequestDAO requestDAO = new RequestDAO();
		RequestLicenseDAO requestLicenseDAO = new RequestLicenseDAO();
		
		//配列宣言
		ArrayList<Request> requestList = new ArrayList<Request>();
		ArrayList<LicenseRequest> licenseRequestList = new ArrayList<LicenseRequest>();

		try {

			//全データ呼び出し
			requestList = requestDAO.selectLicenseListByFlag(requestFlag);
			licenseRequestList = requestLicenseDAO.selectLicenseListByFlag(requestFlag);
			
			//リクエストスコープに登録
			request.setAttribute("requestList", requestList);
			request.setAttribute("licenseRequestList", licenseRequestList);

		} catch (IllegalStateException e) {
			error = "DB接続エラーの為、一覧表示は出来ませんでした";
			cmd ="";
		} catch (Exception e) {
			error = "予期せぬエラーが発生しました。<br>" + e;
			cmd="";
		} finally {
			if (!error.equals("")) {
				request.setAttribute("error", error);
				request.setAttribute("cmd", cmd);
				request.getRequestDispatcher("/view/error.jsp").forward(request, response);

			} else {
				request.getRequestDispatcher("/view/licenseList.jsp").forward(request, response);

			}

		}

	}

}