package com.example.mangxahoi.Service.PostService;

import com.example.mangxahoi.DAO.Post.PostDAO;
import com.example.mangxahoi.DAO.Post.PostDAOImpl;
import com.example.mangxahoi.Model.Post;

import java.util.List;

public class PostServiceImpl implements PostService {
    PostDAO postDAO = new PostDAOImpl();

    @Override
    public List<Post> getPostByUserId(int userId) {
        return postDAO.findPostByUserId(userId);
    }
}
