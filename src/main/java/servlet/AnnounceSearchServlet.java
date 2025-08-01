/**
 * お知らせを検索して一覧表示するサーブレット
 * 
 * 作成者 : 大北直弥
 * 
 * 作成日 : 2025/07/14
 * 更新日 : 2025/08/01
 */
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
import bean.CategoryMap;
import dao.AnnounceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/announceSearch")
public class AnnounceSearchServlet extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 変数宣言
		String error = "";
		String cmd = "";
		
		// 日付検索の初期値の設定
		int year = 2012;
		Month month = Month.APRIL;
		int day = 17;
		int hour = 0;
		int minute = 0;
		int second = 0;

		// オブジェクト生成
		AnnounceDAO announceDAO = new AnnounceDAO();
		ArrayList<Announce> announceList = new ArrayList<Announce>();
		ArrayList<CategoryMap> categoryList = new ArrayList<CategoryMap>();
		LocalDateTime localDateTimeStart = null;
		LocalDateTime localDateTimeEnd = null;

		// 時系列検索の際の初期値
		LocalDateTime defaultStart = LocalDateTime.of(year, month, day, hour, minute, second);
		Timestamp startDate = Timestamp.valueOf(defaultStart);
		Timestamp endDate = new Timestamp(System.currentTimeMillis());

		// フォームから送信した検索方法をを受け取る
		cmd = request.getParameter("cmd");

		try {
			if (cmd.equals("keyword")) {
				// フォームからパラメータを受け取る
				String keyword = request.getParameter("keyword");

				// メソッドを呼び出してSQL文実行
				announceList = announceDAO.selectByKeyword(keyword);
				
				// 検索キーワードをリクエストスコープに登録する
				request.setAttribute("keyword", keyword);
			}

			if (cmd.equals("filter")) {
				// フォームからパラメータを受け取る
				String announceFlag = request.getParameter("announce_flag");
				String categoryId = request.getParameter("category_id");

				String start = request.getParameter("start_date");
				String end = request.getParameter("end_date");

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
			
			categoryList = announceDAO.selectCategoryAll();

		} catch (Exception e) {
			cmd = "";
			error = "予期せぬエラーが発生しました。" + e;
		} finally {
			if (error != "") {
				request.setAttribute("cmd", cmd);
				request.setAttribute("error", error);
				request.getRequestDispatcher("").forward(request, response);
			}

			request.setAttribute("cmd", cmd);
			request.setAttribute("announceList", announceList);
			request.setAttribute("categoryList", categoryList);
			request.getRequestDispatcher("/view/announce.jsp").forward(request, response);
		}
	}

}
