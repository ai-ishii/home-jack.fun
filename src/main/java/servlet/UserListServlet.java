/*
 * プログラム名：Home-Jack.ver.2.0
 * 				 ユーザー一覧を取得する処理
 * 作成者：占部虎司郎
 * 作成日：2025/7/4
 * 更新日：2025/8/27
 */

package servlet;

import java.io.IOException;
import java.util.ArrayList;

import bean.User;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/userList")
public class UserListServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// エラー用フラグ
		boolean error = false;
		// 画面遷移用コマンド
		String cmd = "";
		// エラー文格納用
		String message = "";
		// 遷移先のパス
		String path = "/view/userList.jsp";
		//検索のキーワードを格納
		String keyword = "";

		//UserDAOをインスタンス化する
		UserDAO userDAO = new UserDAO();
		//ユーザー情報格納用の配列の宣言
		ArrayList<User> userList = new ArrayList<User>();

		try {

			//条件分岐用のcmdをリクエストスコープから受け取る
			cmd = (String) request.getParameter("cmd");

			//cmdのエラー回避
			if (cmd == null) {
				cmd = "";
				//全情報取得メソッドの実行
				userList = userDAO.selectAll();
				return;
			}

			//検索用パラメータの取得
			String inputPart = (String) request.getParameter("part");
			String inputGroup = (String) request.getParameter("group");
			String employeeNum = (String) request.getParameter("employeeNum");
			String text = (String) request.getParameter("text");
			keyword = (String) request.getParameter("keyword");

			if (keyword == null) {
				keyword = "";
			}

			//検索があれば
			if ("search".equals(cmd)) {

				//所属で検索するの場合の処理
				if (inputPart != null) {
					//各値をint型に変換
					int part = Integer.parseInt(inputPart);
					int group = Integer.parseInt(inputGroup);

					//検索メソッドの実行
					userList = userDAO.searchAffiliation(part, group);
				}

				//社員番号で検索する場合の処理
				if (employeeNum != null) {
					// 検索メソッドの実行
					userList = userDAO.search(employeeNum);

					//名前で検索する場合の処理
				}

				if (text != null && !text.isEmpty()) {
					// 検索メソッドの実行
					userList = userDAO.search(text);
				}

				//検索結果が0件の場合
				if (userList.size() == 0) {
					cmd = "no-result";
				}
				return;
			}

			if (!error) {
				error = true;
				cmd = "logout";
				message = "不正な操作を検知しました。";
			}

		} catch (IllegalStateException e) {
			error = true;
			cmd = "logout";
			message = "システムの一時的な問題により、個人情報の読み込みができませんでした。";
		} catch (Exception e) {
			error = true;
			cmd = "logout";
			message = "予期せぬエラーが発生しました。" + e;
		} finally {

			if (error) {
				// 例外が発生する場合エラー文をリクエストスコープに"error"という名前で格納する
				request.setAttribute("message", message);
				// error.jspにフォワード
				path = "/view/error.jsp";
			}

			if (!error) {
				//取得したリストをuserListという名前でリクエストスコープに登録
				request.setAttribute("userList", userList);
				//キーワードをリクエストスコープに登録
				request.setAttribute("keyword", keyword);
			}

			request.setAttribute("cmd", cmd);
			// pathにフォワード
			request.getRequestDispatcher(path).forward(request, response);
		}

	}

	/**
	 * 所属で検索された場合のメソッド
	 * @param inputPart
	 * @param inputGroup
	 * @return userList 検索された情報
	 */
	//	public ArrayList<User> searchAffiliationJs(String inputPart, String inputGroup){
	//		// DAOオブジェクトの宣言
	//		UserDAO userDAO = new UserDAO();
	//		
	//		//ArrayListの宣言
	//		ArrayList<User> userList = new ArrayList<User>();
	//
	//		try {
	//			//int型に変換
	//			int part = Integer.parseInt(inputPart);
	//			int group = Integer.parseInt(inputGroup);
	//			
	//			//検索メソッドの実行
	//			userList = userDAO.searchAffiliation(part,group);
	//			
	//		} catch (Exception e) {
	//			throw new IllegalStateException(e);
	//		} finally {
	//		}
	//		return userList;
	//	}

	/**
	 * 名前、社員番号で検索されたときのメソッド
	 * @param keyword
	 * @return userList 検索された情報
	 */
	//	public ArrayList<User> searchJs(String keyword){
	//		// DAOオブジェクトの宣言
	//		UserDAO userDAO = new UserDAO();
	//		
	//		//ArrayListの宣言
	//		ArrayList<User> userList = new ArrayList<User>();
	//
	//		try {
	//			// メソッドを呼び出し
	//			userList = userDAO.search(keyword);
	//			
	//		} catch (Exception e) {
	//			throw new IllegalStateException(e);
	//		} finally {
	//		}
	//		return userList;
	//	}
}
