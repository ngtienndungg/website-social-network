package com.example.mangxahoi.DAO.UserDAO;

import com.example.mangxahoi.JPAManager.JPAConfiguration;
import com.example.mangxahoi.Model.User;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;

public class UserDAOImpl implements UserDAO {
    @Override
    public User getUserByPhoneNumberAndPassword(String phoneNumber, String password) {
        try {
            EntityManager entityManager = JPAConfiguration.getEntityManager();
            TypedQuery<User> query = entityManager.createQuery(
                    "SELECT user FROM User user WHERE user.phoneNumber = :phoneNumber AND user.password = :password",
                    User.class
            );
            query.setParameter("phoneNumber", phoneNumber);
            query.setParameter("password", password);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }
}
