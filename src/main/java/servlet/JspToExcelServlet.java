/*
 * 機能：JSPで入力された内容をエクセルに反映させる機能
 * 
 * 作成者：桑原岳
 * 
 * 最終更新日：2025/08/14
 * 
 * */

package servlet;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

import org.apache.poi.openxml4j.exceptions.OpenXML4JRuntimeException;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/jspToExcel")
public class JspToExcelServlet extends HttpServlet {

    private void setCellValueSafe(Sheet sheet, int rowIndex, int cellIndex, String value) {
        if (sheet.getRow(rowIndex) == null) {
            sheet.createRow(rowIndex);
        }
        if (sheet.getRow(rowIndex).getCell(cellIndex) == null) {
            sheet.getRow(rowIndex).createCell(cellIndex);
        }
        sheet.getRow(rowIndex).getCell(cellIndex).setCellValue(value != null ? value : "");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");


        //　1. フォームデータの受け取り
        String employeeNumber = request.getParameter("employeenumber");
        String name = request.getParameter("name");
        String strAddressChangeDate = request.getParameter("addressChangedDate");
        String oldPost = request.getParameter("oldpost");
        String oldAddress = request.getParameter("oldaddress");
        String newPost = request.getParameter("newpost");
        String newAddress = request.getParameter("newaddress");
        String nearestStation = request.getParameter("neareststation");



        // 2. 日付形式の検証
        LocalDate addressChangeDate;
        try {
            addressChangeDate = LocalDate.parse(strAddressChangeDate);
        } catch (DateTimeParseException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "日付の形式が正しくありません。「YYYY-MM-DD」形式で入力してください。");
            return;
        }
        
        LocalDate today = LocalDate.now();
        String strYear = String.valueOf(today.getYear());
        String strMonth = String.valueOf(today.getMonthValue());
        String strDay = String.valueOf(today.getDayOfMonth());
        String changeYear = String.valueOf(addressChangeDate.getYear());
        String changeMonth = String.valueOf(addressChangeDate.getMonthValue());
        String changeDay = String.valueOf(addressChangeDate.getDayOfMonth());

        // 3. Excel処理の開始
        String templatePath = getServletContext().getRealPath("/WEB-INF/住所変更届のコピー.xlsx");

        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        String fileName = "住所変更届.xlsx";
        String encodedFileName = URLEncoder.encode(fileName, StandardCharsets.UTF_8).replaceAll("\\+", "%20");
        response.setHeader("Content-Disposition", "attachment; filename*=UTF-8''" + encodedFileName);

        try (InputStream fis = new FileInputStream(templatePath);
             Workbook workbook = new XSSFWorkbook(fis);
             ServletOutputStream out = response.getOutputStream()) {

            Sheet sheet = workbook.getSheetAt(0);
            if (sheet == null) {
                throw new IOException("テンプレートファイルにシートが存在しません。ファイルが破損している可能性があります。");
            }

            setCellValueSafe(sheet, 3, 26, strYear);
            setCellValueSafe(sheet, 3, 32, strMonth);
            setCellValueSafe(sheet, 3, 36, strDay);
            setCellValueSafe(sheet, 6, 0, employeeNumber);
            setCellValueSafe(sheet, 6, 11, name);
            setCellValueSafe(sheet, 9, 14, changeYear);
            setCellValueSafe(sheet, 9, 22, changeMonth);
            setCellValueSafe(sheet, 9, 30, changeDay);
            setCellValueSafe(sheet, 10, 16, newPost);
            setCellValueSafe(sheet, 11, 14, newAddress);
            setCellValueSafe(sheet, 12, 16, oldPost);
            setCellValueSafe(sheet, 13, 14, oldAddress);
            setCellValueSafe(sheet, 14, 14, nearestStation);

            workbook.write(out);

        } catch (FileNotFoundException e) {
            System.err.println("【エラー】Excelテンプレートファイルが見つかりません。パスとファイル名を確認してください。 Path: " + templatePath);
            e.printStackTrace();
        } catch (IOException e) {
            String message = e.getMessage();
            if (message != null && message.contains("Broken pipe")) {
                System.out.println("【情報】クライアントが接続を閉じました。ファイル送信を中断します。");
            } else {
                System.err.println("【エラー】Excelファイルの読み書き中にIOエラーが発生しました。テンプレートファイルが破損している可能性があります。");
                e.printStackTrace();
            }
        } catch (OpenXML4JRuntimeException e) {
            System.out.println("【情報】POIライブラリがファイルの保存に失敗しました。クライアントが接続を閉じた可能性が高いです。");
        } catch (Exception e) {
            System.err.println("【エラー】Excel処理中に予期せぬエラーが発生しました。入力値やプログラムのロジックを確認してください。");
            e.printStackTrace();
        }
    }
}
