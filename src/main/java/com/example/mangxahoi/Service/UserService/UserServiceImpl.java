package com.example.mangxahoi.Service.UserService;

import com.example.mangxahoi.DAO.UserDAO.UserDAO;
import com.example.mangxahoi.DAO.UserDAO.UserDAOImpl;
import com.example.mangxahoi.Model.User;

public class UserServiceImpl implements UserService {
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    public User authenticateUser(String phoneNumber, String password) {
        return userDAO.findUserByPhoneNumberAndPassword(phoneNumber, password);
    }

    @Override
    public User getUserById(int userId) {
        return userDAO.findUserById(userId);
    }

    @Override
    public User registerUser(String fullName, String phoneNumber, String email, String password, boolean gender) {
        return userDAO.registerUser(fullName, phoneNumber, email, password, gender);
    }

    @Override
    public User updateUser(int userId, String fullName, String email, String biography, boolean gender) {
        return userDAO.updateUserInformation(userId, fullName, email, biography, gender);
    }
}
