package com.example.mangxahoi.Service.UserService;

import com.example.mangxahoi.Model.User;

public interface UserService {
    public User authenticateUser(String phoneNumber, String password);
    public User getUserById(int userId);
}
