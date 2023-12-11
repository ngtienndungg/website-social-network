package com.example.mangxahoi.Controller;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Cookie[] cookies = req.getCookies();
        for (Cookie cookie : cookies) {
            if ("userId".equals(cookie.getName())) {
                Cookie deleteCookie = new Cookie("userId", null);
                deleteCookie.setMaxAge(0);
                resp.addCookie(deleteCookie);
            }
            resp.addCookie(cookie);

        }
        resp.sendRedirect(req.getContextPath() + "/login");
    }
}
