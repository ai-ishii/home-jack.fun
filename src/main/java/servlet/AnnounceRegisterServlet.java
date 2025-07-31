/**
 * お知らせを登録するサーブレット
 * 
 * 作成者 : 大北直弥
 * 
 * 作成日 : 2025/07/14
 * 更新日 : 2025/07/30
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

@WebServlet("/announceRegister")
public class AnnounceRegisterServlet extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 受け取る文字のコードを指定
		request.setCharacterEncoding("UTF-8");

		// 変数宣言
		String error = "";
		String cmd = "";

		// オブジェクト生成
		Announce announce = new Announce();
		AnnounceDAO announceDAO = new AnnounceDAO();
		LocalDateTime localDateTime = null;

		try {

			// jspファイルからパラメータ取得
			String title = request.getParameter("title");
			String text = request.getParameter("text");
			int announceFlag = Integer.parseInt(request.getParameter("announce_flag"));
			int categoryId = Integer.parseInt(request.getParameter("category_id"));

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

			// メソッドを呼び出してSQL文を実行する
			announceDAO.regist(announce);

		} catch (DateTimeParseException e) {

			cmd = "";
			error = "日付時刻の解析に失敗しました。";

		} catch (Exception e) {
			cmd = "";
			error = "予期せぬエラーが発生しました。" + e;

		} finally {

			if (error != "") {
				request.setAttribute("cmd", cmd);
				request.setAttribute("error", error);
				request.getRequestDispatcher("#").forward(request, response);
			}

			request.getRequestDispatcher("/announce").forward(request, response);
		}
	}

}
