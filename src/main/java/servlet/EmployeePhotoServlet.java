/*
 * 社員紹介画面の社員画像を表示させるサーブレット
 * 
 * 作成者：大北直弥
 * 
 * 作成日：8/22
 * 
 * 更新日：8/22
 */
package servlet;

import java.io.IOException;

import bean.Employee;
import dao.EmployeeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/employeePhoto")
public class EmployeePhotoServlet extends HttpServlet {
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		// オブジェクト生成
		Employee employee = new Employee();
		EmployeeDAO employeeDAO = new EmployeeDAO();
		
		// 送られてきたパラメータからidを取得
		String strUserId = request.getParameter("user_id");
		String work = request.getParameter("work");
		
		if (strUserId == null) {
			// エラー処理
			return;
		}
		
		try {
			
			int userId = Integer.parseInt(strUserId);
			
			if (work != null) {
				
				employee = employeeDAO.selectByUserId(userId, work);

			}
			
			if (employee != null && employee.getPhoto() != null) {
				
				// コンテントタイプを設定
				String contentType = getServletContext().getMimeType(employee.getPhotoName());
				if (contentType == null) {
					// コンテントタイプが不明の場合はバイナリデータとして扱う
					contentType = "application/octet-stream";
				}
				response.setContentType(contentType);
				
				// レスポンスに画像データを書き込む
				ServletOutputStream out = response.getOutputStream();
				out.write(employee.getPhoto());
				out.flush();
				out.close();
				
			} else {
				// 画像が見つからないときのエラー処理
			}
			
		} catch (NumberFormatException e) {
			// エラー処理
		}
	}

}
