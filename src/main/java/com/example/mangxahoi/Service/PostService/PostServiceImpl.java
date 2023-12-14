package com.example.mangxahoi.Service.PostService;

import com.example.mangxahoi.DAO.PostDAO.PostDAO;
import com.example.mangxahoi.DAO.PostDAO.PostDAOImpl;
import com.example.mangxahoi.Entity.Post;
import com.example.mangxahoi.SupportModel.PostSupportModel;

import java.util.ArrayList;
import java.util.List;

public class PostServiceImpl implements PostService {
    PostDAO postDAO = new PostDAOImpl();

    @Override
    public List<PostSupportModel> getPostByUserId(int userId) {
        return postDAO.findPostByUserId(userId);
    }

    @Override
    public void uploadPost(int userId, String content, String image) {
        postDAO.createPost(userId, content, image);
    }

    public List<PostSupportModel> getPostOfFriends(int userId) {
        List<Post> posts = postDAO.findPostsOfFriends(userId);
        List<PostSupportModel> postsWithLikeCount = new ArrayList<>();

        for (Post post : posts) {
            long likeCount = postDAO.countLikesForPost(post.getPostId());
            postsWithLikeCount.add(new PostSupportModel(post, likeCount));
        }
        return postsWithLikeCount;
    }


    @Override
    public void actionLike(int userId, int postId) {
        postDAO.createLikeToPost(userId, postId);
    }

    @Override
    public long getCountOfLike(int postId) {
        return postDAO.countLikesForPost(postId);
    }
}
