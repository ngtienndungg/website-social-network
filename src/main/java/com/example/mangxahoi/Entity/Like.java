package com.example.mangxahoi.Entity;

import javax.persistence.*;
import java.sql.Date;

@Entity
@Table(name = "Likes", schema = "dbo", catalog = "MangXaHoi")
public class Like {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "LikeID", nullable = false)
    private int likeId;
    @ManyToOne
    @JoinColumn(name = "userID")
    private User userId;
    @ManyToOne
    @JoinColumn(name = "PostID")
    private Post postId;
    @Basic
    @Column(name = "Timestamp", nullable = false)
    private Date timestamp;

    public int getLikeId() {
        return likeId;
    }

    public void setLikeId(int likeId) {
        this.likeId = likeId;
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

        Like that = (Like) o;

        if (likeId != that.likeId) return false;
        if (userId != null ? !userId.equals(that.userId) : that.userId != null) return false;
        if (postId != null ? !postId.equals(that.postId) : that.postId != null) return false;
        if (timestamp != null ? !timestamp.equals(that.timestamp) : that.timestamp != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = likeId;
        result = 31 * result + (userId != null ? userId.hashCode() : 0);
        result = 31 * result + (postId != null ? postId.hashCode() : 0);
        result = 31 * result + (timestamp != null ? timestamp.hashCode() : 0);
        return result;
    }
}
