package com.example.mangxahoi.Service.PostService;

import com.example.mangxahoi.DAO.PostDAO.PostDAO;
import com.example.mangxahoi.DAO.PostDAO.PostDAOImpl;
import com.example.mangxahoi.Entity.Post;

import java.util.List;

public class PostServiceImpl implements PostService {
    PostDAO postDAO = new PostDAOImpl();

    @Override
    public List<Post> getPostByUserId(int userId) {
        return postDAO.findPostByUserId(userId);
    }

    @Override
    public void uploadPost(int userId, String content, String image) {
        postDAO.createPost(userId, content, image);
    }

    @Override
    public List<Post> getPostOfFriends(int userId) {
        return postDAO.findPostsOfFriends(userId);
    }

    @Override
    public void actionLike(int userId, int postId) {
        postDAO.createLikeToPost(userId, postId);
    }
}
