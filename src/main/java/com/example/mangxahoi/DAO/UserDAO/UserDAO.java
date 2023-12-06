package com.example.mangxahoi.DAO.UserDAO;

import com.example.mangxahoi.Model.User;

public interface UserDAO {
    public User getUserByPhoneNumberAndPassword(String phoneNumber, String password);
}
