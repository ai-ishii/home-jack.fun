/* 
 * 機能：資格申請画像取り出し機能
 * 
 * 作成者：桑原岳
 * 
 * 最終更新日：2025/08/27
 * 
 */

package servlet;

import java.io.IOException;

import bean.LicenseRequestExclusive;
import dao.RequestDAO;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/licenseRequestPhoto")
public class LicenseRequestPhotoServrlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// パラメータの受け取り
		String type = request.getParameter("type");
		int requestId = Integer.parseInt(request.getParameter("requestId"));

		// オブジェクト化
		RequestDAO requestDAO = new RequestDAO();
		LicenseRequestExclusive licenseRequestExclusive = requestDAO.selectPhotoByRequestId(requestId);

		//　変数宣言
		byte[] imageBytes;
		String fileName;

		// typeの種類によって受け取る画像と画像名が変わる
		// receiptなら領収書画像と領収書画像名
		if ("receipt".equals(type)) {
			imageBytes = licenseRequestExclusive.getReceipt();
			fileName = licenseRequestExclusive.getReceiptName();
		// passingなら合格証画像と合格証画像名	
		} else {
			imageBytes = licenseRequestExclusive.getPassing();
			fileName = licenseRequestExclusive.getPassingName();
		}

		String contentType = getServletContext().getMimeType(fileName);
		if (contentType == null)
			contentType = "application/octet-stream";
		response.setContentType(contentType);

		ServletOutputStream out = response.getOutputStream();
		out.write(imageBytes);
		out.flush();
	}

}
