/*
 * 機能：氏名申請の内容を保存する機能
 * 
 * 作成者：桑原岳
 * 
 * 最終更新日：2025/08/18
 * 
 * */

package servlet;

import java.io.IOException;

import bean.NameRequest;
import dao.RequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/nameChangeKeep")
public class NameChangeKeepServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 1. 文字コードを設定
		request.setCharacterEncoding("UTF-8");

		// 2. フォームから送られてきたデータを全て受け取る
		String oldName = request.getParameter("oldname");
		String oldNameKana = request.getParameter("oldnamekana");
		String newName = request.getParameter("newname");
		String newNameKana = request.getParameter("newnamekana");

		// 3.送られてきたデータをセットする
		NameRequest nameRequest = new NameRequest();
		nameRequest.setOldName(oldName);
		nameRequest.setOldNameKana(oldNameKana);
		nameRequest.setNewName(newName);
		nameRequest.setNewNameKana(newNameKana);

		// 4.RequestDAO をオブジェクト化し、 insertNameChangeメソッドを利用して
		//   データをDBに登録する
		RequestDAO requestDAO = new RequestDAO();
		boolean success = requestDAO.insertNameChange(nameRequest);

		// 5.確認画面JSPに処理を引き継ぐ（フォワード）
		if (success) {
			request.setAttribute("nameRequest", nameRequest);
			getServletContext().getRequestDispatcher("/view/nameChangeCompletion.jsp").forward(request, response);
		}else {
			getServletContext().getRequestDispatcher("/view/error.jsp").forward(request, response);
		}
	}
}
