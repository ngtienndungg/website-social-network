package com.example.mangxahoi.DAO.UserDAO;

import com.example.mangxahoi.Entity.User;
import com.example.mangxahoi.JPAManager.JPAConfiguration;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import java.util.List;

public class UserDAOImpl implements UserDAO {
    @Override
    public User findUserByPhoneNumberAndPassword(String phoneNumber, String password) {
        EntityManager entityManager = JPAConfiguration.getEntityManager();
        try {
            TypedQuery<User> query = entityManager.createQuery(
                    "SELECT user FROM User user WHERE user.phoneNumber = :phoneNumber AND user.password = :password",
                    User.class
            );
            query.setParameter("phoneNumber", phoneNumber);
            query.setParameter("password", password);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public User findUserById(int userId) {
        EntityManager entityManager = JPAConfiguration.getEntityManager();
        try {

            TypedQuery<User> query = entityManager.createQuery(
                    "SELECT user FROM User user WHERE user.id = :id",
                    User.class
            );
            query.setParameter("id", userId);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public User registerUser(String fullName, String phoneNumber, String email, String password, boolean gender) {
        EntityManager entityManager = JPAConfiguration.getEntityManager();
        try {
            EntityTransaction transaction = entityManager.getTransaction();
            transaction.begin();

            User newUser = new User();
            newUser.setFullName(fullName);
            newUser.setPhoneNumber(phoneNumber);
            newUser.setEmail(email);
            newUser.setGender(gender);
            newUser.setPassword(password);

            entityManager.persist(newUser);

            transaction.commit();
            return newUser;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public User updateUserInformation(int userId, String fullName, String email, String biography, boolean gender) {
        EntityManager entityManager = JPAConfiguration.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();
            User userToUpdate = entityManager.find(User.class, userId);

            if (userToUpdate != null) {
                userToUpdate.setFullName(fullName);
                userToUpdate.setEmail(email);
                userToUpdate.setBiography(biography);
                userToUpdate.setGender(gender);
                entityManager.merge(userToUpdate);
                transaction.commit();
                return userToUpdate;
            } else {
                transaction.rollback();
                return null;
            }
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
            throw e;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<User> findUserByName(String name) {
        EntityManager entityManager = JPAConfiguration.getEntityManager();
        try {
            TypedQuery<User> query = entityManager.createQuery(
                    "SELECT u FROM User u WHERE LOWER(u.fullName) LIKE LOWER(:name)",
                    User.class
            );
            query.setParameter("name", "%" + name + "%");
            List<User> resultList = query.getResultList();
            if (!resultList.isEmpty()) {
                return resultList;
            } else {
                return null;
            }
        } finally {
            entityManager.close();
        }
    }
}
