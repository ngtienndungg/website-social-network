package com.example.mangxahoi.Service.FriendService;

import com.example.mangxahoi.Entity.User;

import java.util.List;

public interface FriendService {
    public List<User> getRequestingList(int userId);
    public void acceptRequest(int firstUserId, int secondUserId);
    public void addFriend(int firstUserId, int secondUserId);
    public String getFriendStatus(int firstUserId, int secondUserId);
    public void rejectRequest(int firstUserId, int secondUserId);
    public List<User> getFriendList(int userId);
}
