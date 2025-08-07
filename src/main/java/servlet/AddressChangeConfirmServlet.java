/*
 * 機能：住所変更確認機能
 * 
 * 作成者：桑原岳
 * 
 * 最終更新日：2025/08/07
 * 
 * */



package servlet;

import java.io.IOException;
import java.util.stream.Stream;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/addressChangeConfirm") 
public class AddressChangeConfirmServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. 文字コードを設定
        request.setCharacterEncoding("UTF-8");

        // 2. フォームから送られてきたデータを全て受け取る
        String employeeNumber = request.getParameter("employeenumber");
        String name = request.getParameter("name");
        String addressChangedDate = request.getParameter("addressChangedDate");
        String oldPost = request.getParameter("oldpost");
        String oldAddress = request.getParameter("oldaddress");
        String newPost = request.getParameter("newpost");
        String newAddress = request.getParameter("newaddress");
        String nearestStation = request.getParameter("neareststation");
        
        boolean hasMissingFields = Stream.of(
                employeeNumber, name, addressChangedDate, oldPost, oldAddress, 
                newPost, newAddress, nearestStation)
            .anyMatch(s -> s == null || s.trim().isEmpty());

        if (hasMissingFields) {
            // 1つでも未入力項目があった場合
            request.setAttribute("errorMessage", "入力されていない項目があります。");
            
            // 元の入力フォームに戻す
            getServletContext().getRequestDispatcher("/view/addressChangeForm.jsp").forward(request, response);
            
            // これ以上処理を進めないようにここで終了
            return; 
        }
        
        // 3. 受け取ったデータを「リクエストスコープ」に格納する
        //    こうすることで、次のJSPでこの値を表示できる
        request.setAttribute("employeeNumber", employeeNumber);
        request.setAttribute("name", name);
        request.setAttribute("addressChangedDate", addressChangedDate);
        request.setAttribute("oldPost", oldPost);
        request.setAttribute("oldAddress", oldAddress);
        request.setAttribute("newPost", newPost);
        request.setAttribute("newAddress", newAddress);
        request.setAttribute("nearestStation", nearestStation);

        // 4. 確認画面JSPに処理を引き継ぐ（フォワード）
        getServletContext().getRequestDispatcher("/view/confirm.jsp").forward(request, response);
    }
}