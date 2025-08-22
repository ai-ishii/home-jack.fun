//<!-- 社員紹介 変更機能（作：石井） -->
//<!-- 作成日：7/18　最終更新日：8/22 14:00 -->

/*
 * 更新を促す（開発経験年数）年一に更新
 */

package servlet;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

import bean.Employee;
import bean.User;
import dao.EmployeeDAO;
import dao.UserDAO;
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

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		commonProcess(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		commonProcess(request, response);
	}

	private void commonProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 変数宣言
		String error = "";
		String cmd = "";
		
		// オブジェクト宣言
		User user = new User();
		UserDAO userDAO = new UserDAO();
		Employee employee = new Employee();
		EmployeeDAO employeeDAO = new EmployeeDAO();

		response.setContentType("text/html; charset=UTF-8");

		try {

			//セッションからユーザー情報を取得
			HttpSession session = request.getSession();
			int sessionUserId = (int) session.getAttribute("user_id");

			// ファイル取得用の情報を受け取る
			Part photoPart = request.getPart("photo");
			
			// テストコード（削除予定）
			if (photoPart == null || photoPart.getSize() <= 0) {
			    System.out.println("Partが存在しないか、サイズが0以下のため処理を中断します。");
			    return;
			}
			
			System.out.println("Partの報告サイズ: " + photoPart.getSize() + " バイト");
			
			// InputStreamの取得とnullチェック
			try (InputStream inputStream = photoPart.getInputStream()) {
			    
			    if (inputStream == null) {
			        System.out.println("エラー: InputStreamがnullです。");
			        return;
			    }

			    // 3. ✅ 実際にデータを読み込んで検証する
			    System.out.println("InputStreamの読み込みを試みます...");
			    
			    ByteArrayOutputStream buffer = new ByteArrayOutputStream();
			    int nRead;
			    byte[] data = new byte[1024]; // 1KBずつ読み込むバッファ

			    // inputStream.read(data)は、読み込むデータがなくなると-1を返す
			    while ((nRead = inputStream.read(data, 0, data.length)) != -1) {
			        buffer.write(data, 0, nRead);
			    }
			    
			    // バッファをフラッシュして、書き込みを確定させる
			    buffer.flush();

			    // 実際に読み込んだバイト数を取得
			    byte[] readBytes = buffer.toByteArray();
			    System.out.println("実際に読み込んだ合計サイズ: " + readBytes.length + " バイト");

			    if (readBytes.length > 0) {
			        System.out.println("✅ 成功: InputStreamから正常にデータを読み込めました。");
			    } else {
			        System.out.println("❌ 問題: InputStreamは存在しましたが、データを1バイトも読み込めませんでした。");
			    }
			    
			    // サイズの比較
			    if (photoPart.getSize() == readBytes.length) {
			        System.out.println("報告サイズと実測サイズが一致しました。");
			    } else {
			        System.out.println("警告: Partの報告サイズと実際に読み込んだサイズが異なります。");
			    }

			} catch (IOException e) {
			    System.out.println("InputStreamの読み込み中にエラーが発生しました。");
			    e.printStackTrace();
			}
			// ここまでテストコード

			// ファイル名、ファイルの中身を取得する
			String photoName = photoPart.getSubmittedFileName();
			InputStream photoContent = photoPart.getInputStream();
			long photoSize = photoPart.getSize();

			int paramUserId = Integer.parseInt(request.getParameter("userId"));
			int developer = Integer.parseInt(request.getParameter("developer"));
			String langSkill = request.getParameter("langSkill");
			String middleSkill = request.getParameter("middleSkill");
			String hobby = request.getParameter("hobby");
			String talent = request.getParameter("talent");
			String intro = request.getParameter("intro");
			String position = request.getParameter("position");

			if (sessionUserId != paramUserId) {
				error = "不正なアクセスです。";
				return;
			}

			employee.setDeveloper(developer);
			employee.setLangSkill(langSkill);
			employee.setMiddleSkill(middleSkill);
			employee.setHobby(hobby);
			employee.setTalent(talent);
			employee.setIntro(intro);
			employee.setPosition(position);
			employee.setPhotoName(photoName);

			// インサートメソッドからSQL実行
			employeeDAO.registTest(employee, photoContent, photoSize, paramUserId);
			
			// employeeConfirm.jspで表示するコンテンツを制御する変数
			cmd = "confirm";
			
			// user情報を取得する
			user = userDAO.selectByUserId(paramUserId);
			
			// 社員情報をリクエストスコープに登録する
			request.setAttribute("cmd", cmd);
			request.setAttribute("user", user);
			request.setAttribute("employee", employee);

		} catch (Exception e) {
			cmd = "";
			error = "予期せぬエラーが発生しました。" + e;
		} finally {
			request.setAttribute("cmd", cmd);
			// エラーが空じゃなければ（エラーがあれば）
			if (error != "") {
				request.setAttribute("error", error);
				request.getRequestDispatcher("/view/error.jsp").forward(request, response);
			} else { // エラーがなければ
				// 社員紹介一覧画面に遷移する
				request.getRequestDispatcher("/view/employeeConfirm.jsp").forward(request, response);
			}
		}

	}

}
