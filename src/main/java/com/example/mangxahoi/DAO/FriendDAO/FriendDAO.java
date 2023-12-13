package com.example.mangxahoi.DAO.FriendDAO;

import com.example.mangxahoi.Model.Friend;
import com.example.mangxahoi.Model.User;

import java.util.List;

public interface FriendDAO {
    public List<User> findReceivingFriendRequest(int userId);
    public Friend updateFriendStatus(int firstUserId, int secondUserId, String status);
}
