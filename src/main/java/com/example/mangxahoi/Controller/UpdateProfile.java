package com.example.mangxahoi.Controller;

import com.example.mangxahoi.Model.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/updateprofile")
public class UpdateProfile extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin người dùng từ request
        String fullName = request.getParameter("fullName");
        String biography = request.getParameter("biography");
        String email = request.getParameter("email");
        boolean gender = Boolean.parseBoolean(request.getParameter("gender"));

        // Cập nhật cơ sở dữ liệu

        // Cập nhật thông tin trong session
        User user = (User) request.getSession().getAttribute("user");
        user.setFullName(fullName);
        user.setBiography(biography);
        user.setEmail(email);
        user.setGender(gender);

        // Chuyển hướng người dùng đến trang /profile
        response.sendRedirect("/MangXaHoi/profile/" + user.getUserId());
    }
}
