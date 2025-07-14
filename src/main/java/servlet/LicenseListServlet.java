/*
 * 資格状況一覧　サーブレット
 * 7/14
 * 川上
 * 
 */

package servlet;

import java.io.IOException;
import java.util.ArrayList;

import bean.LicenseList;
import dao.LicenseListDAO;
import jakarta.servlet.RequestDispatcher;
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

		try {
			//配列宣言
			ArrayList<LicenseList> list = new ArrayList<LicenseList>();

			//オブジェクト宣言
			LicenseListDAO licenseDao = new LicenseListDAO();
			//全データ呼び出し
			list = licenseDao.selectAll();
			
			//リクエストスコープに登録
			request.setAttribute("list", list);

		} catch (IllegalStateException e) {
			error = "DB接続エラーの為、一覧表示は出来ませんでした";
			cmd ="";
		} catch (Exception e) {
			error = "予期せぬエラーが発生しました。<br>" + e;
			cmd="";
		} finally {
			if (error != null) {
				request.setAttribute("error", error);
				request.setAttribute("cmd", cmd);
				request.getRequestDispatcher("/view/error.jsp").forward(request, response);

			} else {
				RequestDispatcher dispatcher = 
				request.getRequestDispatcher("/view/licenseList.jsp");dispatcher.forward(request, response);

			}

		}

	}

}
