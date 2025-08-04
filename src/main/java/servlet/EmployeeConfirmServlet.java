//<!-- 社員紹介 確認画面など画面遷移のための機能（作：石井） -->
//<!-- 作成日：7/30　最終更新日：8/1 12:00 -->

package servlet;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import bean.Employee;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/employeeConfirm")
@MultipartConfig
public class EmployeeConfirmServlet extends HttpServlet {

	public void doGet (HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		commonProcess(request, response);
	}

	public void doPost (HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		commonProcess(request, response);
	}

	private void commonProcess (HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {

		// 変数宣言
		String error = "";
		String cmd = "";
		String registerSubmit = "";
		String updateSubmit = "";
		int userId = 0;
		String path = "";

		// オブジェクト生成
		Employee employee = new Employee();
		
		/*
		 * ファイル送信が上手くできていない
		 * 確認画面を挟んでいるのがよくないかも
		 * セッションではファイル名は取ってこれたけどPart型にキャストできない
		 */

		try {
			// 押されたボタンの種類をjspから取得
			registerSubmit = request.getParameter("registerSubmit");
			updateSubmit = request.getParameter("updateSubmit");

			if (request.getParameter("userId") != null) {
				// jspから送られてきたユーザーIDを取得
				userId = Integer.parseInt(request.getParameter("userId"));
			}
			
			System.out.println(request.getPart("photo"));
			
			if (request.getPart("photo") != null) {
				// ファイル送信のためセッションに登録
//				HttpSession session = request.getSession();
//				session.setAttribute("photo", photo);
				
				Part filePart = request.getPart("photo");
				String uploadDir = "";
				String filePath = "";

				// ファイルサイズを元にファイルの有無を確認
				if (filePart.getSize() != 0) {
					String contentDisposition = filePart.getHeader("content-disposition");
					String fileName = request.getParameter("photo");
					Pattern pattern = Pattern.compile("filename=\"(.*)\"");
					Matcher matcher = pattern.matcher(contentDisposition);
					// 抽出したファイル名が存在していれば抽出、なければ空白
					if (matcher.find()) {
						fileName = matcher.group(1);
					} else {
						// これだとgetNameで何も取ってこれなくなる　処理を終了したいならreturn
						fileName = "";
					}

					File file_name = new File(fileName);

					// ファイル保存先のディレクトリ
					uploadDir = getServletContext().getRealPath("/file").replace("\\", "/");
					// アップロード先のフォルダがなければ作成
					File uploadDirectory = new File(uploadDir);
					if (!uploadDirectory.exists()) {
						uploadDirectory.mkdirs();
					}

					// ファイルを指定されたディレクトリに保存
					// （具体的には以下の階層に保存される）
					// C:\
					// usr\kis_java_pkg_2023\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps
					filePath = uploadDir + "/" + file_name.getName();
					try (InputStream inputStream = filePart.getInputStream()) {
						Files.copy(inputStream, new File(filePath).toPath(), StandardCopyOption.REPLACE_EXISTING);
					}
					
					//DBに登録したい場合
					employee.setPhoto(file_name.getName());
			}

			// --------登録機能--------
			if (registerSubmit != null) {
				if (registerSubmit.equals("確認画面へ")) {
					cmd = "registerConfirm";
				} else if (registerSubmit.equals("戻る")) {
					cmd = "reRegister";
				} else if (registerSubmit.equals("完了")) {
					cmd = "register";
				}
			}

			// 遷移先を分ける
			if (cmd.equals("registerConfirm")) {	// 確認画面のとき
				path = "/view/employeeRegister.jsp?cmd=registerConfirm";
			} else if (cmd.equals("reRegister")) {	// 登録画面に戻るとき
				path = "/view/employeeRegister.jsp?cmd=reRegister";
			} else if (cmd.equals("register") ) {	// 登録完了のとき
				path = "/employeeRegister";
			}


			// --------変更機能--------
			if (updateSubmit != null) {
				if (updateSubmit.equals("確認画面へ")) {
					cmd = "updateConfirm";
				} else if (updateSubmit.equals("戻る")) {
					cmd = "reUpdate";
				} else if (updateSubmit.equals("完了")) {
					cmd = "update";
				}
			}

			// 遷移先を分ける
			if (cmd.equals("updateConfirm")) {	// 確認画面のとき
				path = "/view/employeeUpdate.jsp?cmd=updateConfirm&userId=" + userId;
			} else if (cmd.equals("reUpdate")) {	// 変更画面に戻るとき
				path = "/view/employeeUpdate.jsp?cmd=reUpdate&userId=" + userId;
			} else if (cmd.equals("update") ) {	// 変更完了のとき
				path = "/employeeUpdate";
			}
			
			}

		} catch(IllegalStateException e) {
			cmd = "";
			error = "DB接続エラーのため、社員一覧は表示できませんでした。";
		} catch (Exception e) {
			cmd = "";
			error = "予期せぬエラーが発生しました。" + e;
		} finally {
			// エラーがあれば
			if (error != "") {
				request.setAttribute("cmd", cmd);
				request.setAttribute("error", error);
				request.getRequestDispatcher("/view/error.jsp").forward(request, response);
			} else {	// エラーがなければ
				// cmdで指定した画面に遷移する
				request.setAttribute("cmd", cmd);
				request.getRequestDispatcher(path).forward(request, response);
			}
		}

	}
}


