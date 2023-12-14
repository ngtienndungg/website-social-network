package com.example.mangxahoi.Service.PostService;

import com.example.mangxahoi.Entity.Post;

import java.util.List;

public interface PostService {
    List<Post> getPostByUserId(int userId);
    void uploadPost(int userId, String content, String image);
    List<Post> getPostOfFriends(int userId);
    void actionLike(int userId, int postId);
}
