//<!-- 社員紹介 変更機能（作：石井） -->
//<!-- 作成日：7/18　最終更新日：8/19 14:00 -->

/*
 * 更新を促す（開発経験年数）年一に更新
 */

package servlet;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import bean.Employee;
import dao.EmployeeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/employeeUpdate")
@MultipartConfig
public class EmployeeUpdateServlet extends HttpServlet {
	
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
		
		response.setContentType("text/html; charset=UTF-8");
		
		// ファイル取得用の情報を受け取る
		Part filePart = request.getPart("image");
		String uploadDir = "";
		String filePath = "";
		
		try {
			
			// オブジェクト生成
			EmployeeDAO employeeDAO = new EmployeeDAO();
			Employee employee = new Employee();
			
			// ファイルサイズを元にファイルの有無を確認
			if (filePart.getSize() != 0) {
				String contentDisposition = filePart.getHeader("content-disposition");
				String fileName = "";
				Pattern pattern = Pattern.compile("filename=\"(.*)\"");
				Matcher matcher = pattern.matcher(contentDisposition);
				// 抽出したファイル名が存在していれば抽出、なければ空白
					if (matcher.find()) {
						fileName = matcher.group(1);
					} else {
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
				
				// ファイルを指定されたディレクトリに保存 (具体的には以下の階層に保存される）
				// C:\ usr\kis_java_pkg_2023\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps
				filePath = uploadDir + "/" + file_name.getName();
				
				try (InputStream inputStream = filePart.getInputStream()) {
					Files.copy(inputStream, new File(filePath).toPath(), StandardCopyOption.REPLACE_EXISTING);
				}
				
				//DBに登録
				employee.setPhoto(file_name.getName());
			}
			
//			// 入力された情報をJSPから取得
//			String photo = request.getParameter("photo");
			// ファイル取得用の情報を受け取る
//			Part filePart = request.getPart("photo");
			
			//セッションからユーザー情報を取得
			HttpSession session = request.getSession();
			int sessionUserId = (int)session.getAttribute("user_id");
			
			int paramUserId = Integer.parseInt(request.getParameter("userId"));
			int developer = Integer.parseInt(request.getParameter("developer"));
			String langSkill = request.getParameter("langSkill");
			String middleSkill = request.getParameter("middleSkill");
			String hobby = request.getParameter("hobby");
			String talent = request.getParameter("talent");
			String intro = request.getParameter("intro");
			String position = request.getParameter("position");
			
			if(sessionUserId != paramUserId) {
				error ="不正なアクセスです。";
				return;
			}
			
//			employee.setPhoto(photo);
			employee.setDeveloper(developer);
			employee.setLangSkill(langSkill);
			employee.setMiddleSkill(middleSkill);
			employee.setHobby(hobby);
			employee.setTalent(talent);
			employee.setIntro(intro);
			employee.setPosition(position);
			employee.setRegistDate(null);
			employee.setUpdateDate(null);
			
			// メソッドからSQL実行
			employeeDAO.update(employee, paramUserId);
			
		} catch (Exception e) {
			cmd = "";
			error = "予期せぬエラーが発生しました。" + e;
		} finally {
			// エラーが空じゃなければ（エラーがあれば）
			if (error != "") {
				request.setAttribute("cmd", cmd);
				request.setAttribute("error", error);
				request.getRequestDispatcher("/view/error.jsp").forward(request, response);
			} else {	// エラーがなければ
				// 社員紹介一覧画面に遷移する
				request.getRequestDispatcher("/employee").forward(request, response);
			}
		}
		
	}

}
