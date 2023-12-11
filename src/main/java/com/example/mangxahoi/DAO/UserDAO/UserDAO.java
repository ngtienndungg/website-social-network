package com.example.mangxahoi.DAO.UserDAO;

import com.example.mangxahoi.Model.User;

public interface UserDAO {
    public User findUserByPhoneNumberAndPassword(String phoneNumber, String password);
    public User findUserById(int userId);
}
