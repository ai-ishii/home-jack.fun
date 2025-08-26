/* 
 * 機能：資格申請の内容を検証し、バイト配列としてセッションに保存して確認画面に渡す 
 * 作成者：桑原岳 
 * 最終更新日：2025/08/25
 */
package servlet;

import java.io.IOException;
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
        RequestDAO requestDAO = new RequestDAO();

        // フォーム値取得
        String name = request.getParameter("name");
        String department = request.getParameter("department");
        String group = request.getParameter("group");
        String license = request.getParameter("license");
        String examDate = request.getParameter("exam-date");
        String examTime = request.getParameter("exam-time");

        // ファイルIDの取得(前回アップロード済みかどうか)
        Long oldReceiptId = request.getParameter("receiptFileId") != null && !request.getParameter("receiptFileId").isEmpty() ?
                Long.parseLong(request.getParameter("receiptFileId")) : null;
        Long oldPassingId = request.getParameter("passingFileId") != null && !request.getParameter("passingFileId").isEmpty() ?
                Long.parseLong(request.getParameter("passingFileId")) : null;

        // 入力値チェック
        Map<String, Boolean> errors = new HashMap<>();
        errors.put("name_error", name == null || name.trim().isEmpty());
        errors.put("department_error", department == null || department.isEmpty());
        errors.put("group_error", group == null || group.isEmpty());
        errors.put("license_error", license == null || license.isEmpty());
        errors.put("exam-date_error", examDate == null || examDate.isEmpty());

        boolean isExamTimeInvalid = true;
        if (examTime != null && !examTime.trim().isEmpty()) {
            try { Integer.parseInt(examTime); isExamTimeInvalid = false; } 
            catch (NumberFormatException e) { isExamTimeInvalid = true; }
        }
        errors.put("exam-time_error", isExamTimeInvalid);

        // ファイル部分
        Part receiptPart = request.getPart("receipt");
        Part passingPart = request.getPart("passing");
        errors.put("receipt_error", (receiptPart == null || receiptPart.getSize() == 0) && oldReceiptId == null);
        errors.put("passing_error", (passingPart == null || passingPart.getSize() == 0) && oldPassingId == null);

        // 入力値マップ
        Map<String, String> userInput = new HashMap<>();
        userInput.put("name", name != null ? name : "");
        userInput.put("department", department != null ? department : "");
        userInput.put("group", group != null ? group : "");
        userInput.put("license", license != null ? license : "");
        userInput.put("examDate", examDate != null ? examDate : "");
        userInput.put("examTime", examTime != null ? examTime : "");

        Map<String, Object> userInputFile = new HashMap<>();
        Map<String, Object> formValues = new HashMap<>(userInput);

        // 受験料領収書の処理
        if (receiptPart != null && receiptPart.getSize() > 0) {
            byte[] receiptBytes = receiptPart.getInputStream().readAllBytes();
            long newReceiptId;
            if (oldReceiptId != null) {
                requestDAO.updateReceiptFile(oldReceiptId, receiptBytes, receiptPart.getSubmittedFileName());
                newReceiptId = oldReceiptId;
            } else {
                newReceiptId = requestDAO.insertReceiptFileProvisional(receiptBytes, receiptPart.getSubmittedFileName());
            }
            userInput.put("receiptFileName", receiptPart.getSubmittedFileName());
            userInputFile.put("licenseRequestTestId", newReceiptId);
            formValues.put("receiptFileName", receiptPart.getSubmittedFileName());
    		formValues.put("licenseRequestTestId", newReceiptId);
            userInputFile.put("receiptBytes", receiptBytes);
        } else if (oldReceiptId != null) {
            byte[] existingBytes = requestDAO.getReceiptFileById(oldReceiptId);
            userInput.put("receiptFileName", requestDAO.getReceiptFileNameById(oldReceiptId));
            userInputFile.put("licenseRequestTestId", oldReceiptId);
            formValues.put("passingFileName", requestDAO.getReceiptFileNameById(oldReceiptId));
            formValues.put("licenseRequestTestId", oldReceiptId);
            userInputFile.put("receiptBytes", existingBytes);
        }

        //  合格証の処理
        if (passingPart != null && passingPart.getSize() > 0) {
            byte[] passingBytes = passingPart.getInputStream().readAllBytes();
            long newPassingId;
            if (oldPassingId != null) {
                requestDAO.updatePassingFile(oldPassingId, passingBytes, passingPart.getSubmittedFileName());
                newPassingId = oldPassingId;
            } else {
                newPassingId = requestDAO.insertPassingFileProvisional(passingBytes, passingPart.getSubmittedFileName());
            }
            userInput.put("passingFileName", passingPart.getSubmittedFileName());
            userInputFile.put("passingFileId", newPassingId);
            formValues.put("passingFileName", passingPart.getSubmittedFileName());
    		formValues.put("passingFileId", newPassingId);
            userInputFile.put("passingBytes", passingBytes);
        } else if (oldPassingId != null) {
            byte[] existingBytes = requestDAO.getPassingFileById(oldPassingId);
            userInput.put("passingFileName", requestDAO.getPassingFileNameById(oldPassingId));
            userInputFile.put("passingFileId", oldPassingId);
            formValues.put("passingFileName", requestDAO.getPassingFileNameById(oldPassingId));
            formValues.put("passingFileId", oldPassingId);
            userInputFile.put("passingBytes", existingBytes);
        }
        
        

        // エラーがあればフォームに戻す
        if (errors.containsValue(true)) {
            request.setAttribute("errors", errors);
            request.setAttribute("errorMessage", "入力されていない項目があります。");
            request.setAttribute("userInput", userInput);
            request.setAttribute("userInputFile", userInputFile);
            request.getRequestDispatcher("/view/licenseForm.jsp").forward(request, response);
            return;
        }

        // formValues作成(確認画面用)
        if (userInputFile.containsKey("receiptBytes")) formValues.put("receiptBytes", userInputFile.get("receiptBytes"));
        if (userInputFile.containsKey("passingBytes")) formValues.put("passingBytes", userInputFile.get("passingBytes"));

        // LicenseRequestExclusiveにセット(DB登録用)
        LicenseRequestExclusive licenseRequestExclusive = new LicenseRequestExclusive();
        int applicantId = (int) session.getAttribute("user_id");
        licenseRequestExclusive.setApplicantId(applicantId);
        licenseRequestExclusive.setApplicant(name);

        long requestId;
        try { requestId = requestDAO.insertLicenseRequestID(applicantId); }
        catch (Exception e) { 
        	e.printStackTrace(); request.setAttribute("errorMessage", "申請ID生成に失敗"); request.getRequestDispatcher("/view/licenseForm.jsp").forward(request, response); 
        	return; 
        	}

        licenseRequestExclusive.setDepartmentId(requestDAO.selectByDepartmentId(department));
        licenseRequestExclusive.setGroupId(requestDAO.selectByGroupId(group));
        licenseRequestExclusive.setLicenseId(requestDAO.selectByLicenseId(license));
        licenseRequestExclusive.setExamDate(LocalDate.parse(examDate));
        licenseRequestExclusive.setExamTime(Integer.parseInt(examTime));
        licenseRequestExclusive.setReceipt((byte[]) formValues.get("receiptBytes"));
        licenseRequestExclusive.setReceiptName(userInput.get("receiptFileName"));
        licenseRequestExclusive.setPassing((byte[]) formValues.get("passingBytes"));
		licenseRequestExclusive.setPassingName(userInput.get("passingFileName"));
		

        // 子テーブル登録
        try {
            boolean success = requestDAO.insertLicenseRequestDetails(requestId, licenseRequestExclusive);
    		formValues.put("examDate", examDate);
    		formValues.put("examTime", examTime);
            formValues.put("requestId", requestId);
            if (!success) {
                request.setAttribute("errorMessage", "資格申請登録に失敗しました。");
                request.getRequestDispatcher("/view/licenseForm.jsp").forward(request, response);
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "資格申請登録中にエラーが発生しました。");
            request.getRequestDispatcher("/view/licenseForm.jsp").forward(request, response);
            return;
        }
        
        request.setAttribute("formValues", formValues);
        request.getRequestDispatcher("/view/licenseConfirm.jsp").forward(request, response);
    }
}
