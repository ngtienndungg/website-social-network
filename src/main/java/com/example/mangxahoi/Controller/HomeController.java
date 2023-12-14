package com.example.mangxahoi.Controller;

import com.example.mangxahoi.Entity.Post;
import com.example.mangxahoi.Service.PostService.PostService;
import com.example.mangxahoi.Service.PostService.PostServiceImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Cookie[] cookies = req.getCookies();
        int userId = 0;
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("userId")) {
                userId = Integer.parseInt(cookie.getValue());
            }
        }
        PostService postService = new PostServiceImpl();
        List<Post> posts = postService.getPostOfFriends(userId);
        System.out.println("SIZE " + posts.size());
        for (Post post : posts) {
            System.out.println(post.getContent());
        }
        req.setAttribute("posts", posts);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/home.jsp");
        dispatcher.forward(req, resp);
    }
}
