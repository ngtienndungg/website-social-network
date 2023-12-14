package com.example.mangxahoi.Controller;

import com.example.mangxahoi.Service.PostService.PostService;
import com.example.mangxahoi.Service.PostService.PostServiceImpl;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;

@WebServlet("/action-like")
public class ActionLikeController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        System.out.println("LIKE DID");

        StringBuilder stringBuilder = new StringBuilder();
        BufferedReader bufferedReader = req.getReader();
        String line;
        while ((line = bufferedReader.readLine()) != null) {
            stringBuilder.append(line);
        }

        JsonObject jsonObject = JsonParser.parseString(stringBuilder.toString()).getAsJsonObject();

        if (jsonObject.get("postId") == null) {
            System.out.println("Post ID null");
        }

        Cookie[] cookies = req.getCookies();
        int userId = 0;
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("userId")) {
                userId = Integer.parseInt(cookie.getValue());
            }
        }

        String action = jsonObject.get("action").getAsString();
        int postId = jsonObject.get("postId").getAsInt();

        System.out.println("Action: " + action + " / postId:" + postId);
        PostService postService = new PostServiceImpl();
        if ("like".equals(action)) {
            postService.actionLike(userId, postId);
        }

        resp.setContentType("application/json");
        resp.getWriter().write("{\"status\": \"success\"}");
    }
}

