package com.example.mangxahoi.DAO.UserDAO;

import com.example.mangxahoi.Model.User;

public interface UserDAO {
    public User findUserByPhoneNumberAndPassword(String phoneNumber, String password);
    public User findUserById(int userId);
    User createUse(String fullName, String phoneNumber,  String email,String password);


}
