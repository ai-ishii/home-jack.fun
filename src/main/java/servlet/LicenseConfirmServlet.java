/*
 * 機能：資格申請の内容を確認するためのサーブレット
 * 
 * 作成者：桑原岳
 * 
 * 最終更新日：2025/08/18
 * 
 * */


package servlet;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/licenseConfirm")
@MultipartConfig
public class LicenseConfirmServlet extends HttpServlet {

    // 一時ファイルを保存するフォルダ（Webから直接アクセスできない安全な場所）
    private static final String TEMP_DIR = "/WEB-INF/tmp";
    
    // 許可するファイルサイズの上限 (例: 5MB)
    private static final long MAX_FILE_SIZE = 10 * 1024 * 1024; 
    
    // 許可するファイルの種類 (MIMEタイプ)
    private static final List<String> ALLOWED_TYPES = Arrays.asList("image/jpeg", "image/png", "image/gif");

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // --- 1. フォームから全データを受け取る ---
        String name = request.getParameter("name");
        String department = request.getParameter("department");
        String group = request.getParameter("group");
        String license = request.getParameter("license");
        String examDate = request.getParameter("exam-date");
        String examTime = request.getParameter("exam-time");
        Part receiptPart = request.getPart("receipt");
        Part passingPart = request.getPart("passing");
        
        // --- 2. バリデーション（入力チェック） ---
        // ご指定の Map<String, Boolean> 形式でエラー状態を管理
        Map<String, Boolean> errors = new HashMap<>();

        // 各項目のチェック結果（エラーならtrue）をMapに格納
        errors.put("name_error", name == null || name.trim().isEmpty());
        errors.put("department_error", department == null || department.isEmpty());
        errors.put("group_error", group == null || group.isEmpty());
        errors.put("license_error", license == null || license.isEmpty());
        errors.put("exam-date_error", examDate == null || examDate.isEmpty());
        
        boolean isExamTimeInvalid;
        if (examTime == null || examTime.trim().isEmpty()) {
            isExamTimeInvalid = true; // 未入力はエラー
        } else {
            try {
                Integer.parseInt(examTime);
                isExamTimeInvalid = false; // 数値変換できればエラーではない
            } catch (NumberFormatException e) {
                isExamTimeInvalid = true; // 数値変換できなければエラー
            }
        }
        errors.put("exam-time_error", isExamTimeInvalid);
        boolean receiptError = false;
        if (receiptPart == null || receiptPart.getSize() == 0) {
            receiptError = true; // 未選択エラー
        } else if (receiptPart.getSize() > MAX_FILE_SIZE) {
            receiptError = true; // サイズオーバーエラー
        } else if (!ALLOWED_TYPES.contains(receiptPart.getContentType())) {
            receiptError = true; // 種類エラー
        }
        errors.put("receipt_error", receiptError);

        boolean passingError = false;
        if (passingPart == null || passingPart.getSize() == 0) {
            passingError = true; // 未選択エラー
        } else if (passingPart.getSize() > MAX_FILE_SIZE) {
            passingError = true; // サイズオーバーエラー
        } else if (!ALLOWED_TYPES.contains(passingPart.getContentType())) {
            passingError = true; // 種類エラー
        }
        errors.put("passing_error", passingError);
        
        if (errors.containsValue(true)) {
            // エラーがあった場合：元のフォーム画面に差し戻す
            
            // エラーメッセージを設定（より具体的に）
            request.setAttribute("errorMessage", "入力されていない項目があります。");
            request.setAttribute("errors", errors);
            
            // 入力値を復元
            Map<String, String> userInput = new HashMap<>();
            userInput.put("name", name);
            userInput.put("department", department);
            userInput.put("group", group);
            userInput.put("license", license);
            userInput.put("exam-date", examDate);
            userInput.put("exam-time", examTime);
            
            request.setAttribute("userInput", userInput);
            
            request.getRequestDispatcher("/view/licenseForm.jsp").forward(request, response);
            return;
        }

        // --- 4. エラーがなかった場合：一時ファイル保存と確認画面への遷移 ---
        String appPath = request.getServletContext().getRealPath("");
        String tempDirFullPath = appPath + TEMP_DIR;
        File tempDir = new File(tempDirFullPath);
        if (!tempDir.exists()) {
            tempDir.mkdirs();
        }

        String receiptTempFileName = saveTemporaryFile(receiptPart, tempDirFullPath);
        String passingTempFileName = saveTemporaryFile(passingPart, tempDirFullPath);

        
        // requestスコープにデータをセット
        request.setAttribute("name", name);
        request.setAttribute("department", department);
        request.setAttribute("group", group);
        request.setAttribute("license", license);
        request.setAttribute("examDate", examDate);
        request.setAttribute("examTime", examTime);
        request.setAttribute("receiptOriginalFileName", receiptPart.getSubmittedFileName());
        request.setAttribute("passingOriginalFileName", passingPart.getSubmittedFileName());
        request.setAttribute("receiptTempFileName", receiptTempFileName);
        request.setAttribute("passingTempFileName", passingTempFileName);
        
        request.getRequestDispatcher("/view/licenseConfirm.jsp").forward(request, response);
    }
    
    private String saveTemporaryFile(Part part, String dirPath) throws IOException {
        String originalFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
        String uniqueFileName = UUID.randomUUID().toString() + "_" + originalFileName;
        part.write(dirPath + File.separator + uniqueFileName);
        return uniqueFileName;
    }
}