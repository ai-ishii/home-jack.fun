/*
 * プログラム名：Home-Jack.ver.2.0
 * 				 検索処理を行う
 * 作成者：占部虎司郎
 * 作成日：2025/7/10
 * 更新日：2025/7/30
 */

//いらなくなってしまった

package servlet;

//@WebServlet("/userSearch")
//public class UserSearchServlet extends HttpServlet {
//	private ObjectMapper objectMapper = new ObjectMapper(); 
//	
//	public void doGet(HttpServletRequest request, HttpServletResponse response)
//			throws ServletException, IOException {
//		// DAOオブジェクトの宣言
//		UserDAO userDAO = new UserDAO();
//		
//		//ArrayListの宣言
//		ArrayList<User> userList = new ArrayList<User>();
//
//		try {
//			// パラメータの取得
//			String keyword = "";
//			keyword = (String)request.getParameter("employeeNum");
//			keyword = (String)request.getParameter("text");
//			String inputPart = (String)request.getParameter("part");
//			String inputGroup = (String)request.getParameter("group");
//			
//			//所属で検索された場合の処理
//			if(inputPart != null && !inputPart.isEmpty()) {
//				int part = Integer.parseInt(inputPart);
//				int group = Integer.parseInt(inputGroup);
//				userList = userDAO.searchAffiliation(part,group);
//				
//			}else {
//
//				if(keyword == null) {
//					keyword = "";
//				}
//			
//				// メソッドを呼び出し
//				userList = userDAO.search(keyword);
//
//			}
//
//			if (userList == null) {
//				userList = new  ArrayList<>();
//			}
//			
//			 // ★AJAX応答の核心：List<User>をJSONに変換して返す★
//			response.setContentType("application/json"); // 応答のMIMEタイプをJSONに設定
//            response.setCharacterEncoding("UTF-8"); // 文字コードをUTF-8に設定
//            PrintWriter out = response.getWriter();
//            
//            // userListオブジェクトをJSON文字列に変換して出力
//            objectMapper.writeValue(out, userList);
//            out.flush(); // 出力をフラッシュ
//
//			
//		} catch (IllegalStateException e) {
//			 System.err.println("DEBUG Servlet: IllegalStateException (DB接続エラー): " + e.getMessage());
//			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "データベース接続エラー");
//		} catch (Exception e) {
//			System.err.println("DEBUG Servlet: 予期せぬエラー: " + e.getMessage());
//			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "サーバー内部エラー");
//		}
//
//	}
//}
