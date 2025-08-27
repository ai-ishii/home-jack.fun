/**
 * 社員情報登録機能
 * 
 * 作成者：月向亮太
 * 
 * 作成日：8月18日
 * 
 * 最終更新日：8月26日
 * 
 */
package servlet;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import bean.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/userConfirm")
public class UserConfirmServlet extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String cmd = "";
		String path = "";
		int children = 0;
		//電話番号の取得
		/*
		String phone1 = "";
		String phone2 = "";
		String phone3 = "";
		String phone = "";
		//住所の取得
		String address1 = "";
		String address2 = "";
		String address3 = "";
		String address4 = "";
		String address = "";
		
		*/
		HttpSession session = request.getSession();

		User user = (User) session.getAttribute("user");

		try {

			String register = request.getParameter("register");
			String registerConfirm = request.getParameter("registerConfirm");

			if ("確認画面へ".equals(register)) {
				cmd = "registerConfirm";

				//部署の空文字チェック
				String departmentStr = request.getParameter("department");
				//グループの空文字チェック
				String groupStr = request.getParameter("group");
				//性別の空文字チェック
				String sex = request.getParameter("sex");
				
				String childrenStr =  request.getParameter("children");

				if (departmentStr == null || departmentStr == "" ||
						groupStr == null || groupStr == "" ||
						sex == null || sex == "") {
					session.setAttribute("user", user);
					

					request.setAttribute("error", "（所属、グループ、性別）を入力してください。");
					request.getRequestDispatcher("/view/userRegister.jsp").forward(request, response);
					return;
				}
				
				if (childrenStr.equals("")) {
					user.setChildren(children);
				}
				/*	
					if (user == null) {
						response.sendRedirect("index.jsp");
						return;
					}
					if (registerConfirm == null) {
						registerConfirm = "";
					}
				*/
				//	if (register == "") {
				//電話番号の取得
				/*
				phone1 = request.getParameter("phone1");
				phone2 = request.getParameter("phone2");
				phone3 = request.getParameter("phone3");
				if (phone1 == null || phone2 == null || phone3 == null) {
					user.setPhone(request.getParameter("phone"));
				}else {
					user.setPhone(phone);
				}
				//住所の取得
				address1 = request.getParameter("prefecture");
				address2 = request.getParameter("address");
				address3 = request.getParameter("street-address");
				address4 = request.getParameter("build");
				if (address1 == null || address2 == null || address3 == null || address4 == null) {
					user.setAddress(request.getParameter("address"));
				}else {
					user.setAddress(address);
				}
				
				*/
				//getParameterを使って取得
				user.setEmployeeNumber(request.getParameter("employeeNumber"));
				user.setDepartmentId(Integer.parseInt(departmentStr));
				user.setGroupId(Integer.parseInt(groupStr));
				user.setName(request.getParameter("name"));
				user.setNameKana(request.getParameter("nameKana"));
				user.setSex(sex);
				user.setPhone(request.getParameter("phone"));
				user.setAddress(request.getParameter("address"));
				user.setPost(request.getParameter("post"));
				user.setMarriageFlag(Integer.parseInt(request.getParameter("marriage")));
				user.setWorkHistory(Integer.parseInt(request.getParameter("workyear")));
				user.setChildren(Integer.parseInt(childrenStr));
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
				//セッション登録
				session.setAttribute("user", user);
				
				/*
				session.setAttribute("phone1", phone1);
				session.setAttribute("phone2", phone2);
				session.setAttribute("phone3", phone3);

				session.setAttribute("prefecture", address1);
				session.setAttribute("address", address2);
				session.setAttribute("street-address", address3);
				session.setAttribute("build", address4);
				
				*/

				request.setAttribute("user", user);
				request.setAttribute("cmd", cmd);
				request.getRequestDispatcher("/view/userConfirm.jsp").forward(request, response);

				session.setAttribute("user_id", user.getUserId());
				session.setAttribute("user_name", user.getName());

				//		path = "/view/userConfirm.jsp";

			} else if ("完了".equals(registerConfirm)) {
				cmd = "register";

				user = (User) session.getAttribute("user");

				request.setAttribute("user", user);

				request.getRequestDispatcher("/userRegister").forward(request, response);

			} else if ("戻る".equals(registerConfirm)) {
				cmd = "reRegister";

				request.setAttribute("cmd", cmd);
				request.getRequestDispatcher("/view/userRegister.jsp").forward(request, response);
			} else if ("変更する".equals(registerConfirm)) {
				cmd = "reRegister";

				
				
				//セッション登録
				session.setAttribute("user", user);
				
				request.setAttribute("cmd", cmd);
				request.getRequestDispatcher("/view/userUpdate.jsp").forward(request, response);
			} else {
				request.setAttribute("error", "不正な操作を検知しました。");
				request.getRequestDispatcher("/view/error.jsp").forward(request, response);
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "登録処理中にエラーが発生しました。");
			request.getRequestDispatcher("/view/error.jsp").forward(request, response);
		}
	}

}