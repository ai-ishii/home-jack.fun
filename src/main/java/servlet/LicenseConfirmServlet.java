/* 
 * 機能：資格申請の内容を検証し、バイト配列としてセッションに保存して確認画面に渡す 
 * 作成者：桑原岳 
 * 最終更新日：2025/08/20
 */
package servlet;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/licenseConfirm")
//	ファイルのアップロードを行う設定
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1MBを超えたら一時ファイルに
		maxFileSize = 1024 * 1024 * 10, // 1ファイル最大10MB
		maxRequestSize = 1024 * 1024 * 20 // リクエスト全体で20MB
)

public class LicenseConfirmServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 文字化け防止
		request.setCharacterEncoding("UTF-8");

		// セッションを取得
		HttpSession session = request.getSession();

		// フォームから送られてきた入力値を取得
		String name = request.getParameter("name");
		String departmentCode = request.getParameter("department");
		String groupCode = request.getParameter("group");
		String licenseCode = request.getParameter("license");
		String examDate = request.getParameter("exam-date");
		String examTime = request.getParameter("exam-time");

		// 入力チェック用のエラーフラグを用意
		Map<String, Boolean> errors = new HashMap<>();
		errors.put("name_error", name == null || name.trim().isEmpty());
		errors.put("department_error", departmentCode == null || departmentCode.isEmpty());
		errors.put("group_error", groupCode == null || groupCode.isEmpty());
		errors.put("license_error", licenseCode == null || licenseCode.isEmpty());
		errors.put("exam-date_error", examDate == null || examDate.isEmpty());

		// 受験日が整数で入力されているか確認
		boolean isExamTimeInvalid = true;
		if (examTime != null && !examTime.trim().isEmpty()) {
			try {
				Integer.parseInt(examTime); // 数値変換できればOK
				isExamTimeInvalid = false;
			} catch (NumberFormatException e) {
				isExamTimeInvalid = true;
			}
		}
		errors.put("exam-time_error", isExamTimeInvalid);

		// 初期化
		byte[] receiptBytes = null;
		byte[] passingBytes = null;
		String receiptFileName = null;
		String passingFileName = null;

		Map<String, Object> formValues = new HashMap<>();

		// テキスト・日付・回数など
		formValues.put("examDate", request.getParameter("exam-date"));
		formValues.put("examTime", request.getParameter("exam-time"));

		// アップロードされたファイルを取得
		Part receiptPart = request.getPart("receipt");
		Part passingPart = request.getPart("passing");

		// 領収書ファイルの有無をチェック
		boolean receiptError = false;
		if (receiptPart == null || receiptPart.getSize() == 0) {

			receiptError = true; // 新規がなければエラー

		}
		errors.put("receipt_error", receiptError);

		// 合格証ファイルの有無をチェック
		boolean passingError = false;
		if (passingPart == null || passingPart.getSize() == 0) {

			passingError = true;// 新規がなければエラー

		}

		// 領収書ファイルのバイト配列を保存（新規 or 過去データ）
		if (receiptPart != null && receiptPart.getSize() > 0) {
			try (InputStream is = receiptPart.getInputStream()) {
				receiptBytes = is.readAllBytes();
				formValues.put("receiptBytes", receiptBytes);
			}
			formValues.put("receiptOriginalFileName", receiptPart.getSubmittedFileName());
		}

		// 合格証ファイルのバイト配列を保存（新規 or 過去データ）
		if (passingPart != null && passingPart.getSize() > 0) {
			try (InputStream is = passingPart.getInputStream()) {
				passingBytes = is.readAllBytes();
				formValues.put("passingBytes", passingBytes);
			}
			formValues.put("passingOriginalFileName", passingPart.getSubmittedFileName());
		}

		errors.put("passing_error", passingError);
		session.setAttribute("formValues", formValues);

		// エラーがある場合は入力画面に戻す
		if (errors.containsValue(true)) {
			request.setAttribute("errorMessage", "入力内容に誤りがあります。");
			request.setAttribute("errors", errors);

			// 入力画面に戻す
			
			request.getRequestDispatcher("/view/licenseForm.jsp").forward(request, response);
			return;
		}

		// 確認画面に遷移
		request.getRequestDispatcher("/view/licenseConfirm.jsp").forward(request, response);
	}
}
