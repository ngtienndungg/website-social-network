package com.example.mangxahoi.SupportModel;

import com.example.mangxahoi.Entity.Post;

public class PostSupportModel {
    private final Post post;
    private final long likeCount;

    public PostSupportModel(Post post, long likeCount) {
        this.post = post;
        this.likeCount = likeCount;
    }

    public Post getPost() {
        return post;
    }

    public long getLikeCount() {
        return likeCount;
    }
}
