/*
 * 資格状況一覧　サーブレット
 * 7/14
 * 川上
 * 
 * 更新者：大北直弥
 * 
 * 更新日：8/26
 * 
 */

package servlet;

import java.io.IOException;
import java.util.ArrayList;

import bean.CategoryMap;
import bean.LicenseRequest;
import bean.Request;
import dao.RequestDAO;
import dao.RequestLicenseDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.CommonMethod;

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
		
		CommonMethod commonMethod = new CommonMethod();
		
		//配列宣言
		ArrayList<Request> requestList = new ArrayList<Request>();
		ArrayList<LicenseRequest> licenseRequestList = new ArrayList<LicenseRequest>();
		
		ArrayList<CategoryMap> departmentList = new ArrayList<CategoryMap>();
		ArrayList<CategoryMap> groupList = new ArrayList<CategoryMap>();
		ArrayList<CategoryMap> licenseList = new ArrayList<CategoryMap>();

		try {

			//全データ呼び出し
			requestList = requestDAO.selectLicenseListByFlag(requestFlag);
			licenseRequestList = requestLicenseDAO.selectLicenseListByFlag(requestFlag);
			
			departmentList = commonMethod.selectDepartment();
			groupList = commonMethod.selectGroup();
			licenseList = commonMethod.selectLicense();
			
			//リクエストスコープに登録
			request.setAttribute("request_list", requestList);
			request.setAttribute("licenseRequest_list", licenseRequestList);
			
			request.setAttribute("department_list", departmentList);
			request.setAttribute("group_list", groupList);
			request.setAttribute("license_list", licenseList);
			
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