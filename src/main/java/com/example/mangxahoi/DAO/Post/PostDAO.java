package com.example.mangxahoi.DAO.Post;

import com.example.mangxahoi.Model.Post;

import java.util.List;

public interface PostDAO {
    List<Post> findPostByUserId(int userId);
}
