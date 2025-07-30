/**
 * JackWorks登録機能
 * 
 * 作成者：青木美波
 * 
 * 作成日 2025/07/08
 */

package servlet;

import java.io.IOException;
import java.sql.Date;

import bean.Jackworks;
import dao.JackworksDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.MyFormat;

@WebServlet("/jackworksRegister")
public class JackworksRegisterServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// エラー文を格納用
		String error = null;
		// 例外判定用
		String cmd = null;
		// 遷移先のパス
		String path = "/homejack_renewal/monthJackworks";

		//オブジェクト生成
		JackworksDAO jackworksDAO = new JackworksDAO();
		Jackworks jack = new Jackworks();
		HttpSession session = request.getSession();
		MyFormat format = new MyFormat();

		try {

			cmd = request.getParameter("cmd");

			String category = request.getParameter("category");

			if (cmd.equals("next")) {

				//registerJackworks.jspから各値を受け取り、オブジェクトに格納
				jack.setEmployeeNumber(request.getParameter("employeeNumber"));
				String date = request.getParameter("date");
				Date pointDate = java.sql.Date.valueOf(format.forRegisterDate(date));
				jack.setPointsGetDate(pointDate);
				jack.setName(request.getParameter("name"));
				jack.setCategory(category);
				jack.setAssessment(request.getParameter("assessment"));
				int point = Integer.parseInt(request.getParameter("point"));
				jack.setPoint(point);
				jack.setNote(request.getParameter("note"));

				session.setAttribute("jack", jack);

				if (!category.equals("案件情報収集")) {
					//jack.setTemporaryFlag(1);
					jackworksDAO.insert(jack);
					return;
				}
				path = "/view/jackworksRegister.jsp";
				return;
			}

			jack = (Jackworks) session.getAttribute("jack");

			//registerJackworks.jspから各値を受け取り、オブジェクトに格納
			jack.setProject(request.getParameter("project"));
			jack.setWorkSeason(request.getParameter("workSeason"));
			String price = request.getParameter("price");
			if (!price.equals("")) {
				jack.setPrice(Integer.parseInt(price));
			}
			String pay = request.getParameter("pay");
			if (!pay.equals("")) {
				jack.setPay(Integer.parseInt(pay));
			}
			jack.setWorkPlace(request.getParameter("workPlace"));
			jack.setWorkContent(request.getParameter("workContent"));
			jack.setPhase(request.getParameter("phase"));
			jack.setLanguage(request.getParameter("language"));
			jack.setSkill(request.getParameter("skill"));
			jack.setNeedPeople(request.getParameter("needPeople"));
			jack.setSeller(request.getParameter("seller"));
			jack.setContact(request.getParameter("contact"));
			jack.setOther(request.getParameter("other"));

			jackworksDAO.insert(jack);
			session.invalidate();

		} catch (IllegalStateException e) {
			error = "DB接続エラーのため、JackWorksの登録は表示できませんでした。";
			cmd = "home";
		} catch (Exception e) {
			error = "予期せぬエラーが発生しました。" + e;
			cmd = "logout";
		} finally {
			if (error != null) {
				// 例外を発生する場合エラー文をリクエストスコープに"error"という名前で格納する
				request.setAttribute("error", error);
				// error.jspにフォワード
				path = "/view/error.jsp";
			}
			// 例外を発生する場合エラー種類をリクエストスコープに"cmdという名前で格納する
			request.setAttribute("cmd", cmd);
			
			if(path.equals("/homejack_renewal/monthJackworks")) {
			response.sendRedirect(path);
			// jackWorks.jspにフォワード
			}else {
			request.getRequestDispatcher(path).forward(request, response);
			}
		}
	}

}
