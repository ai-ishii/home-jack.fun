//<!-- 社員紹介 変更機能（作：石井） -->
//<!-- 作成日：7/18　最終更新日：8/1 12:00 -->

/*
 * 更新を促す（開発経験年数）年一に更新
 */

package servlet;

import java.io.IOException;

import bean.Employee;
import dao.EmployeeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/employeeUpdate")
@MultipartConfig
public class EmployeeUpdateServlet extends HttpServlet {
	
	public void doGet (HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		commonProcess(request, response);
	}
	
	public void doPost (HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		commonProcess(request, response);
	}
		
	private void commonProcess (HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		// 変数宣言
		String error = "";
		String cmd = "";
		
		try {
			
			// オブジェクト生成
			EmployeeDAO employeeDAO = new EmployeeDAO();
			Employee employee = new Employee();
			
//			// 入力された情報をJSPから取得
//			String photo = request.getParameter("photo");
			// ファイル取得用の情報を受け取る
//			Part filePart = request.getPart("photo");
			
			// セッションからユーザー情報を取得
			HttpSession session = request.getSession();
			int userId = (int)session.getAttribute("user_id");
			
			int devloper = Integer.parseInt(request.getParameter("devloper"));
			String langSkill = request.getParameter("langSkill");
			String middleSkill = request.getParameter("middleSkill");
			String hobby = request.getParameter("hobby");
			String talent = request.getParameter("talent");
			String intro = request.getParameter("intro");
			String position = request.getParameter("position");
			
//			employee.setPhoto(photo);
			employee.setDevloper(devloper);
			employee.setLangSkill(langSkill);
			employee.setMiddleSkill(middleSkill);
			employee.setHobby(hobby);
			employee.setTalent(talent);
			employee.setIntro(intro);
			employee.setPosition(position);
			employee.setRegistDate(null);
			employee.setUpdateDate(null);
			
			// メソッドからSQL実行
			employeeDAO.update(employee, userId);
			
		} catch (Exception e) {
			cmd = "";
			error = "予期せぬエラーが発生しました。" + e;
		} finally {
			// エラーが空じゃなければ（エラーがあれば）
			if (error != "") {
				request.setAttribute("cmd", cmd);
				request.setAttribute("error", error);
				request.getRequestDispatcher("/view/error.jsp").forward(request, response);
			} else {	// エラーがなければ
				// 社員紹介一覧画面に遷移する
				request.getRequestDispatcher("/employee").forward(request, response);
			}
		}
		
	}

}
