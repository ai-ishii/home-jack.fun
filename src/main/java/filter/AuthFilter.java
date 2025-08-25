package filter;

import java.io.IOException;

import bean.User;
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

		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		HttpSession session = httpRequest.getSession(false);
		
		String userRole = (session!= null) ? (String) session.getAttribute("userRole") : null;
		
		if (userRole != null && (userRole.equals("ADMIN") || userRole.equals("MANAGER"))) {
	         chain.doFilter(request, response);
	         
	     } else {
	         request.setAttribute("error", "このページにアクセスする権限がありません。");
	         request.getRequestDispatcher("/view/error.jsp").forward(request, response);
	     }
		
	}
}
