/*
 * プログラム名：Home-Jack.ver.2.0
 * 作成者：青木美波
 * 作成日：2025/7/14
 */

package servlet;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import bean.Jackworks;
import bean.Monthjack;
import dao.MonthjackDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/monthJackworks")
@MultipartConfig
public class MonthJackworksServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//エラー文を格納する用の変数設定
		String error = null;
		//例外と遷移先情報を格納する用の変数設定
		String cmd = "";
		//遷移先のパスを設定
		String path = "/jackworks";

		//オブジェクト生成
		MonthjackDAO monthJackDAO = new MonthjackDAO();
		Monthjack monthJack = new Monthjack();

		try {
			//jackWorksの検索結果が格納されたjack_listを受け取る
			ArrayList<Jackworks> jackList = (ArrayList<Jackworks>) request.getAttribute("jack_list");

			//SearchJackworksからcmd=searchを受け取る
			cmd = (String) request.getAttribute("cmd");

			if (cmd == null) {
				cmd = "";
			}

			//MonthJackWorksの全情報を取得するメソッド
			monthJack = monthJackDAO.selectAll();

			//取得したListをリクエストスコープにmonthJackで登録
			request.setAttribute("monthJack", monthJack);
			//cmdをリクエストスコープにcmdで登録
			request.setAttribute("cmd", cmd);

			//取得したjackListをリクエストスコープにjackListで登録
			if (jackList != null) {
				request.setAttribute("jack_list", jackList);
			}

		} catch (IllegalStateException e) {
			error = "DB接続エラーのため、今月のJackWorksは表示できませんでした。";
			cmd = "home";
		} catch (Exception e) {
			error = "予期せぬエラーが発生しました。" + e;
			cmd = "logout";
		} finally {
			if (error != null) {
				// 例外を発生する場合エラー文をリクエストスコープに"error"という名前で格納する
				request.setAttribute("error", error);
				// 例外を発生する場合エラー種類をリクエストスコープに"cmdという名前で格納する
				request.setAttribute("cmd", cmd);
				// error.jspにフォワード
				path = "/view/error.jsp";
			}
			//jackWorks.jspにフォワード
			request.getRequestDispatcher(path).forward(request, response);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//エラー文を格納する用の変数設定
		String error = null;
		//例外と遷移先情報を格納する用の変数設定
		String cmd = "";
		//遷移先のパスを設定
		String path = "/jackworks";

		//オブジェクト生成
		MonthjackDAO monthJackDAO = new MonthjackDAO();
		Monthjack monthJack = new Monthjack();

		try {
		// ファイル取得用の情報を受け取る
		Part filePart = request.getPart("image");
		String uploadDir = "";
		String filePath = "";

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

			// ファイルを指定されたディレクトリに保存
			// （具体的には以下の階層に保存される）
			// C:\
			// usr\kis_java_pkg_2023\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps
			filePath = uploadDir + "/" + file_name.getName();
			try (InputStream inputStream = filePart.getInputStream()) {
				Files.copy(inputStream, new File(filePath).toPath(), StandardCopyOption.REPLACE_EXISTING);
			}

			monthJack.setImage(file_name.getName());

			String theme = request.getParameter("theme");
			monthJack.setTheme(theme);
			String note = request.getParameter("note");
			monthJack.setNote(note);

			monthJackDAO.update(monthJack);
		}
		//MonthJackWorksの全情報を取得するメソッド
		monthJack = monthJackDAO.selectAll();
		
		//取得したListをリクエストスコープにmonthJackで登録
		request.setAttribute("monthJack", monthJack);
		
		} catch (IllegalStateException e) {
			error = "DB接続エラーのため、今月のJackWorksは登録できませんでした。";
			cmd = "home";
		} catch (Exception e) {
			error = "予期せぬエラーが発生しました。" + e;
			cmd = "logout";
		} finally {
			if (error != null) {
				// 例外を発生する場合エラー文をリクエストスコープに"error"という名前で格納する
				request.setAttribute("error", error);
				// 例外を発生する場合エラー種類をリクエストスコープに"cmdという名前で格納する
				request.setAttribute("cmd", cmd);
				// error.jspにフォワード
				path = "/view/error.jsp";
		}
			//jackWorks.jspにフォワード
			request.getRequestDispatcher(path).forward(request, response);
		}
	}

}
