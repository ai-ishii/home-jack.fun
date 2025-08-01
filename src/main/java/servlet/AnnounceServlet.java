
/**
 * お知らせを一覧表示するサーブレット
 * 
 * 作成者 : 大北直弥
 * 
 * 作成日 : 2025/07/14
 * 更新日 : 2025/08/01
 */
package servlet;

import java.io.IOException;
import java.util.ArrayList;

import bean.Announce;
import bean.CategoryMap;
import dao.AnnounceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/announce")
public class AnnounceServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 共通処理メソッドの呼び出し
		commonProcess(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 共通処理メソッドの呼び出し
		commonProcess(request, response);
	}

	private void commonProcess(HttpServletRequest request,
			HttpServletResponse response)
			throws ServletException, IOException {

		// 変数宣言
		String error = "";
		String cmd = "";

		// オブジェクト生成
		AnnounceDAO announceDAO = new AnnounceDAO();
		ArrayList<Announce> announceList = new ArrayList<Announce>();
		ArrayList<CategoryMap> categoryList = new ArrayList<CategoryMap>();

		try {

			// メソッドを呼び出してSQL文実行
			announceList = announceDAO.selectAll();
			categoryList = announceDAO.selectCategoryAll();
			
		} catch (Exception e) {
			cmd = "";
			error = "予期せぬエラーが発生しました。" + e;
		} finally {
			if (error != "") {
				request.setAttribute("cmd", cmd);
				request.setAttribute("error", error);
				request.getRequestDispatcher("").forward(request, response);
			} else {
				request.setAttribute("announceList", announceList);
				request.setAttribute("categoryList", categoryList);
				request.getRequestDispatcher("/view/announce.jsp").forward(request, response);
			}
		}
	}

}
