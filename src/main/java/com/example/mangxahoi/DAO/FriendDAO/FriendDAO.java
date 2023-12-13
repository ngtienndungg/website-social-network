package com.example.mangxahoi.DAO.FriendDAO;

import com.example.mangxahoi.Entity.Friend;
import com.example.mangxahoi.Entity.User;

import java.util.List;

public interface FriendDAO {
    public List<User> findReceivingFriendRequest(int userId);
    public Friend updateFriendStatus(int firstUserId, int secondUserId, String status);
}
