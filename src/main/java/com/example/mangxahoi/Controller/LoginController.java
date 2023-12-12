package com.example.mangxahoi.Controller;

import com.example.mangxahoi.Model.User;
import com.example.mangxahoi.Service.UserService.UserService;
import com.example.mangxahoi.Service.UserService.UserServiceImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/login.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String phoneNumber = req.getParameter("phoneNumber");
        String password = req.getParameter("password");
        UserService userService = new UserServiceImpl();
        User user = userService.authenticateUser(phoneNumber, password);
        if (user != null) {
            String userId = String.valueOf(user.getUserId());
            Cookie cookie = new Cookie("userId", userId);
            cookie.setMaxAge(60*60*24*60);
            resp.addCookie(cookie);
            resp.sendRedirect(req.getContextPath() + "/profile/" + userId);
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
        } else {
            resp.sendRedirect(req.getContextPath() + "/login?error=authenticationFailed");
        }
    }
}
