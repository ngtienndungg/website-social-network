package com.example.mangxahoi.Controller;

import com.example.mangxahoi.Model.User;
import com.example.mangxahoi.Service.FriendService.FriendService;
import com.example.mangxahoi.Service.FriendService.FriendServiceImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/friend-request")
public class FriendRequestController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Cookie[] cookies = req.getCookies();
        int userId = 0;
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("userId")) {
                userId = Integer.parseInt(cookie.getValue());
            }
        }
        FriendService friendService = new FriendServiceImpl();
        List<User> requestList = friendService.getRequestingList(userId);
        req.setAttribute("requestList", requestList);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/request.jsp");
        dispatcher.forward(req, resp);
    }
}
