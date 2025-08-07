/*
 * 機能：JSPのフォームで入力された内容をExcelに反映させる機能
 * 
 * 作成者：桑原岳
 * 
 * 最終更新日：2025/08/07
 * 
 * */

package servlet;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.time.LocalDate; // ★LocalDateをインポート
import java.util.stream.Stream;

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
		sheet.getRow(rowIndex).getCell(cellIndex).setCellValue(value);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		
		// フォームに存在するパラメータのみ取得する
		String employeeNumber = request.getParameter("employeenumber");
		String name = request.getParameter("name");
		// JSPのname属性に合わせて "addressChangedDate" を取得
		String changeDate = request.getParameter("addressChangedDate");
		String oldPost = request.getParameter("oldpost");
		String oldAddress = request.getParameter("oldaddress");
		String newPost = request.getParameter("newpost");
		String newAddress = request.getParameter("newaddress");
		String nearestStation = request.getParameter("neareststation");

		// チェックする項目をフォームに存在するパラメータのみにする
		boolean hasMissingFields = Stream.of(employeeNumber, name, changeDate,
				oldPost, oldAddress, newPost, newAddress, nearestStation)
				.anyMatch(s -> s == null || s.trim().isEmpty());

		if (hasMissingFields) {
			request.setAttribute("errorMessage", "入力されていない欄があるため再入力をお願いします。");
			getServletContext().getRequestDispatcher("/view/addressChangeForm.jsp").forward(request, response);
			return;
		}

		// 「申請日時」は現在の日付を自動で取得する
		LocalDate today = LocalDate.now();
		String applicationYear = String.valueOf(today.getYear());
		String applicationMonth = String.valueOf(today.getMonthValue());
		String applicationDay = String.valueOf(today.getDayOfMonth());

		// 「変更日時」の区切り文字を "/" から "-" に変更
		String[] changeParts = changeDate.split("-");
		String changeYear = changeParts[0];
		String changeMonth = changeParts[1];
		String changeDay = changeParts[2];

		String templatePath = getServletContext().getRealPath("/WEB-INF/住所変更届のコピー.xlsx");

		try (InputStream fis = new FileInputStream(templatePath);
				Workbook workbook = new XSSFWorkbook(fis);
				ServletOutputStream out = response.getOutputStream()) {

			Sheet sheet = workbook.getSheetAt(0);

			setCellValueSafe(sheet, 3, 26, applicationYear);
			setCellValueSafe(sheet, 3, 32, applicationMonth);
			setCellValueSafe(sheet, 3, 36, applicationDay);
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

			response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			String fileName = "住所変更届のコピー.xlsx";
			String encodedFileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
			response.setHeader("Content-Disposition", "attachment; filename*=UTF-8''" + encodedFileName);

			workbook.write(out);

		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Excelファイルの生成中にエラーが発生しました。");
		}
	}
}
