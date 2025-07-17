package servlet;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;

import bean.Announce;
import dao.AnnounceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/announceUpdate")
public class AnnounceUpdateServlet extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 変数宣言
		String error = "";
		String cmd = "";

		// オブジェクト生成
		Announce announce = new Announce();
		AnnounceDAO announceDAO = new AnnounceDAO();
		LocalDateTime localDateTime = null;


		try {

			// jspファイルからパラメータ取得
			int announceId = Integer.parseInt(request.getParameter("announceId"));
			String title = request.getParameter("title");
			String text = request.getParameter("text");

			// フォームから受け取った登録日時(String型)をLocalDateTimeに変換する
			String update = request.getParameter("updateDate");
			localDateTime = LocalDateTime.parse(update);

			// LocalDateTimeをTimestampに変換する(タイムゾーンを考慮)
			ZoneId zoneId = ZoneId.of("Asia/Tokyo");
			ZonedDateTime zonedDateTime = localDateTime.atZone(zoneId);
			Instant instant = zonedDateTime.toInstant();
			Timestamp updateDate = Timestamp.from(instant);

			// パラメータをAnnounceに格納する
			announce.setAnnounceId(announceId);
			announce.setTitle(title);
			announce.setUpdateDate(updateDate);
			announce.setText(text);

			// メソッドを呼び出してSQL文実行
			announceDAO.update(announce);

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
