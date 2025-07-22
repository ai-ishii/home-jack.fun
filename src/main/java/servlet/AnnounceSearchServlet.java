package servlet;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.Month;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;

import bean.Announce;
import dao.AnnounceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/announceSearch")
public class AnnounceSearchServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 変数宣言
		String error = "";
		String cmd = "";

		AnnounceDAO announceDAO = new AnnounceDAO();
		ArrayList<Announce> announceList = new ArrayList<Announce>();
		LocalDateTime localDateTimeStart = null;
		LocalDateTime localDateTimeEnd = null;
		
		// 時系列検索の際の初期値
		LocalDateTime defaultStart = LocalDateTime.of(2012, Month.APRIL, 17, 0, 0, 0);
		Timestamp startDate = Timestamp.valueOf(defaultStart);
		Timestamp endDate = new Timestamp(System.currentTimeMillis());
		

		// フォームから送信した検索方法をを受け取る
		cmd = request.getParameter("cmd");

		try {
			if (cmd.equals("keyword")) {
				String keyword = request.getParameter("keyword");

				announceList = announceDAO.selectByKeyword(keyword);
			}

			if (cmd.equals("filter")) {
				int announceFlag = Integer.parseInt(request.getParameter("announce_flag"));
				int categoryId = Integer.parseInt(request.getParameter("category_id"));
				String start = request.getParameter("startDate");
				String end = request.getParameter("endDate");

				ZoneId zoneId = ZoneId.of("Asia/Tokyo");

				if (start != "") {
					// フォームから受け取った開始日時(String型)をLocalDateTimeに変換する
					localDateTimeStart = LocalDateTime.parse(start);

					// LocalDateTimeをTimestampに変換する(タイムゾーンを考慮)
					ZonedDateTime zonedDateTimeStart = localDateTimeStart.atZone(zoneId);
					Instant instantStart = zonedDateTimeStart.toInstant();
					startDate = Timestamp.from(instantStart);
				}

				if (end != "") {
					localDateTimeEnd = LocalDateTime.parse(end);

					ZonedDateTime zonedDateTimeEnd = localDateTimeEnd.atZone(zoneId);
					Instant instantEnd = zonedDateTimeEnd.toInstant();
					endDate = Timestamp.from(instantEnd);
				}
				
				announceList = announceDAO.selectByFilter(announceFlag, categoryId, startDate, endDate);

			}

		} catch (Exception e) {
			cmd = "";
			error = "予期せぬエラーが発生しました。" + e;
		} finally {
			if (error != "") {
				request.setAttribute("cmd", cmd);
				request.setAttribute("error", error);
				request.getRequestDispatcher("").forward(request, response);
			}

			if (cmd.equals("keyword")) {
				request.setAttribute("announceList", announceList);
				request.getRequestDispatcher("/view/announce.jsp").forward(request, response);
			}
		}
	}

}
