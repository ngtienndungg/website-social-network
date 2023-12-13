package com.example.mangxahoi.Controller;

import com.example.mangxahoi.Model.User;
import com.example.mangxahoi.Service.UserService.UserService;
import com.example.mangxahoi.Service.UserService.UserServiceImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/register.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        boolean gender = Boolean.parseBoolean(request.getParameter("gender"));

        if (fullName != null && phoneNumber != null && email != null && password != null) {
            User newUser = userService.registerUser(fullName, phoneNumber, email, password, gender);
            if (newUser != null) {
                request.setAttribute("message", "Tạo tài khoản thành công!");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/register.jsp");
                dispatcher.forward(request, response);
            }
        } else {
            request.setAttribute("errorMessage", "Tạo tài khoản thất bại. Vui lòng thử lại!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/register.jsp");
            dispatcher.forward(request, response);
        }

    }
}
