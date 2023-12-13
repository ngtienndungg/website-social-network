package com.example.mangxahoi.Service.FriendService;

import com.example.mangxahoi.DAO.FriendDAO.FriendDAO;
import com.example.mangxahoi.DAO.FriendDAO.FriendDAOImpl;
import com.example.mangxahoi.Model.Friend;
import com.example.mangxahoi.Model.User;

import java.util.List;

public class FriendServiceImpl implements FriendService {
    private final FriendDAO friendDAO = new FriendDAOImpl();
    @Override
    public List<User> getRequestingList(int userId) {
        return friendDAO.findReceivingFriendRequest(userId);
    }

    @Override
    public Friend acceptRequest(int firstUserId, int secondUserId) {
        return friendDAO.updateFriendStatus(firstUserId, secondUserId, "Friend");
    }
}
