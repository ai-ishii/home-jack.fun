package AddressChangeEditServlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/addressChangeRetouch")
	public class AddressChangeRetouchServlet extends HttpServlet {
	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        request.setCharacterEncoding("UTF-8");

	        Map<String, String> userInput = new HashMap<>();
	        // 必要なパラメータをすべて取得してMapに詰める
	        userInput.put("employeenumber", request.getParameter("employeenumber"));
	        userInput.put("name", request.getParameter("name"));
	        userInput.put("addressChangedDate", request.getParameter("addressChangedDate"));
	        userInput.put("oldpost", request.getParameter("oldpost"));
	        userInput.put("oldaddress", request.getParameter("oldaddress"));
	        userInput.put("newpost", request.getParameter("newpost"));
	        userInput.put("newaddress", request.getParameter("newaddress"));
	        userInput.put("neareststation", request.getParameter("neareststation"));

	        request.setAttribute("userInput", userInput);
	        // エラーがあればerrorsもセットする

	        request.getRequestDispatcher("/view/addressChangeForm.jsp").forward(request, response);
	    }
	}


