/**
 * JackWorks登録機能
 * 
 * 作成者：青木美波
 * 
 * 作成日 2025/07/08
 */

package servlet;

import java.io.IOException;

import bean.Jackworks;
import dao.JackWorksDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/registerJackWorks")
public class RegisterJackWorksServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// エラー文を格納用
		String error = null;
		// 例外判定用
		String cmd = null;
		// 遷移先のパス
		String path = "/monthJackWorks";

		//オブジェクト生成
		JackWorksDAO jackworksDAO = new JackWorksDAO();
		Jackworks jack = new Jackworks();

		try {					
			//JSPから各値を受け取り、オブジェクトに格納
			 int employeeNumber = Integer.parseInt(request.getParameter("employeeNumber"));
			 jack.setEmployeeNumber(employeeNumber);
			 jack.setName(request.getParameter("name"));
			 jack.setCategory(request.getParameter("category"));
			 jack.setAssessment(request.getParameter("assessment"));
			 int point = Integer.parseInt(request.getParameter("point"));
			 jack.setPoint(point);
			 jack.setNote(request.getParameter("note"));
			 jack.setProject(request.getParameter("project"));
			 jack.setWorkSeason(request.getParameter("workSeason"));
			 int price = Integer.parseInt(request.getParameter("price"));	
			 jack.setPrice(price);
			 int pay = Integer.parseInt(request.getParameter("pay"));	
			 jack.setPay(pay);	
			 jack.setWorkPlace(request.getParameter("workPlace"));
			 jack.setWorkContent(request.getParameter("workContent"));		
			 jack.setPhase(request.getParameter("phase"));
			 jack.setLanguage(request.getParameter("language"));			
			 jack.setSkill(request.getParameter("skill"));
			 int needPeople = Integer.parseInt(request.getParameter("needPeople"));
			 jack.setNeedPeople(needPeople);
			 jack.setSeller(request.getParameter("seller"));
			 jack.setContact(request.getParameter("contact"));
			 jack.setOther(request.getParameter("other"));
			
			 jackworksDAO.insert(jack);

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
				// 例外を発生する場合エラー種類をリクエストスコープに"cmdという名前で格納する
				request.setAttribute("cmd", cmd);
				// error.jspにフォワード
				path = "/view/error.jsp";
			}
			// jackWorks.jspにフォワード
			request.getRequestDispatcher(path).forward(request, response);
		}
	}

}
