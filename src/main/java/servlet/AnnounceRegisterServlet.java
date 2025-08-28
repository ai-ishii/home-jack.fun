/**
 * お知らせを登録するサーブレット
 * 
 * 作成者 : 大北直弥
 * 
 * 作成日 : 2025/07/14
 * 更新日 : 2025/08/25
 */
package servlet;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeParseException;

import bean.Announce;
import dao.AnnounceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/announceRegister")
public class AnnounceRegisterServlet extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 受け取る文字のコードを指定
		request.setCharacterEncoding("UTF-8");

		// エラー用フラグ
		boolean error = false;
		// 画面遷移用コマンド
		String cmd = "";
		// エラー文格納用
		String message = "";
		// 遷移先のパス
		String path = "/announce";

		// オブジェクト生成
		Announce announce = new Announce();
		AnnounceDAO announceDAO = new AnnounceDAO();
		LocalDateTime localDateTime = null;
		HttpSession session = request.getSession();

		try {

			// jspファイルからパラメータ取得
			String title = request.getParameter("title");
			String text = request.getParameter("text");
			int announceFlag = Integer.parseInt(request.getParameter("announce_flag"));
			int categoryId = Integer.parseInt(request.getParameter("category_id"));

			// セッションから情報を取得する
			String author = (String) session.getAttribute("user_name");

			// フォームから受け取った登録日時(String型)をLocalDateTimeに変換する
			String regist = request.getParameter("regist_date");
			localDateTime = LocalDateTime.parse(regist);

			// LocalDateTimeをTimestampに変換する(タイムゾーンを考慮)
			ZoneId zoneId = ZoneId.of("Asia/Tokyo");
			ZonedDateTime zonedDateTime = localDateTime.atZone(zoneId);
			Instant instant = zonedDateTime.toInstant();
			Timestamp registDate = Timestamp.from(instant);

			// パラメータをAnnounceに格納する
			announce.setTitle(title);
			announce.setRegistDate(registDate);
			announce.setText(text);
			announce.setAnnounceFlag(announceFlag);
			announce.setAnnounceCategoryId(categoryId);
			announce.setName(author);

			// メソッドを呼び出してSQL文を実行する
			announceDAO.regist(announce);

		} catch (DateTimeParseException e) {
			error = true;
			//お知らせ登録画面へ遷移先を指定
			cmd = "announce";
			message = "時刻の読み取りに失敗しました。";
		} catch (NumberFormatException e) {
			error = true;
			cmd = "logout";
			message = "不正な操作を検知しました。";
		} catch (IllegalStateException e) {
			error = true;
			//ログイン画面へ遷移先を指定
			cmd = "logout";
			message = "システムの一時的な問題により、お知らせ情報の登録ができませんでした。";
		} catch (Exception e) {
			error = true;
			//ログイン画面へ遷移先を指定
			cmd = "logout";
			message = "予期せぬエラーが発生しました。" + e;
			
		} finally {

			if (error) {
				// 例外が発生する場合エラー文をリクエストスコープに"error"という名前で格納する
				request.setAttribute("message", message);
				// 例外が発生する場合エラー種類をリクエストスコープに"cmdという名前で格納する
				request.setAttribute("cmd", cmd);
				// error.jspにフォワード
				path = "/view/error.jsp";
			}

			request.getRequestDispatcher(path).forward(request, response);
		}
	}

}
