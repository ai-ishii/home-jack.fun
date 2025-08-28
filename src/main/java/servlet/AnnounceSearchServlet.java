/**
 * お知らせを検索して一覧表示するサーブレット
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

		// エラー用フラグ
		boolean error = false;
		// 画面遷移用コマンド
		String cmd = "";
		// エラー文格納用
		String message = "";
		// 遷移先のパス
		String path = "/view/announce.jsp";

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
		try {

			// 時系列検索の際の初期値
			LocalDateTime defaultStart = LocalDateTime.of(year, month, day, hour, minute, second);
			Timestamp startDate = Timestamp.valueOf(defaultStart);
			Timestamp endDate = new Timestamp(System.currentTimeMillis());

			// フォームから送信した検索方法をを受け取る
			cmd = request.getParameter("cmd");

			if (cmd == null) {
				cmd = "";
			}
			
			//検索の場合
			if ("keyword".equals(cmd)) {
				// フォームからパラメータを受け取る
				String keyword = request.getParameter("keyword");

				// メソッドを呼び出してSQL文実行
				announceList = announceDAO.selectByKeyword(keyword);

				//検索結果が0件の場合
				if (announceList.size() == 0) {
					cmd = "no-result";
				}

				// 検索キーワードをリクエストスコープに登録する
				request.setAttribute("keyword", keyword);
			}

			//フィルターの場合
			if ("filter".equals(cmd)) {
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
				if (announceList.size() == 0) {
					cmd = "no-result";
				}

			}

			categoryList = announceDAO.selectCategoryAll();

		} catch (DateTimeParseException e) {
			error = true;
			//お知らせ登録画面へ遷移
			cmd = "announce";
			message = "時刻の読み取りに失敗しました。";
		} catch (NumberFormatException e) {
			error = true;
			cmd = "logout";
			message = "不正な操作を検知しました。";
		} catch (IllegalStateException e) {
			error = true;
			//ログイン画面へ遷移
			cmd = "logout";
			message = "システムの一時的な問題により、検索結果の読み込みができませんでした。";
		} catch (Exception e) {
			error = true;
			cmd = "logout";
			message = "予期せぬエラーが発生しました。" + e;
			
		} finally {
			if (error) {
				// 例外が発生する場合エラー文をリクエストスコープに"error"という名前で格納する
				request.setAttribute("error", message);
				// 例外が発生する場合エラー種類をリクエストスコープに"cmdという名前で格納する
				request.setAttribute("cmd", cmd);
				// error.jspにフォワード
				path = "/view/error.jsp";
			}

			if (!error) {
				request.setAttribute("cmd", cmd);
				request.setAttribute("announceList", announceList);
				request.setAttribute("categoryList", categoryList);
			}
			
			request.getRequestDispatcher(path).forward(request, response);
		}
	}

}
