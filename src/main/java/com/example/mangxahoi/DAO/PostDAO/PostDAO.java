package com.example.mangxahoi.DAO.PostDAO;

import com.example.mangxahoi.Entity.Post;
import com.example.mangxahoi.SupportModel.PostSupportModel;

import java.util.List;

public interface PostDAO {
    List<PostSupportModel> findPostByUserId(int userId);
    void createPost(int userId, String content, String image);
    List<Post> findPostsOfFriends(int userId);
    void createLikeToPost(int userId, int postId);
    long countLikesForPost(int postId);
}
