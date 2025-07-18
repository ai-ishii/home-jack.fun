package servlet;

import java.io.IOException;

import bean.AddressRequest;
import bean.NameRequest;
import bean.RequestLicenseRequestUser;
import bean.WorkRequest;
import dao.RequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/requestDetail")
public class RequestDetailServlet extends HttpServlet {

	//doGetメソッド
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String error = null;
		String cmd = null;

		//requestidを受け取りint型に変換する
		String stRequestid = request.getParameter("request_id");
		int requestid = Integer.parseInt(stRequestid);

		//cmdを受け取りint型に変換する
		String stType = request.getParameter("type");
		int type = Integer.parseInt(stType);

		try {
			//オブジェクト化
			RequestDAO requestDAO = new RequestDAO();

			//申請内容ごとに対応したメソッドを呼び出す
			if (type == 0) {
				AddressRequest addressRequest = requestDAO.selectByAddressRequestId(requestid);
				request.setAttribute("addressRequest", addressRequest);
			} else if (type == 1) {
				NameRequest nameRequest = requestDAO.selectByNameRequestId(requestid);
				request.setAttribute("nameRequest", nameRequest);
			} else if (type == 2) {
				WorkRequest workRequest = requestDAO.selectByWorkRequestId(requestid);
				request.setAttribute("workRequest", workRequest);
			} else if (type == 3) {
				RequestLicenseRequestUser requestLicenseRequestUser = requestDAO.selectLicenseRequestId(requestid);
				request.setAttribute("requestLicenseRequestUser", requestLicenseRequestUser);

			}
			//DB接続エラー	
		} catch (IllegalStateException e) {
			error = "DB接続エラーの為、JackWorks検索結果は表示できませんでした。";
			cmd = "dbError";
		} catch (Exception e) {
			error = "予期せぬエラーが発生しました。" + e;
			cmd = "logout";
		}
		//エラーがない場合は、RequestList.jspに遷移する
		if (error == null) {
			if (type == 0) {
				request.getRequestDispatcher("/view/addressRequest.jsp").forward(request, response);
			} else if (type == 1) {
				request.getRequestDispatcher("/view/nameRequest.jsp").forward(request, response);
			} else if (type == 2) {
				request.getRequestDispatcher("/view/workRequest.jsp").forward(request, response);
			} else if (type == 3) {
				request.getRequestDispatcher("/view/licenseRequest.jsp").forward(request, response);
			}
			//エラーがある場合はerror.jspに遷移する
		} else {
			request.setAttribute("error", "error");
			request.setAttribute("cmd", "cmd");
			request.getRequestDispatcher("/view/Error.jsp").forward(request, response);
		}

	}
}