/**
 * 社員情報登録機能
 * 
 * 作成者：月向亮太
 * 
 * 作成日：8月18日
 * 
 * 最終更新日：8月21日
 * 
 */
package servlet;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

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

			//電話番号の取得
			String phone1 = request.getParameter("phone1");
			String phone2 = request.getParameter("phone2");
			String phone3 = request.getParameter("phone3");
			String phone = phone1 + phone2 + phone3;

			//住所の取得
			String address1 = request.getParameter("prefecture");
			String address2 = request.getParameter("address");
			String address3 = request.getParameter("street-address");
			String address4 = request.getParameter("build");
			String address = address1 + address2 + address3 + address4;

			//部署の空文字チェック
			String departmentStr = request.getParameter("department");
			if (departmentStr.isEmpty()) {
				request.getRequestDispatcher("/view/userRegister.jsp").forward(request, response);
				return;
			} else {
				user.setDepartmentId(Integer.parseInt(departmentStr));
			}

			//グループの空文字チェック
			String groupStr = request.getParameter("group");
			if (groupStr.isEmpty()) {
				request.getRequestDispatcher("/view/userRegister.jsp").forward(request, response);
				return;
			} else {
				user.setGroupId(Integer.parseInt(groupStr));
			}

			//getParameterを使って取得
			user.setEmployeeNumber(request.getParameter("employeeNumber"));
			user.setName(request.getParameter("name"));
			user.setNameKana(request.getParameter("nameKana"));
			user.setSex(request.getParameter("sex"));
			user.setPhone(phone);
			user.setPost(request.getParameter("post"));
			user.setAddress(address);
			user.setMarriageFlag(Integer.parseInt(request.getParameter("marriage")));
			user.setWorkHistory(Integer.parseInt(request.getParameter("workyear")));
			user.setNearestStation(request.getParameter("station"));
			user.setTransportation(request.getParameter("transportation"));
			user.setQualification(request.getParameter("qualification"));

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

			String birthdayStr = request.getParameter("birthday");
			if (birthdayStr != null && !birthdayStr.isEmpty()) {
				java.util.Date utilDate = sdf.parse(birthdayStr);
				java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
				user.setBirthday(sqlDate);
			}

			String joiningDateStr = request.getParameter("joiningDate");
			if (joiningDateStr != null && !joiningDateStr.isEmpty()) {
				java.util.Date parsedDate = sdf.parse(joiningDateStr);
				Timestamp joiningDate = new Timestamp(parsedDate.getTime());
				user.setJoiningDate(joiningDate);
			}

			UserDAO userDAO = new UserDAO();
			userDAO.updateProfile(user);

			//セッション登録
			session.setAttribute("profile", true);
			session.setAttribute("user", user);
			session.setAttribute("user_id", user.getUserId());
			session.setAttribute("user_name", user.getName());

			response.sendRedirect(request.getContextPath() + "/home");
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "登録処理中にエラーが発生しました。");
			request.getRequestDispatcher("/view/error.jsp").forward(request, response);
		}

	}
}
