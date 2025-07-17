package servlet;

import java.io.IOException;
import java.util.ArrayList;

import bean.Request;
import dao.RequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/requestList")
public class RequestListServlet extends HttpServlet {

	//doGetメソッド
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String error = null;
		String cmd = null;
		ArrayList<Request> requestList = new ArrayList<Request>();

		try {
			//オブジェクト化(doGetメソッド内の変数と名前が被るため AllRequest を変数名にしている)
			RequestDAO requestDAO = new RequestDAO();	

			//申請テーブルから情報を取り出し、requestListに代入
			requestList = requestDAO.selectAll();

		//DB接続エラー	
		} catch (Exception e) {
			error = "DB接続エラーのため、申請一覧は表示できませんでした。";
			cmd = "dbError";
		}
		//エラーがない場合は、RequestList.jspに遷移する
		if (error == null) {
			request.setAttribute("requestList", requestList);
			request.getRequestDispatcher("/view/requestList.jsp").forward(request, response);
		//エラーがある場合はerror.jspに遷移する
		} else {
			request.setAttribute("error", "error");
			request.setAttribute("cmd", "cmd");
			request.getRequestDispatcher("/view/Error.jsp").forward(request, response);
		}
	}
}

