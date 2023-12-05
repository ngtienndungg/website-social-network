package com.example.mangxahoi.Entities;

import javax.persistence.*;
import java.sql.Date;

@Entity
@Table(name = "Likes", schema = "dbo", catalog = "MangXaHoi")
public class LikesEntity {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "LikeID", nullable = false)
    private int likeId;
    @Basic
    @Column(name = "UserID", nullable = true)
    private Integer userId;
    @Basic
    @Column(name = "PostID", nullable = true)
    private Integer postId;
    @Basic
    @Column(name = "Timestamp", nullable = false)
    private Date timestamp;

    public int getLikeId() {
        return likeId;
    }

    public void setLikeId(int likeId) {
        this.likeId = likeId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getPostId() {
        return postId;
    }

    public void setPostId(Integer postId) {
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

        LikesEntity that = (LikesEntity) o;

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
