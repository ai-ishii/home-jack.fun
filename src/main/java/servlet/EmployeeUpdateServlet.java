//<!-- 社員紹介 変更機能（作：石井） -->
//<!-- 作成日：7/18　最終更新日：7/29 11:45 -->

package servlet;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;

import bean.Employee;
import bean.User;
import dao.EmployeeDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/employeeUpdate")
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
			UserDAO userDAO = new UserDAO();
			EmployeeDAO employeeDAO = new EmployeeDAO();
			User user = new User();
			Employee employee = new Employee();
			
			// 入力された情報をJSPから取得
			String photo = request.getParameter("photo");
//			String employeeNumber = request.getParameter("employeeNumber");
//			String name = request.getParameter("name");
//			String nameKana = request.getParameter("nameKana");
//			
			// String→Dateに変換
//			String dateString = request.getParameter("birthday");
//			String pattern = "yyyy-MM-dd";
//			SimpleDateFormat format = new SimpleDateFormat(pattern);
//			Date birthdayUtil = null;
//			birthdayUtil = format.parse(dateString);
//			java.sql.Date birthday = new java.sql.Date(birthdayUtil.getTime());
//			
//			int department = Integer.parseInt(request.getParameter("department"));
//			int group = Integer.parseInt(request.getParameter("group"));
//			
			// String→Timestampに変換
//			String timeString = request.getParameter("joiningDate");
//			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM");
//			Date parsedTime = dateFormat.parse(timeString);
//			Timestamp joiningDate = new Timestamp(parsedTime.getTime());
			
			// セッションからユーザー情報を取得
			HttpSession session = request.getSession();
			int userId = (int)session.getAttribute("user_id");
			
			user = userDAO.selectByUserId(userId);
			
			int devloper = Integer.parseInt(request.getParameter("devloper"));
			String langSkill = request.getParameter("langSkill");
			String middleSkill = request.getParameter("middleSkill");
			String hobby = request.getParameter("hobby");
			String talent = request.getParameter("talent");
			String intro = request.getParameter("intro");
			String position = request.getParameter("position");
			
			String employeeNumber = user.getEmployeeNumber();
			String name = user.getName();
			String nameKana = user.getNameKana();
			Date birthday = user.getBirthday();
			int department = user.getDepartmentId();
			int group = user.getGroupId();
			Timestamp joiningDate = user.getJoiningDate();
			employee.setPhoto(photo);
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
