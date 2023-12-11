package com.example.mangxahoi.Model;

import javax.persistence.*;
import java.sql.Date;

@Entity
@Table(name = "Posts", schema = "dbo", catalog = "MangXaHoi")
public class Post {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "PostID", nullable = false)
    private int postId;
    @ManyToOne
    @JoinColumn(name = "userID")
    private User userId;
    @Basic
    @Column(name = "Content", nullable = true, length = 2147483647)
    private String content;
    @Basic
    @Column(name = "Image", nullable = true, length = 2147483647)
    private String image;
    @Basic
    @Column(name = "Timestamp", nullable = false)
    private Date timestamp;

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public User getUserId() {
        return userId;
    }

    public void setUserId(User userId) {
        this.userId = userId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
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

        Post that = (Post) o;

        if (postId != that.postId) return false;
        if (userId != null ? !userId.equals(that.userId) : that.userId != null) return false;
        if (content != null ? !content.equals(that.content) : that.content != null) return false;
        if (image != null ? !image.equals(that.image) : that.image != null) return false;
        if (timestamp != null ? !timestamp.equals(that.timestamp) : that.timestamp != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = postId;
        result = 31 * result + (userId != null ? userId.hashCode() : 0);
        result = 31 * result + (content != null ? content.hashCode() : 0);
        result = 31 * result + (image != null ? image.hashCode() : 0);
        result = 31 * result + (timestamp != null ? timestamp.hashCode() : 0);
        return result;
    }
}
