package servlet;

import java.io.IOException;
import java.util.ArrayList;

import bean.Announce;
import dao.AnnounceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/index")
public class IndexServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String error = "";
		String cmd = "";
		
		// 配列の宣言
		ArrayList<Announce> importantList = new ArrayList<Announce>();
		ArrayList<Announce> announceList = new ArrayList<Announce>();
		ArrayList<Announce> activityList = new ArrayList<Announce>();
		
		// DAOの宣言
		AnnounceDAO announceDAO = new AnnounceDAO();
		
		try {
			//重要なお知らせ
			importantList = announceDAO.selectImportant();
			
			//最新のお知らせ
			announceList = announceDAO.selectNew();	
			
			//最新のチーム活動
			activityList = announceDAO.selectActivity();
			
		} catch (IllegalStateException e) {
			error = "DB接続エラーの為、一覧表示は行えませんでした。";
			cmd = "menu";
		} catch (Exception e) {
			error = "予期せぬエラーが発生しました。" + e;
			cmd = "";
		} finally {
			if (!error.equals("")) {	// エラーがある場合 error.jspにフォワード
				request.setAttribute("error", error);
				request.setAttribute("cmd", cmd);
				request.getRequestDispatcher("/view/error.jsp").forward(request, response);
			
			} else {				// エラーがない場合 index.jspにフォワード
				request.setAttribute("important_list", importantList);
				request.setAttribute("announce_list", announceList);
				request.setAttribute("activity_list", activityList);
				request.getRequestDispatcher("/view/index.jsp").forward(request, response);
			}
		}
	}
}
