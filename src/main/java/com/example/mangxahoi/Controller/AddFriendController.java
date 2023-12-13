package com.example.mangxahoi.Controller;

import com.example.mangxahoi.Service.FriendService.FriendService;
import com.example.mangxahoi.Service.FriendService.FriendServiceImpl;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/add-friend")
public class AddFriendController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int userId = 0;
        Cookie[] cookies = req.getCookies();
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("userId")) {
                userId = Integer.parseInt(cookie.getValue());
            }
        }
        System.out.println();
        FriendService friendService = new FriendServiceImpl();
        friendService.addFriend(userId, Integer.parseInt(req.getParameter("friendId")));
        resp.sendRedirect(req.getContextPath() + "/profile/" + req.getParameter("friendId"));
    }
}
