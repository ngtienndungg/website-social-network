package com.example.mangxahoi.Service.PostService;

import com.example.mangxahoi.Entity.Post;
import com.example.mangxahoi.SupportModel.PostSupportModel;

import java.util.List;

public interface PostService {
    List<Post> getPostByUserId(int userId);
    void uploadPost(int userId, String content, String image);
    List<PostSupportModel> getPostOfFriends(int userId);
    void actionLike(int userId, int postId);
    long getCountOfLike(int postId);
}
