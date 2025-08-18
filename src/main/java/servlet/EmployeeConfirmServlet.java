//<!-- 社員紹介 確認画面など画面遷移のための機能（作：石井） -->
//<!-- 作成日：7/30　最終更新日：8/15 14:00 -->

package servlet;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date; // java.util.Dateをインポート

import bean.Employee;
import bean.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/employeeConfirm")
@MultipartConfig
public class EmployeeConfirmServlet extends HttpServlet {

public void doGet(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {
commonProcess(request, response);
}

public void doPost(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {
commonProcess(request, response);
}

private void commonProcess(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {

String error = "";
String cmd = "";
String path = "";

HttpSession session = request.getSession();

try {
	String registerSubmit = request.getParameter("registerSubmit");

	if (registerSubmit != null) {
		if (registerSubmit.equals("確認画面へ")) {
			cmd = "registerConfirm";

			// --- 1. フォームから送られた情報をオブジェクトに格納 ---
			User user = new User();
			Employee employee = new Employee();

			// --- テキスト情報を取得 ---
			user.setEmployeeNumber(request.getParameter("employeeNumber"));
			user.setName(request.getParameter("name"));
			user.setNameKana(request.getParameter("nameKana"));
			employee.setDeveloper(Integer.parseInt(request.getParameter("developer")));
			employee.setLangSkill(request.getParameter("langSkill"));
			employee.setMiddleSkill(request.getParameter("middleSkill"));
			employee.setHobby(request.getParameter("hobby"));
			employee.setTalent(request.getParameter("talent"));
			employee.setIntro(request.getParameter("intro"));
			employee.setPosition(request.getParameter("position"));

			// --- 数値情報を安全に取得 ---
			String departmentStr = request.getParameter("department");
			if (departmentStr != null && !departmentStr.isEmpty()) {
				user.setDepartmentId(Integer.parseInt(departmentStr));
			}
			String groupStr = request.getParameter("group");
			if (groupStr != null && !groupStr.isEmpty()) {
				user.setGroupId(Integer.parseInt(groupStr));
			}

			// --- 日付情報を安全に変換 ---
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

			// --- ファイル情報を取得し、一時保管の準備 ---
			Part filePart = request.getPart("photo");
			if (filePart != null && filePart.getSize() > 0) {
				String fileName = new File(filePart.getSubmittedFileName()).getName();
				employee.setPhoto(fileName);
				session.setAttribute("photoPartConfirm", filePart);
			}

			// --- 作成したオブジェクトをセッションに一時保管 ---
			session.setAttribute("userConfirm", user);
			session.setAttribute("employeeConfirm", employee);
			
			path = "/view/employeeRegister.jsp";

		} else if (registerSubmit.equals("戻る")) {
			cmd = "reRegister";
			path = "/view/employeeRegister.jsp";

		} else if (registerSubmit.equals("完了")) {
			cmd = "register";
			path = "/employeeRegister";
		}
	}

	// ... (更新フローも同様に記述) ...

	request.setAttribute("cmd", cmd);
	request.getRequestDispatcher(path).forward(request, response);

} catch (Exception e) {
	e.printStackTrace();
	error = "予期せぬエラーが発生しました。入力内容を確認してください。";
	request.setAttribute("error", error);
	request.getRequestDispatcher("/view/error.jsp").forward(request, response);
}
}


}
