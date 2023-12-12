package com.example.mangxahoi.Controller;

import com.example.mangxahoi.Model.User;
import com.example.mangxahoi.Service.UserService.UserService;
import com.example.mangxahoi.Service.UserService.UserServiceImpl;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
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
        // Lấy thông tin từ form
        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Kiểm tra xem các thông tin có hợp lệ không
        if (fullName != null && phoneNumber != null && email != null && password != null) {
            // Thực hiện tạo tài khoản
            User newUser = userService.createUser(fullName, phoneNumber, email, password);
            if (newUser != null){
                request.setAttribute("message", "Tạo tài khoản thành công!");
                // Forward back to the register page
                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/register.jsp");
                dispatcher.forward(request, response);
            }
            } else {
                request.setAttribute("errorMessage", "Tạo tài khoản thất bại. Vui lòng thử lại!");
                // Forward back to the register page
                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/register.jsp");
                dispatcher.forward(request, response);
        }

    }
}
