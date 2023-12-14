package com.example.mangxahoi.Controller;

import com.example.mangxahoi.Entity.User;
import com.example.mangxahoi.Service.FriendService.FriendService;
import com.example.mangxahoi.Service.FriendService.FriendServiceImpl;
import com.example.mangxahoi.Service.UserService.UserService;
import com.example.mangxahoi.Service.UserService.UserServiceImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/friend-list")
public class FriendListController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Cookie[] cookies = req.getCookies();
        int userId = 0;
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("userId")) {
                userId = Integer.parseInt(cookie.getValue());
            }
        }
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/profile.jsp");
        FriendService friendService = new FriendServiceImpl();
        List<User> friends = friendService.getFriendList(userId);
        UserService userService = new UserServiceImpl();
        User user = userService.getUserById(userId);
        req.setAttribute("user", user);
        req.setAttribute("friends", friends);
        dispatcher.forward(req, resp);
    }
}
