package com.example.mangxahoi.Entities;

import javax.persistence.*;

@Entity
@Table(name = "Friends", schema = "dbo", catalog = "MangXaHoi")
public class FriendsEntity {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "FriendshipID", nullable = false)
    private int friendshipId;
    @Basic
    @Column(name = "FirstUserID", nullable = true)
    private Integer firstUserId;
    @Basic
    @Column(name = "SecondUserID", nullable = true)
    private Integer secondUserId;
    @Basic
    @Column(name = "Status", nullable = false, length = 50)
    private String status;

    public int getFriendshipId() {
        return friendshipId;
    }

    public void setFriendshipId(int friendshipId) {
        this.friendshipId = friendshipId;
    }

    public Integer getFirstUserId() {
        return firstUserId;
    }

    public void setFirstUserId(Integer firstUserId) {
        this.firstUserId = firstUserId;
    }

    public Integer getSecondUserId() {
        return secondUserId;
    }

    public void setSecondUserId(Integer secondUserId) {
        this.secondUserId = secondUserId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        FriendsEntity that = (FriendsEntity) o;

        if (friendshipId != that.friendshipId) return false;
        if (firstUserId != null ? !firstUserId.equals(that.firstUserId) : that.firstUserId != null) return false;
        if (secondUserId != null ? !secondUserId.equals(that.secondUserId) : that.secondUserId != null) return false;
        if (status != null ? !status.equals(that.status) : that.status != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = friendshipId;
        result = 31 * result + (firstUserId != null ? firstUserId.hashCode() : 0);
        result = 31 * result + (secondUserId != null ? secondUserId.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        return result;
    }
}
