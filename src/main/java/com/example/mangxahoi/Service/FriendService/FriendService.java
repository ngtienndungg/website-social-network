package com.example.mangxahoi.Service.FriendService;

import com.example.mangxahoi.Entity.User;

import java.util.List;

public interface FriendService {
    public List<User> getRequestingList(int userId);
    public void acceptRequest(int firstUserId, int secondUserId);
}
