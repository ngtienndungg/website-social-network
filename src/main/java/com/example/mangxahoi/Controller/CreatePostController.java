package com.example.mangxahoi.Controller;

import com.example.mangxahoi.Service.PostService.PostService;
import com.example.mangxahoi.Service.PostService.PostServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/upload-post")
public class CreatePostController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int userId = 0;
        req.setCharacterEncoding("UTF-8");
        Cookie[] cookies = req.getCookies();
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("userId")) {
                userId = Integer.parseInt(cookie.getValue());
            }
        }
        String postContent = req.getParameter("postContent");
        System.out.println(postContent);
        PostService postService = new PostServiceImpl();
        postService.uploadPost(userId, postContent, null);
        resp.sendRedirect(req.getContextPath() + "/profile/" + userId);
    }
}
