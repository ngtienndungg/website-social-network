package com.example.mangxahoi.Controller;

import com.example.mangxahoi.Entity.Post;
import com.example.mangxahoi.Entity.User;
import com.example.mangxahoi.Service.FriendService.FriendService;
import com.example.mangxahoi.Service.FriendService.FriendServiceImpl;
import com.example.mangxahoi.Service.PostService.PostService;
import com.example.mangxahoi.Service.PostService.PostServiceImpl;
import com.example.mangxahoi.Service.UserService.UserService;
import com.example.mangxahoi.Service.UserService.UserServiceImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Comparator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/profile/*")
public class ProfileController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        req.setCharacterEncoding("UTF-8");
        System.out.println(pathInfo);
        UserService userService = new UserServiceImpl();
        PostService postService = new PostServiceImpl();

        if (pathInfo != null) {
            if (pathInfo.matches("/\\d+")) {
                try {
                    String userId = pathInfo.substring(1);
                    RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/profile.jsp");
                    User user = userService.getUserById(Integer.parseInt(userId));
                    List<Post> post = postService.getPostByUserId(Integer.parseInt(userId));
                    post.sort(new PostComparator());
                    Logger.getLogger(ProfileController.class.getName()).log(Level.INFO, String.valueOf(post.size()));
                    req.setAttribute("pathInfo", userId);
                    System.out.println(userId);
                    FriendService friendService = new FriendServiceImpl();
                    List<User> friends = friendService.getFriendList(Integer.parseInt(userId));
                    req.setAttribute("friends", friends);
                    req.setAttribute("post", post);
                    req.setAttribute("user", user);
                    dispatcher.forward(req, resp);
                } catch (NumberFormatException e) {
                    Logger.getLogger(ProfileController.class.getName()).log(Level.SEVERE, "Invalid userId format", e);
                    resp.sendRedirect(req.getContextPath() + "/errorPage.jsp");
                }
            } else if (pathInfo.matches("/\\d+/updateprofile")) {
                try {
                    String userId = pathInfo.split("/")[1];
                    RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/updateProfile.jsp");
                    User user = userService.getUserById(Integer.parseInt(userId));
                    req.setAttribute("user", user);
                    dispatcher.forward(req, resp);
                } catch (NumberFormatException e) {
                    Logger.getLogger(ProfileController.class.getName()).log(Level.SEVERE, "Invalid userId format", e);
                    resp.sendRedirect(req.getContextPath() + "/errorPage.jsp");
                }
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/errorPage.jsp");
        }
    }
    public static class PostComparator implements Comparator<Post> {
        @Override
        public int compare(Post post1, Post post2) {
            return post2.getTimestamp().compareTo(post1.getTimestamp());
        }
    }
}

