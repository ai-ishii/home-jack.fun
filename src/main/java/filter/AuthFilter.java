/*
 * 権限分け
 * 
 * 作成者：月向亮太
 * 
 * 作成日：2025/8/25
 * 最終更新日: 2025/8/26
 */
package filter;

import java.io.IOException;
import java.util.ArrayList;

import bean.AuthorityHaving;
import dao.AuthorityDAO;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter({ "/jackworksRequest", "/momthJackworks" })
public class AuthFilter implements Filter {
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		//オブジェクト宣言
		AuthorityDAO autorityDAO = new AuthorityDAO();
		ArrayList<AuthorityHaving> authorityList = new ArrayList<AuthorityHaving>();
		//権限格納用
		String userRole = "";
		//権限があればtrue、なければfalse
		boolean flag = false;

		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		//現在のセッションを取得
		//false=セッションが存在しない場合に新しく作成しない
		HttpSession session = httpRequest.getSession(false);
		String cmd = (String) request.getAttribute("cmd");

		//セッションからユーザーIDを受け取る
		Integer userId = (Integer) session.getAttribute("user_id");
		//ユーザーIDから権限リストを取得するメソッド
		authorityList = autorityDAO.selectByUserId(userId);

		
		if (authorityList == null) {

		} else {
			for (int i = 0; i < authorityList.size(); i++) {
				AuthorityHaving authorityHaving = authorityList.get(i);
				userRole = authorityHaving.getAuthorityCode();

				//JackWorks承認者
				if ((userRole.equals("APR_JACK"))) {
					flag = true;

					//JackWorks承認者とマネージャー
				} else if ((userRole.equals("APR_JACK") || userRole.equals("POS_MNGR"))) {
					flag = true;
				}
			}
		}

		if (flag == false) {
			request.setAttribute("cmd", cmd);
			request.setAttribute("error", "このページにアクセスする権限がありません。");
			request.getRequestDispatcher("/view/error.jsp").forward(request, response);
		}

		if (flag == true) {
			//アクセス許可(本来のServletへ遷移)
			chain.doFilter(request, response);
		}
	}
}
