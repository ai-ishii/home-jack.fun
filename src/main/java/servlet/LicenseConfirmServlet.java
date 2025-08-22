/* 
 * 機能：資格申請の内容を検証し、バイト配列としてセッションに保存して確認画面に渡す 
 * 作成者：桑原岳 
 * 最終更新日：2025/08/21
 */
package servlet;

import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

import bean.LicenseRequestExclusive;
import dao.RequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/licenseConfirm")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 20)
public class LicenseConfirmServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();

		// フォームから値を取得
		String name = request.getParameter("name");
		String department = request.getParameter("department");
		String group = request.getParameter("group");
		String license = request.getParameter("license");
		String examDate = request.getParameter("exam-date");
		String examTime = request.getParameter("exam-time");

		Map<String, Boolean> errors = new HashMap<>();
		errors.put("name_error", name == null || name.trim().isEmpty());
		errors.put("department_error", department == null || department.isEmpty());
		errors.put("group_error", group == null || group.isEmpty());
		errors.put("license_error", license == null || license.isEmpty());
		errors.put("exam-date_error", examDate == null || examDate.isEmpty());

		boolean isExamTimeInvalid = true;
		if (examTime != null && !examTime.trim().isEmpty()) {
			try {
				Integer.parseInt(examTime);
				isExamTimeInvalid = false;
			} catch (NumberFormatException e) {
				isExamTimeInvalid = true;
			}
		}
		errors.put("exam-time_error", isExamTimeInvalid);

		// アップロードファイル処理
		Part receiptPart = request.getPart("receipt");
		Part passingPart = request.getPart("passing");
		boolean receiptError = receiptPart == null || receiptPart.getSize() == 0;
		boolean passingError = passingPart == null || passingPart.getSize() == 0;
		errors.put("receipt_error", receiptError);
		errors.put("passing_error", passingError);

		Map<String, Object> formValues = new HashMap<>();
		formValues.put("name", name);
		formValues.put("department", department);
		formValues.put("group", group);
		formValues.put("license", license);
		formValues.put("examDate", examDate);
		formValues.put("examTime", examTime);

		byte[] receiptBytes = null;
		byte[] passingBytes = null;
		String receiptOriginalFileName = ""; // 空文字で初期化
		String passingOriginalFileName = "";

		if (!receiptError) {
			try (InputStream is = receiptPart.getInputStream()) {
				receiptBytes = is.readAllBytes();
				formValues.put("receiptBytes", receiptBytes);
				formValues.put("receiptOriginalFileName", receiptPart.getSubmittedFileName());
			}
		}

		if (!passingError) {
			try (InputStream is = passingPart.getInputStream()) {
				passingBytes = is.readAllBytes();
				formValues.put("passingBytes", passingBytes);
				formValues.put("passingOriginalFileName", passingPart.getSubmittedFileName());
			}
		}

		  // DTO作成
        LicenseRequestExclusive licenseRequestExclusive = new LicenseRequestExclusive();
        int applicantId = (int) session.getAttribute("user_id");
        licenseRequestExclusive.setApplicantId(applicantId);
        licenseRequestExclusive.setApplicant(name);

        RequestDAO requestDAO = new RequestDAO();

        // 1. 親テーブルに request_id を作成
        long requestId = 0;
        try {
            requestId = requestDAO.insertLicenseRequestID(applicantId); // 親テーブル登録して request_id を取得
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "申請IDの生成に失敗しました。");
            request.getRequestDispatcher("/view/licenseForm.jsp").forward(request, response);
            return;
        }

        // 2. DTOに詳細情報セット
        int departmentId = requestDAO.selectByDepartmentId(department);
        int groupId = requestDAO.selectByGroupId(group);
        int licenseId = requestDAO.selectByLicenseId(license);

        licenseRequestExclusive.setDepartmentId(departmentId);
        licenseRequestExclusive.setGroupId(groupId);
        licenseRequestExclusive.setLicenseId(licenseId);

        licenseRequestExclusive.setExamDate(LocalDate.parse(examDate));
        licenseRequestExclusive.setExamTime(Integer.parseInt(examTime));
        licenseRequestExclusive.setReceipt(receiptBytes);
        receiptOriginalFileName = receiptPart.getSubmittedFileName(); 
        licenseRequestExclusive.setReceiptName(receiptOriginalFileName);
        licenseRequestExclusive.setPassing(passingBytes);
        passingOriginalFileName = passingPart.getSubmittedFileName(); 
        licenseRequestExclusive.setPassingName(passingOriginalFileName);

        // 3. 子テーブルに登録
        try {
            boolean success = requestDAO.insertLicenseRequestDetails(requestId, licenseRequestExclusive);
            if (!success) {
                request.setAttribute("errorMessage", "資格申請の登録に失敗しました。");
                request.getRequestDispatcher("/view/licenseForm.jsp").forward(request, response);
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "資格申請の登録中にエラーが発生しました。");
            request.getRequestDispatcher("/view/licenseForm.jsp").forward(request, response);
            return;
        }

        // 登録成功 → 確認画面へ
        request.getRequestDispatcher("/view/licenseConfirm.jsp").forward(request, response);
    }
}