package com.example.mangxahoi.Controller;

import com.example.mangxahoi.Service.PostService.PostService;
import com.example.mangxahoi.Service.PostService.PostServiceImpl;
import com.example.mangxahoi.SupportModel.PostSupportModel;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Comparator;
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
        List<PostSupportModel> postsWithLikeCount = postService.getPostOfFriends(userId);
        postsWithLikeCount.sort(new PostComparator());
        req.setAttribute("posts", postsWithLikeCount);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/home.jsp");
        dispatcher.forward(req, resp);
    }
    public static class PostComparator implements Comparator<PostSupportModel> {
        @Override
        public int compare(PostSupportModel post1, PostSupportModel post2) {
            return post2.getPost().getTimestamp().compareTo(post1.getPost().getTimestamp());
        }
    }

}
