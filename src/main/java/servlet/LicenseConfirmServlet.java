/*
 * 機能：資格申請の内容を検証し、バイト配列としてセッションに保存して確認画面に渡す
 * 作成者：桑原岳
 * 最終更新日：2025/08/19
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
@MultipartConfig
public class LicenseConfirmServlet extends HttpServlet {

    private static final Map<String, String> departmentMap = new HashMap<>();
    static {
        departmentMap.put("BS0001", "BS事業部第1部");
        departmentMap.put("BS0002", "BS事業部第2部");
        departmentMap.put("SA0099", "営業部");
        departmentMap.put("NX0100", "NEXTINOVATION");
        departmentMap.put("MG0101", "経営管理部");
    }

    private static final Map<String, String> groupMap = new HashMap<>();
    static {
        groupMap.put("GR0000", "");
        groupMap.put("GR0001", "第1グループ");
        groupMap.put("GR0002", "第2グループ");
        groupMap.put("GR0003", "第3グループ");
        groupMap.put("GR0004", "第4グループ");
    }
    
    private static final Map<String, String> licenseMap = new HashMap<>();
    static {
        licenseMap.put("AIL001", "G検定");
        licenseMap.put("JAV001", "Oracle認定Javaプログラマ(Silver)");
        licenseMap.put("JAV002", "Oracle認定Javaプログラマ (Gold)");
        licenseMap.put("PYN001", "Python3 エンジニア認定基礎試験");
        licenseMap.put("PYN002", "Python3 エンジニア認定実践試験");
        licenseMap.put("PYN003", "Python3 エンジニア認定データ分析試験");
        licenseMap.put("AWS001", "AWS 認定クラウドプラクティショナー");
        licenseMap.put("AWS002", "AWS 認定デベロッパー アソシエイト");
        licenseMap.put("IPA001", "基本情報技術者試験");
        licenseMap.put("IPA002", "応用情報技術者試験");
        licenseMap.put("IPA003", "スペシャリスト試験データベース");
        licenseMap.put("IPA004", "スペシャリスト試験_ネットワーク");
        licenseMap.put("IPA005", "スペシャリスト試験_エンベデッドシステム");
        licenseMap.put("IPA006", "プロジェクトマネージャ");
        licenseMap.put("IPA007", "システムアーキテクト");
        licenseMap.put("IPA008", "ITストラテジスト");
        licenseMap.put("IPA009", "ITサービスマネージャ");
        licenseMap.put("IPA010", "システム監査技術者");
        licenseMap.put("IPA011", "ITパスポート");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        String name = request.getParameter("name");
        String departmentCode = request.getParameter("department");
        String groupCode = request.getParameter("group");
        String licenseCode = request.getParameter("license");
        String examDate = request.getParameter("exam-date");
        String examTime = request.getParameter("exam-time");

        Map<String, Boolean> errors = new HashMap<>();
        errors.put("name_error", name == null || name.trim().isEmpty());
        errors.put("department_error", departmentCode == null || departmentCode.isEmpty());
        errors.put("group_error", groupCode == null || groupCode.isEmpty());
        errors.put("license_error", licenseCode == null || licenseCode.isEmpty());
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

        Map<String, Object> oldInput = (Map<String, Object>) session.getAttribute("userInput");
        Part receiptPart = request.getPart("receipt");
        Part passingPart = request.getPart("passing");

        boolean receiptError = false;
        if (receiptPart == null || receiptPart.getSize() == 0) {
            if (oldInput == null || oldInput.get("receiptBytes") == null) {
                receiptError = true;
            }
        }
        errors.put("receipt_error", receiptError);

        boolean passingError = false;
        if (passingPart == null || passingPart.getSize() == 0) {
            if (oldInput == null || oldInput.get("passingBytes") == null) {
                passingError = true;
            }
        }
        errors.put("passing_error", passingError);

        if (errors.containsValue(true)) {
            request.setAttribute("errorMessage", "入力内容に誤りがあります。");
            request.setAttribute("errors", errors);
            Map<String, String> userInputForForm = new HashMap<>();
            userInputForForm.put("name", name);
            userInputForForm.put("department", departmentCode);
            userInputForForm.put("group", groupCode);
            userInputForForm.put("license", licenseCode);
            userInputForForm.put("examDate", examDate);
            userInputForForm.put("examTime", examTime);
            request.setAttribute("userInput", userInputForForm);
            request.getRequestDispatcher("/view/licenseForm.jsp").forward(request, response);
            return;
        }

        Map<String, Object> userInputToSession = new HashMap<>();
        userInputToSession.put("name", name);
        userInputToSession.put("department", departmentCode);
        userInputToSession.put("departmentName", departmentMap.get(departmentCode));
        userInputToSession.put("group", groupCode);
        userInputToSession.put("groupName", groupMap.get(groupCode));
        userInputToSession.put("license", licenseCode);
        userInputToSession.put("licenseName", licenseMap.get(licenseCode));
        userInputToSession.put("examDate", examDate);
        userInputToSession.put("examTime", examTime);

        if (receiptPart != null && receiptPart.getSize() > 0) {
            try (InputStream is = receiptPart.getInputStream()) {
                byte[] receiptBytes = is.readAllBytes();
                userInputToSession.put("receiptBytes", receiptBytes);
            }
            userInputToSession.put("receiptOriginalFileName", receiptPart.getSubmittedFileName());
        } else if (oldInput != null) {
            userInputToSession.put("receiptBytes", oldInput.get("receiptBytes"));
            userInputToSession.put("receiptOriginalFileName", oldInput.get("receiptOriginalFileName"));
        }

        if (passingPart != null && passingPart.getSize() > 0) {
            try (InputStream is = passingPart.getInputStream()) {
                byte[] passingBytes = is.readAllBytes();
                userInputToSession.put("passingBytes", passingBytes);
            }
            userInputToSession.put("passingOriginalFileName", passingPart.getSubmittedFileName());
        } else if (oldInput != null) {
            userInputToSession.put("passingBytes", oldInput.get("passingBytes"));
            userInputToSession.put("passingOriginalFileName", oldInput.get("passingOriginalFileName"));
        }
        
        session.setAttribute("userInput", userInputToSession);
        request.getRequestDispatcher("/view/licenseConfirm.jsp").forward(request, response);
    }
}