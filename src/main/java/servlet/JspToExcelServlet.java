package servlet;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.HashMap;
import java.util.Map;

import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import bean.AddressRequestExclusive;
import dao.RequestDAO;
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
		LocalDate today = LocalDate.now();

		// 2. 日付形式の検証
		LocalDate addressChangeDate;
		try {
			addressChangeDate = LocalDate.parse(strAddressChangeDate);
		} catch (DateTimeParseException e) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "日付の形式が正しくありません。「YYYY-MM-DD」形式で入力してください。");
			return;
		}

		// 3. DTOにデータを格納し、DAOを呼び出す
		RequestDAO requestDAO = new RequestDAO();
		AddressRequestExclusive addressRequestExclusive = new AddressRequestExclusive();

		addressRequestExclusive.setEmployeenumber(employeeNumber);
		addressRequestExclusive.setName(name);
		addressRequestExclusive.setAddressChangedDate(addressChangeDate);
		addressRequestExclusive.setOldPost(oldPost);
		addressRequestExclusive.setOldAddress(oldAddress);
		addressRequestExclusive.setNewPost(newPost);
		addressRequestExclusive.setNewAddress(newAddress);
		addressRequestExclusive.setNeareststation(nearestStation);
		addressRequestExclusive.setApplicationDate(today);

		boolean success = requestDAO.insertAddressChange(addressRequestExclusive);

		// 4. DB登録の結果に応じて処理を分岐
		if (success) {
			// 4-A. 成功：Excelを生成してダウンロード
			String strYear = String.valueOf(today.getYear());
			String strMonth = String.valueOf(today.getMonthValue());
			String strDay = String.valueOf(today.getDayOfMonth());
			String changeYear = String.valueOf(addressChangeDate.getYear());
			String changeMonth = String.valueOf(addressChangeDate.getMonthValue());
			String changeDay = String.valueOf(addressChangeDate.getDayOfMonth());

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
					throw new IOException("テンプレートファイルにシートが存在しません。");
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

			} catch (Exception e) {
				// Excel処理中のエラーはログに出力する
				e.printStackTrace();
			}
		} else {
			// 4-B. 失敗：エラーメッセージをセットして入力画面に戻す
			request.setAttribute("errorMessage", "データベースへの登録に失敗しました。管理者にお問い合わせください。");

			Map<String, String> userInput = new HashMap<>();
			userInput.put("employeenumber", employeeNumber);
			userInput.put("name", name);
			userInput.put("addressChangedDate", strAddressChangeDate);
			userInput.put("oldpost", oldPost);
			userInput.put("oldaddress", oldAddress);
			userInput.put("newpost", newPost);
			userInput.put("newaddress", newAddress);
			userInput.put("neareststation", nearestStation);

			request.setAttribute("userInput", userInput);

			// ★フォーム画面のJSPパスを正しく指定してください
			request.getRequestDispatcher("/view/addressChangeForm.jsp").forward(request, response);
		}
	}
}
