/*
 * プログラム名：Home-Jack.ver.2.0
 * 				 ユーザー一覧を取得する処理
 * 作成者：占部虎司郎
 * 作成日：2025/7/4
 * 更新日：2025/7/30
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
		
		// エラー文を格納用
		String error = "";
		// 例外判定用
		String cmd = "";
		// 遷移先のパス
		String path = "/view/userList.jsp";
		
		try {
			//UserDAOをインスタンス化する。
			UserDAO userDAO = new UserDAO();
			
			//ユーザー情報格納用の配列の宣言
			ArrayList<User> userList = new ArrayList<User>();
			
			//条件分岐用のcmdをリクエストスコープから受け取る
			cmd = (String)request.getParameter("cmd");
			
			//cmdのエラー回避
			if(cmd == null) {
				cmd = "";
			}
			
			//検索用パラメータの取得
			String inputPart = (String)request.getParameter("part");
			String inputGroup = (String)request.getParameter("group");
			String employeeNum = (String)request.getParameter("employeeNum");
			String text = (String)request.getParameter("text");
			
			//所属で検索するの場合の処理
			if(cmd.equals("search") && inputPart != null) {
				//各値をint型に変換
				int part = Integer.parseInt(inputPart);
				int group = Integer.parseInt(inputGroup);
				
				//検索メソッドの実行
				userList = userDAO.searchAffiliation(part,group);
			
			//社員番号で検索する場合の処理
			}else if(cmd.equals("search") && employeeNum != null){
				// 検索メソッドの実行
				userList = userDAO.search(employeeNum);
			
			//名前で検索する場合の処理
			}else if(cmd.equals("search") && text != null && !text.isEmpty()){	
				// 検索メソッドの実行
				userList = userDAO.search(text);

			//全情報を取得する場合の処理
			}else {
				//全情報取得メソッドの実行
				userList = userDAO.selectAll();
			}
			
			//取得したリストをuserListという名前でリクエストスコープに登録
			request.setAttribute("userList", userList);
			
		} catch (IllegalStateException e) {
			error = "DB接続エラーのため、個人情報一覧は表示出来ませんでした。";
			cmd = "logout";
		} catch (Exception e) {
			error = "予期せぬエラーが発生しました。" + e;
			cmd = "logout";
		} finally {
			if (error != "") {
				// 例外を発生する場合エラー文をリクエストスコープに"error"という名前で格納する
				request.setAttribute("error", error);
				// 例外を発生する場合エラー種類をリクエストスコープに"cmdという名前で格納する
				request.setAttribute("cmd", cmd);
				// error.jspにフォワード
				path = "/view/error.jsp";
			}
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
