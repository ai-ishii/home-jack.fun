/*
 * 機能：氏名確認機能
 * 
 * 作成者：桑原岳
 * 
 * 最終更新日：2025/08/14
 * 
 * */

package servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/nameChangeConfirm")
public class NameChangeConfirmServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 1. 文字コードを設定
		request.setCharacterEncoding("UTF-8");

		// 2. フォームから送られてきたデータを全て受け取る
		String oldName = request.getParameter("oldname");
		String oldNameKana = request.getParameter("oldnamekana");
		String newName = request.getParameter("newname");
		String newNameKana = request.getParameter("newnamekana");

		
	       // エラー状態を管理するMap（キーはJSPに合わせて小文字）
        Map<String, Boolean> errors = new HashMap<>();
        errors.put("oldname_error", oldName == null || oldName.trim().isEmpty());
        errors.put("oldnamekana_error", oldNameKana == null || oldNameKana.trim().isEmpty());
        errors.put("newname_error", newName == null || newName.trim().isEmpty());
        errors.put("newnamekana_error", newNameKana == null || newNameKana.trim().isEmpty());

        if (errors.containsValue(true)) {
            request.setAttribute("errors", errors);
            request.setAttribute("errorMessage", "入力されていない項目があります。");

            // 全入力値を必ずセット
            Map<String, String> userInput = new HashMap<>();
            userInput.put("oldname", oldName != null ? oldName : "");
            userInput.put("oldnamekana", oldNameKana != null ? oldNameKana : "");
            userInput.put("newname", newName != null ? newName : "");
            userInput.put("newnamekana", newNameKana != null ? newNameKana : "");
            request.setAttribute("userInput", userInput);

            request.getRequestDispatcher("/view/nameChangeForm.jsp").forward(request, response);
            return;
        }

		// 3. 受け取ったデータを「リクエストスコープ」に格納する
		//    こうすることで、次のJSPでこの値を表示できる
		request.setAttribute("oldName", oldName);
		request.setAttribute("oldNameKana", oldNameKana);
		request.setAttribute("newName", newName);
		request.setAttribute("newNameKana", newNameKana);

		// 4. 確認画面JSPに処理を引き継ぐ（フォワード）
		getServletContext().getRequestDispatcher("/view/nameConfirm.jsp").forward(request, response);
	}
}