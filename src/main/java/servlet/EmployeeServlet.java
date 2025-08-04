//<!-- 社員紹介 一覧機能（作：石井） -->
//<!-- 作成日：7/2　最終更新日：8/1 12:00 -->

package servlet;

import java.io.IOException;
import java.util.ArrayList;

import bean.User;
import dao.EmployeeDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/employee")
public class EmployeeServlet extends HttpServlet {
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
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
		
		// メソッドからSQL実行
		ArrayList<User> userList = userDAO.selectAll();
		
		// 社員写真を格納する配列宣言
		String[] photos = new String[userList.size()];
		for (int i = 0; i < userList.size(); i++) {
			photos[i] = employeeDAO.selectPhotoByUserId(userList.get(i).getUserId());
		}
		
		// 取得してきたユーザー情報をjspに送るためセットする
		request.setAttribute("userList", userList);
		request.setAttribute("photos", photos);
			
		} catch(IllegalStateException e) {
			cmd = "";
			error = "DB接続エラーのため、社員一覧は表示できませんでした。";
		} catch (Exception e) {
			cmd = "";
			error = "予期せぬエラーが発生しました。" + e;
		} finally {
			// エラーがあれば
			if (error != "") {
				request.setAttribute("cmd", cmd);
				request.setAttribute("error", error);
				request.getRequestDispatcher("/view/error.jsp").forward(request, response);
			} else {	// エラーがなければ
				// 社員一覧画面に遷移する
				request.getRequestDispatcher("/view/employee.jsp").forward(request, response);
			}
		}
		
	}

}
