/*
 * 機能:確定ボタンを押したときに確定情報をDBに登録する機能
 * 作成者：桑原岳
 * 最終更新日：2025/08/22
 */
package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/licenseKeep")
public class LicenseKeepServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}