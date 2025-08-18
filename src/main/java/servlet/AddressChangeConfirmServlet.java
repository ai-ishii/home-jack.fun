/*
 * 機能：住所変更確認機能
 * 
 * 作成者：桑原岳
 * 
 * 最終更新日：2025/08/12
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

@WebServlet("/addressChangeConfirm")
public class AddressChangeConfirmServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 1. 文字コードを設定
		request.setCharacterEncoding("UTF-8");

		// 2. フォームから送られてきたデータを全て受け取る
		String employeeNumber = request.getParameter("employeenumber");
		String name = request.getParameter("name");
		String addressChangedDate = request.getParameter("addressChangedDate");
		String oldPost = request.getParameter("oldpost");
		String oldAddress = request.getParameter("oldaddress");
		String newPost = request.getParameter("newpost");
		String newAddress = request.getParameter("newaddress");
		String nearestStation = request.getParameter("neareststation");

		
		// エラー状態を管理するMapを準備
		Map<String, Boolean> errors = new HashMap<>();

		// 各項目のnullチェック
		errors.put("employeeNumber_error", employeeNumber == null || employeeNumber.trim().isEmpty());
		errors.put("name_error", name == null || name.trim().isEmpty());
		errors.put("addressChangedDate_error", addressChangedDate == null || addressChangedDate.trim().isEmpty());
		errors.put("oldPost_error", oldPost == null || oldPost.trim().isEmpty());
		errors.put("oldAddress_error", oldAddress == null || oldAddress.trim().isEmpty());
		errors.put("newPost_error", newPost == null || newPost.trim().isEmpty());
		errors.put("newAddress_error", newAddress == null || newAddress.trim().isEmpty());
		errors.put("nearestStation_error", nearestStation == null || nearestStation.trim().isEmpty());

		// Mapに一つでもtrue（エラー）が含まれているかチェック
		if (errors.containsValue(true)) {
			// エラーがある場合

			// JSPでエラー箇所を判断できるよう、Mapをリクエストにセット
			request.setAttribute("errors", errors);

			// 全体用のエラーメッセージもセット
			request.setAttribute("errorMessage", "入力されていない項目があります。");

			// 入力された値を保持するためのMapを作成
			Map<String, String> userInput = new HashMap<>();
			userInput.put("employeenumber", employeeNumber);
			userInput.put("name", name);
			userInput.put("addressChangedDate", addressChangedDate);
			userInput.put("oldpost", oldPost);
			userInput.put("oldaddress", oldAddress);
			userInput.put("newpost", newPost);
			userInput.put("newaddress", newAddress);
			userInput.put("neareststation", nearestStation);

			// JSPで入力値を参照できるよう、Mapをリクエストにセット
			request.setAttribute("userInput", userInput);

			// フォーム画面に処理を戻す（フォワード）
			request.getRequestDispatcher("/view/addressChangeForm.jsp").forward(request, response);
			return;
		}

		// 3. 受け取ったデータを「リクエストスコープ」に格納する
		//    こうすることで、次のJSPでこの値を表示できる
		request.setAttribute("employeeNumber", employeeNumber);
		request.setAttribute("name", name);
		request.setAttribute("addressChangedDate", addressChangedDate);
		request.setAttribute("oldPost", oldPost);
		request.setAttribute("oldAddress", oldAddress);
		request.setAttribute("newPost", newPost);
		request.setAttribute("newAddress", newAddress);
		request.setAttribute("nearestStation", nearestStation);

		// 4. 確認画面JSPに処理を引き継ぐ（フォワード）
		getServletContext().getRequestDispatcher("/view/confirm.jsp").forward(request, response);
	}
}