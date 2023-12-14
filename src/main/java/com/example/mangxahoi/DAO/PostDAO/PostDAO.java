package com.example.mangxahoi.DAO.PostDAO;

import com.example.mangxahoi.Entity.Post;

import java.util.List;

public interface PostDAO {
    List<Post> findPostByUserId(int userId);
    void createPost(int userId, String content, String image);
}
