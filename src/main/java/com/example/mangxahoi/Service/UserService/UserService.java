package com.example.mangxahoi.Service.UserService;

import com.example.mangxahoi.Entity.User;

import java.util.List;

public interface UserService {
    public User authenticateUser(String phoneNumber, String password);

    public User getUserById(int userId);

    public User registerUser(String fullName, String phoneNumber, String email, String password, boolean gender);

    public User updateUser(int userId, String fullName, String email, String biography, boolean gender);
    public List<User> getUserByName(String name);
}
