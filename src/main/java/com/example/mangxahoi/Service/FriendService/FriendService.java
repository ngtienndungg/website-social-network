package com.example.mangxahoi.Service.FriendService;

import com.example.mangxahoi.Model.Friend;
import com.example.mangxahoi.Model.User;

import java.util.List;

public interface FriendService {
    public List<User> getRequestingList(int userId);
    public Friend acceptRequest(int firstUserId, int secondUserId);
}
