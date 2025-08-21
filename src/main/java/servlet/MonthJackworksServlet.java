/*
 * プログラム名：Home-Jack.ver.2.0
 * 作成者：青木美波
 * 作成日：2025/7/14
 * 更新日：2025/8/21
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
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/monthJackworks")
@MultipartConfig
@SuppressWarnings("unchecked") //コンパイルエラーがでなくなっているので注意
public class MonthJackworksServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// エラー用コマンド
		String error = "";
		// エラー文格納用
		String message = "";
		// 画面遷移用コマンド
		String cmd = "";
		//遷移先のパスを設定
		String path = "/jackworks";

		//オブジェクト生成
		MonthjackDAO monthJackDAO = new MonthjackDAO();
		Monthjack monthJack = new Monthjack();
		HttpSession session = request.getSession();

		try {

			//jackWorksの検索結果が格納されたjack_listを受け取る
			ArrayList<Jackworks> jackList = (ArrayList<Jackworks>) request.getAttribute("jack_list");
			//検索された文字(keyword)を受け取る
			String keyword = (String) request.getAttribute("keyword");

			//SearchJackworksからcmd=no-resultを受け取る
			cmd = (String) request.getAttribute("cmd");

			//画面遷移のための処理
			//後々消す(64まで)
			String cmd2 = request.getParameter("cmd");
			if (cmd2 != null) {
				cmd = cmd2;
			} else if (cmd2 == null) {
				cmd2 = "";
			}
			//ここまで削除

			//ぬるぽ対策
			if (cmd == null) {
				cmd = "";
			}

			//画面遷移のための処理
			//後々消す
			if (cmd.equals("change")) {
				path = "/view/monthJackworks.jsp";
			}
			
			//検索結果がある場合、JackWorks画面へ遷移
			if (jackList != null) {
				path = "/view/jackworks.jsp";
			}

			//MonthJackWorksの全情報を取得するメソッド
			monthJack = monthJackDAO.selectAll();

			//取得したmonthJackをリクエストスコープにmonthJackで登録
			session.setAttribute("monthJack", monthJack);
			request.setAttribute("cmd", cmd);
			request.setAttribute("keyword", keyword);
			
			//検索結果が格納されたjackListをリクエストスコープにjackListで登録
			request.setAttribute("jack_list", jackList);

		} catch (IllegalStateException e) {
			message = "システムの一時的な問題により、JackWorksの読み込みができませんでした。";
			error = "logout";
		} catch (Exception e) {
			message = "予期せぬエラーが発生しました。" + e;
			error = "logout";
		} finally {
			
			if (!("").equals(error)) {
				// 例外が発生する場合エラー文をリクエストスコープに"error"という名前で格納する
				request.setAttribute("error", message);
				// 例外が発生する場合エラー種類をリクエストスコープに"cmdという名前で格納する
				request.setAttribute("cmd", error);
				// error.jspにフォワード
				path = "/view/error.jsp";
			}

			if (("").equals(error)) {
				request.setAttribute("cmd", cmd);
			}

			request.getRequestDispatcher(path).forward(request, response);
		}

	}

	//以下ファイル出力のための処理
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// エラー用コマンド
		String error = "";
		// エラー文格納用
		String message = "";
		// 画面遷移用コマンド
		String cmd = "";
		//遷移先のパスを設定
		String path = "/jackworks";

		//オブジェクト生成
		MonthjackDAO monthJackDAO = new MonthjackDAO();
		Monthjack monthJack = new Monthjack();
		HttpSession session = request.getSession();

		try {

			//monthJackworks.jspから値を受け取る
			String theme = request.getParameter("theme");
			monthJack.setTheme(theme);
			String note = request.getParameter("note");
			monthJack.setNote(note);

			// ファイル取得用の情報を受け取る(更新の場合)
			Part filePart = request.getPart("image");

			//ファイル保存先を格納する用の変数設定
			String uploadDir = "";
			String filePath = "";

			//imageに関する情報の文字列取得
			String contentDisposition = filePart.getHeader("content-disposition");
			String fileName = "";
			//探したい文字列のパターンを定義
			Pattern pattern = Pattern.compile("filename=\"(.*)\"");
			//検索対象の文字列を格納
			Matcher matcher = pattern.matcher(contentDisposition);

			// ファイル名が存在していれば抽出
			if (matcher.find()) {
				//最初の(.*)に一致する文字列を返す
				fileName = matcher.group(1);

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
					//実際にファイルに保存を行う処理
					Files.copy(inputStream, new File(filePath).toPath(), StandardCopyOption.REPLACE_EXISTING);
				}

				monthJack.setImage(file_name.getName());

			} else {
				//登録されていたファイル名を使用する
				String image = request.getParameter("image");
				monthJack.setImage(image);
			}

			//テーマ更新を行うメソッド
			monthJackDAO.update(monthJack);
			//MonthJackWorksの全情報を取得するメソッド
			monthJack = monthJackDAO.selectAll();

			//取得したmonthJackをリクエストスコープにmonthJackで登録
			session.setAttribute("monthJack", monthJack);

		} catch (IllegalStateException e) {
			message = "システムの一時的な問題により、今月のテーマ情報の登録ができませんでした。";
			error = "logout";
		} catch (Exception e) {
			message = "予期せぬエラーが発生しました。" + e;
			error = "logout";
		} finally {
			
			if (!("").equals(error)) {
				// 例外が発生する場合エラー文をリクエストスコープに"error"という名前で格納する
				request.setAttribute("error", message);
				// 例外が発生する場合エラー種類をリクエストスコープに"cmdという名前で格納する
				request.setAttribute("cmd", error);
				// error.jspにフォワード
				path = "/view/error.jsp";
			}

			if (("").equals(error)) {
				request.setAttribute("cmd", cmd);
			}

			request.getRequestDispatcher(path).forward(request, response);
		}
	}

}
