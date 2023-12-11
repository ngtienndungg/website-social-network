package com.example.mangxahoi.Service.PostService;

import com.example.mangxahoi.Model.Post;

import java.util.List;

public interface PostService {
    List<Post> getPostByUserId(int userId);
}
