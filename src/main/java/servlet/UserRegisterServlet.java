/**
 * 個人目標更新機能
 * 
 * 作成者：月向亮太
 * 
 * 作成日：8月18日
 * 
 * 最終更新日：8月19日
 * 
 */
package servlet;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

import bean.User;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/userRegister")
public class UserRegisterServlet extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		try {
			User user = (User) session.getAttribute("user");

			if (user == null) {
				response.sendRedirect("index.jsp");
				return;
			}

			user.setEmployeeNumber(request.getParameter("employeeNumber"));
			user.setDepartmentId(Integer.parseInt(request.getParameter("department")));
			user.setGroupId(Integer.parseInt(request.getParameter("group")));
			user.setName(request.getParameter("name"));
			user.setNameKana(request.getParameter("nameKana"));
			user.setSex(request.getParameter("sex"));
			user.setPhone(request.getParameter("phone"));
			user.setPost(request.getParameter("post"));
			user.setAddress(request.getParameter("address"));
			user.setMarriageFlag(Integer.parseInt(request.getParameter("marriage")));
			user.setWorkHistory(Integer.parseInt(request.getParameter("workyear")));
			user.setNearestStation(request.getParameter("station"));
			user.setTransportation(request.getParameter("transportation"));
			user.setQualification(request.getParameter("qualification"));

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

			String birthdayStr = request.getParameter("birthday");
			if (birthdayStr != null && !birthdayStr.isEmpty()) {
				Date utilDate = sdf.parse(birthdayStr);
				java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
				user.setBirthday(sqlDate);
			}

			String joiningDateStr = request.getParameter("joiningDate");
			if (joiningDateStr != null && !joiningDateStr.isEmpty()) {
				Date parsedDate = sdf.parse(joiningDateStr);
				Timestamp joiningDate = new Timestamp(parsedDate.getTime());
				user.setJoiningDate(joiningDate);
			}

			UserDAO userDAO = new UserDAO();
			userDAO.updateProfile(user);

			session.setAttribute("isProfileComplete", true);
			session.setAttribute("user", user);

			response.sendRedirect(request.getContextPath() + "/home");
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "登録処理中にエラーが発生しました。");
			request.getRequestDispatcher("/view/error.jsp").forward(request, response);
		}

	}
}
