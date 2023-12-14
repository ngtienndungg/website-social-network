package com.example.mangxahoi.DAO.FriendDAO;

import com.example.mangxahoi.Entity.Friend;
import com.example.mangxahoi.Entity.User;

import java.util.List;

public interface FriendDAO {
    public List<User> findReceivingFriendRequest(int userId);
    public void updateFriendStatus(int firstUserId, int secondUserId, String status);
    public void createFriend(int firstUserId, int secondUserId);
    public String getFriendStatus(int firstUserId, int secondUserId);
    public void deleteFriend(int firstUserId, int secondUserId);
    public List<User> findFriendByUserId(int userId);
}
