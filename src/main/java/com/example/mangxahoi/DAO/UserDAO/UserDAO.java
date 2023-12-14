package com.example.mangxahoi.DAO.UserDAO;

import com.example.mangxahoi.Entity.User;

import java.util.List;

public interface UserDAO {
    public User findUserByPhoneNumberAndPassword(String phoneNumber, String password);

    public User findUserById(int userId);

    public User registerUser(String fullName, String phoneNumber, String email, String password, boolean gender);

    public User updateUserInformation(int userId, String fullName, String email, String biography, boolean gender);

    public List<User> findUserByName(String name);

}
