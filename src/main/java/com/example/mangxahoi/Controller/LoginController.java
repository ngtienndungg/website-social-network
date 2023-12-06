package com.example.mangxahoi.Controller;

import com.example.mangxahoi.Service.UserService.UserService;
import com.example.mangxahoi.Service.UserService.UserServiceImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/login.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String phoneNumber = req.getParameter("phoneNumber");
        String password = req.getParameter("password");
        UserService userService = new UserServiceImpl();
        if (userService.authenticateUser(phoneNumber, password) != null) {
            PrintWriter out = resp.getWriter();
            out.println("<html><body>");
            out.println("<h1>" + "Login Success" + "</h1>");
            out.println("</body></html>");
        } else {
            PrintWriter out = resp.getWriter();
            out.println("<html><body>");
            out.println("<h1>" + "Login Failed" + "</h1>");
            out.println("</body></html>");
        }
    }
}
