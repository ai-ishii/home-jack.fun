/**
 * お知らせを検索して一覧表示するサーブレット
 * 
 * 作成者 : 大北直弥
 * 
 * 作成日 : 2025/07/14
 * 更新日 : 2025/08/05
 */
package servlet;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.Month;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeParseException;
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
		
		String search = "";

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
		search = request.getParameter("cmd");
		
		if(search == null) {
			search = "";
		}

		try {
			//検索の場合
			if ("keyword".equals(search)) {
				// フォームからパラメータを受け取る
				String keyword = request.getParameter("keyword");

				// メソッドを呼び出してSQL文実行
				announceList = announceDAO.selectByKeyword(keyword);
				
				//検索結果が0件の場合
				if(announceList.size() == 0) {
					search = "no-result";
				}
				
				// 検索キーワードをリクエストスコープに登録する
				request.setAttribute("keyword", keyword);
			}

			//フィルターの場合
			if ("filter".equals(search)) {
				// フォームからパラメータを受け取る
				String announceFlag = request.getParameter("announce_flag");
				String strAnnounceCategoryId = request.getParameter("category_id");
				String start = request.getParameter("start_date");
				String end = request.getParameter("end_date");

				// パラメータをリクエストスコープに登録する
				request.setAttribute("announceFlag", announceFlag);
				if (!("").equals(strAnnounceCategoryId)) {
					int announceCategoryId = Integer.parseInt(strAnnounceCategoryId);
					request.setAttribute("announceCategoryId", announceCategoryId);
				}

				ZoneId zoneId = ZoneId.of("Asia/Tokyo");

				if (!("").equals(start)) {
					// フォームから受け取った開始日時(String型)をLocalDateTimeに変換する
					localDateTimeStart = LocalDateTime.parse(start);

					// パラメータをリクエストスコープに登録する
					request.setAttribute("localDateTimeStart", localDateTimeStart);

					// LocalDateTimeをTimestampに変換する(タイムゾーンを考慮)
					ZonedDateTime zonedDateTimeStart = localDateTimeStart.atZone(zoneId);
					Instant instantStart = zonedDateTimeStart.toInstant();
					startDate = Timestamp.from(instantStart);
				}

				if (!("").equals(end)) {
					// フォームから受け取った開始日時(String型)をLocalDateTimeに変換する
					localDateTimeEnd = LocalDateTime.parse(end);

					// パラメータをリクエストスコープに登録する
					request.setAttribute("localDateTimeEnd", localDateTimeEnd);

					// LocalDateTimeをTimestampに変換する(タイムゾーンを考慮)
					ZonedDateTime zonedDateTimeEnd = localDateTimeEnd.atZone(zoneId);
					Instant instantEnd = zonedDateTimeEnd.toInstant();
					endDate = Timestamp.from(instantEnd);
				}

				announceList = announceDAO.selectByFilter(announceFlag, strAnnounceCategoryId, startDate, endDate);
				
				//絞り込み結果が0件の場合
				if(announceList.size() == 0) {
					search = "no-result";
				}

			}

			categoryList = announceDAO.selectCategoryAll();

		} catch (DateTimeParseException e) {
			error = "DB接続エラーのため、お知らせの検索結果は表示できませんでした";
			//ログイン画面へ遷移
			cmd = "logout";	
		} catch (IllegalStateException e) {
			error = "DB接続エラーのため、お知らせの検索結果は表示できませんでした";
			//ログイン画面へ遷移
			cmd = "logout";
		} catch (Exception e) {
			error = "予期せぬエラーが発生しました。" + e;
			cmd = "logout";
		} finally {
			if (error != "") {
				request.setAttribute("cmd", cmd);
				request.setAttribute("error", error);
				request.getRequestDispatcher("/view/error.jsp").forward(request, response);
			}

			request.setAttribute("cmd", cmd);
			request.setAttribute("announceList", announceList);
			request.setAttribute("categoryList", categoryList);
			request.getRequestDispatcher("/view/announce.jsp").forward(request, response);
		}
	}

}
