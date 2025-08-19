/*
 * 機能：セッションから受け取った申請内容をDAOに渡して保存処理を依頼する
 * 作成者：桑原岳
 * 最終更新日：2025/08/19
 */
package servlet;

import java.io.IOException;
import java.util.Map;

import dao.RequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/licenseKeep")
public class LicenseKeepServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userInput") == null) {
            response.sendRedirect(request.getContextPath() + "/view/licenseForm.jsp");
            return;
        }

        try {
            Map<String, Object> userInput = (Map<String, Object>) session.getAttribute("userInput");
            
            RequestDAO requestDAO = new RequestDAO();
            boolean isSuccess = requestDAO.insertLicenseRequest(userInput);

            if (isSuccess) {
                session.removeAttribute("userInput");
                response.sendRedirect(request.getContextPath() + "/view/complete.jsp");
            } else {
                throw new Exception("DAO returned false, indicating a failure to insert.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "データの保存中にエラーが発生しました。");
            request.getRequestDispatcher("/view/licenseForm.jsp").forward(request, response);
        }
    }
}