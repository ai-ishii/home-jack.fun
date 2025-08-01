/*
 * 機能：資格申請詳細機能
 * 
 * 作成者：桑原岳
 * 
 * 最終更新日：2025/08/01
 * 
 * */


package servlet;

import java.io.IOException;

import bean.LicenseRequestExclusive;
import dao.RequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/licenseRequestDetail")
public class LicenseRequestDetailServlet extends HttpServlet {

	//doGetメソッド
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//errorとcmd
		String error = null;
		String cmd = null;

		//licenseRequest.jspからrequestIdの値を受け取りint型に変換する
		String stRequestid = request.getParameter("requestId");
		int requestid = Integer.parseInt(stRequestid);

		//flagを受け取る
		String flag = request.getParameter("flag");

		//LicenseRequestExclusiveのオブジェクト化
		LicenseRequestExclusive licenseRequestExclusive = new LicenseRequestExclusive();

		try {
			//オブジェクト化
			RequestDAO requestDAO = new RequestDAO();

			//メソッドを呼び出す
			licenseRequestExclusive = requestDAO.selectByRequestId(requestid);
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
			request.setAttribute("licenseRequestExclusive", licenseRequestExclusive);
			request.setAttribute("flag", flag);
			request.getRequestDispatcher("/view/licenseRequestDetail.jsp").forward(request, response);

			//エラーがある場合はerror.jspに遷移する
		} else {
			request.setAttribute("error", "error");
			request.setAttribute("cmd", "cmd");
			request.getRequestDispatcher("/view/Error.jsp").forward(request, response);
		}
	}
}
