package com.example.mangxahoi.Entity;

import javax.persistence.*;
import java.sql.Date;

@Entity
@Table(name = "Comments", schema = "dbo", catalog = "MangXaHoi")
public class Comment {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "CommentID", nullable = false)
    private int commentId;
    @ManyToOne
    @JoinColumn(name = "userID")
    private User userId;
    @ManyToOne
    @JoinColumn(name = "PostID")
    private Post postId;
    @Basic
    @Column(name = "Content", nullable = false, length = 2147483647)
    private String content;
    @Basic
    @Column(name = "Timestamp", nullable = false)
    private Date timestamp;

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public User getUserId() {
        return userId;
    }

    public void setUserId(User userId) {
        this.userId = userId;
    }

    public Post getPostId() {
        return postId;
    }

    public void setPostId(Post postId) {
        this.postId = postId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Comment that = (Comment) o;

        if (commentId != that.commentId) return false;
        if (userId != null ? !userId.equals(that.userId) : that.userId != null) return false;
        if (postId != null ? !postId.equals(that.postId) : that.postId != null) return false;
        if (content != null ? !content.equals(that.content) : that.content != null) return false;
        if (timestamp != null ? !timestamp.equals(that.timestamp) : that.timestamp != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = commentId;
        result = 31 * result + (userId != null ? userId.hashCode() : 0);
        result = 31 * result + (postId != null ? postId.hashCode() : 0);
        result = 31 * result + (content != null ? content.hashCode() : 0);
        result = 31 * result + (timestamp != null ? timestamp.hashCode() : 0);
        return result;
    }
}
