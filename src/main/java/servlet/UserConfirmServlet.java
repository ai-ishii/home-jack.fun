/**
 * 社員情報登録確認能
 * 
 * 作成者：月向亮太
 * 
 * 作成日：8月18日
 * 
 * 最終更新日：8月27日
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

		// エラー用フラグ
		boolean error = false;
		// 画面遷移用コマンド
		String cmd = "";
		// エラー文格納用
		String message = "";
		// 遷移先のパス
		String path = "/view/userConfirm.jsp";
		int children = 0;

		HttpSession session = request.getSession();

		try {

			//セッションからユーザー情報を取得
			User user = (User) session.getAttribute("user");

			String register = request.getParameter("register");
			String registerConfirm = request.getParameter("registerConfirm");

			//userRegister.jspから受け取った情報をセットして確認画面へ
			if ("確認画面へ".equals(register)) {
				cmd = "registerConfirm";

				String childrenStr = request.getParameter("children");

				//childrenが空文字だったら、0をセットする
				if ("".equals(childrenStr)) {
					user.setChildren(children);
				} else {
					//受け取った値をセット
					user.setChildren(Integer.parseInt(childrenStr));
				}

				//getParameterを使って取得
				user.setEmployeeNumber(request.getParameter("employeeNumber"));
				user.setDepartmentId(Integer.parseInt(request.getParameter("department")));
				user.setGroupId(Integer.parseInt(request.getParameter("group")));
				user.setName(request.getParameter("name"));
				user.setNameKana(request.getParameter("nameKana"));
				user.setSex(request.getParameter("sex"));
				user.setPhone(request.getParameter("phone"));
				user.setAddress(request.getParameter("address"));
				user.setPost(request.getParameter("post"));
				user.setMarriageFlag(Integer.parseInt(request.getParameter("marriage")));
				user.setWorkHistory(Integer.parseInt(request.getParameter("workyear")));
				user.setNearestStation(request.getParameter("station"));
				user.setTransportation(request.getParameter("transportation"));
				user.setQualification(request.getParameter("qualification"));

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

				//誕生日をセットする
				String birthdayStr = request.getParameter("birthday");
				if (birthdayStr != null && !birthdayStr.isEmpty()) {
					java.util.Date utilDate = sdf.parse(birthdayStr);
					java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
					user.setBirthday(sqlDate);
				}

				//入社年月をセットする
				String joiningDateStr = request.getParameter("joiningDate");
				if (joiningDateStr != null && !joiningDateStr.isEmpty()) {
					java.util.Date parsedDate = sdf.parse(joiningDateStr);
					Timestamp joiningDate = new Timestamp(parsedDate.getTime());
					user.setJoiningDate(joiningDate);
				}

				//セッション登録
				session.setAttribute("user", user);
				request.setAttribute("user", user);
				session.setAttribute("user_id", user.getUserId());
				session.setAttribute("user_name", user.getName());
			}

			if ("完了".equals(registerConfirm)) {
				
				user = (User) session.getAttribute("user");
				
				cmd = "register";
				path = "/userRegister";

				request.setAttribute("user", user);
				
			} else if ("戻る".equals(registerConfirm)) {

				cmd = "reRegister";
				path = "/view/userRegister.jsp";

			} else if ("変更する".equals(registerConfirm)) {

				cmd = "reRegister";
				path = "/view/userUpdate.jsp";
				
				//セッション登録
				session.setAttribute("user", user);
			}

		} catch (IllegalStateException e) {
			error = true;
			cmd = "logout";
			message = "システムの一時的な問題により、個人情報の読み込みができませんでした。";
		} catch (Exception e) {
			error = true;
			cmd = "logout";
			message = "予期せぬエラーが発生しました。" + e;
		} finally {

			if (error) {
				// 例外が発生する場合エラー文をリクエストスコープに"error"という名前で格納する
				request.setAttribute("message", message);
				// error.jspにフォワード
				path = "/view/error.jsp";
			}

			request.setAttribute("cmd", cmd);
			// pathにフォワード
			request.getRequestDispatcher(path).forward(request, response);
		}
	}

}