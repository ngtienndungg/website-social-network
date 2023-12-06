package com.example.mangxahoi.Service.UserService;

import com.example.mangxahoi.DAO.UserDAO.UserDAO;
import com.example.mangxahoi.DAO.UserDAO.UserDAOImpl;
import com.example.mangxahoi.Model.User;

public class UserServiceImpl implements UserService {
    private UserDAO userDAO = new UserDAOImpl();
    @Override
    public User authenticateUser(String phoneNumber, String password) {
        return userDAO.getUserByPhoneNumberAndPassword(phoneNumber, password);
    }
}
