package servlet;

import java.io.IOException;
import java.util.ArrayList;

import bean.LicenseList;
import dao.LicenseListDAO;
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
			//パラメータの取得
			String id = request.getParameter("id");

			ArrayList<LicenseList> list = new ArrayList<LicenseList>();
			//オブジェクト宣言
			LicenseListDAO objDao = new LicenseListDAO();
			//検索結果をlistに格納
			list = objDao.selectAll();

			//リクエストスコープに登録
			request.setAttribute("list", list);

		} catch (IllegalStateException e) {
			error = "DB接続エラーの為、一覧表示は出来ませんでした";

		} catch (Exception e) {
			error = "予期せぬエラーが発生しました。<br>" + e;
		} finally {
			if (error != null) {
				request.setAttribute("error", error);
				request.setAttribute("cmd", cmd);
				request.getRequestDispatcher("/view/error.jsp").forward(request, response);

			} else {
				request.setAttribute("error", error);
				request.getRequestDispatcher("/view/licenseList.jsp").forward(request, response);

			}

		}

	}

}
