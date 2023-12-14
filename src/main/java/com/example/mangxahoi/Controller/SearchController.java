package com.example.mangxahoi.Controller;

import com.example.mangxahoi.Entity.User;
import com.example.mangxahoi.Service.UserService.UserService;
import com.example.mangxahoi.Service.UserService.UserServiceImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/search")
public class SearchController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/searchResult.jsp");
        String searchName = req.getParameter("name");
        UserService userService = new UserServiceImpl();
        List<User> users = userService.getUserByName(searchName);
        req.setAttribute("result", users);
        dispatcher.forward(req, resp);
    }
}
