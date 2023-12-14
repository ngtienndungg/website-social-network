package com.example.mangxahoi.Service.PostService;

import com.example.mangxahoi.Entity.Post;

import java.util.List;

public interface PostService {
    List<Post> getPostByUserId(int userId);
    void uploadPost(int userId, String content, String image);
}
