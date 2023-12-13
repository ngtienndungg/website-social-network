package com.example.mangxahoi.Service.FriendService;

import com.example.mangxahoi.DAO.FriendDAO.FriendDAO;
import com.example.mangxahoi.DAO.FriendDAO.FriendDAOImpl;
import com.example.mangxahoi.Entity.User;

import java.util.List;

public class FriendServiceImpl implements FriendService {
    private final FriendDAO friendDAO = new FriendDAOImpl();

    @Override
    public List<User> getRequestingList(int userId) {
        return friendDAO.findReceivingFriendRequest(userId);
    }

    @Override
    public void acceptRequest(int firstUserId, int secondUserId) {
        friendDAO.updateFriendStatus(firstUserId, secondUserId, "Friend");
    }

    @Override
    public void addFriend(int firstUserId, int secondUserId) {
        friendDAO.createFriend(firstUserId, secondUserId);
    }

    @Override
    public String getFriendStatus(int firstUserId, int secondUserId) {
        return friendDAO.getFriendStatus(firstUserId, secondUserId);
    }

    @Override
    public void rejectRequest(int firstUserId, int secondUserId) {
        friendDAO.deleteFriend(firstUserId, secondUserId);
    }

}
