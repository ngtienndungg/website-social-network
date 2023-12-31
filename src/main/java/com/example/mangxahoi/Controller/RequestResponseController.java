package com.example.mangxahoi.Controller;

import com.example.mangxahoi.Service.FriendService.FriendService;
import com.example.mangxahoi.Service.FriendService.FriendServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/request-response")
public class RequestResponseController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int friendID = Integer.parseInt(req.getParameter("friendID"));
        FriendService friendService = new FriendServiceImpl();
        Cookie[] cookies = req.getCookies();
        int userId = 0;
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("userId")) {
                userId = Integer.parseInt(cookie.getValue());
            }
        }
        friendService.acceptRequest(userId, friendID);
        if (req.getParameter("profile") != null) {
            resp.sendRedirect(req.getContextPath() + "/profile/" + friendID);
        } else {
            String redirectUrl = req.getContextPath() + "/friend-request";
            resp.sendRedirect(redirectUrl);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int friendID = Integer.parseInt(req.getParameter("friendID"));
        FriendService friendService = new FriendServiceImpl();
        Cookie[] cookies = req.getCookies();
        int userId = 0;
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("userId")) {
                userId = Integer.parseInt(cookie.getValue());
            }
        }
        friendService.rejectRequest(userId, friendID);
        if (req.getParameter("profile") != null) {
            resp.sendRedirect(req.getContextPath() + "/profile/" + friendID);
        } else {
            String redirectUrl = req.getContextPath() + "/friend-request";
            resp.sendRedirect(redirectUrl);
        }
    }
}
