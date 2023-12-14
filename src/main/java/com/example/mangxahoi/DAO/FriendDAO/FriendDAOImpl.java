package com.example.mangxahoi.DAO.FriendDAO;

import com.example.mangxahoi.Entity.Friend;
import com.example.mangxahoi.Entity.User;
import com.example.mangxahoi.JPAManager.JPAConfiguration;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.NoResultException;
import javax.persistence.Query;
import java.util.List;

public class FriendDAOImpl implements FriendDAO {
    public List<User> findReceivingFriendRequest(int userId) {
        EntityManager entityManager = JPAConfiguration.getEntityManager();
        try {
            // Use a native query to retrieve users who sent friend requests to the specified user
            Query query = entityManager.createNativeQuery(
                    "SELECT u.* " +
                            "FROM Users u " +
                            "JOIN Friends f ON (u.UserID = f.FirstUserID) " +
                            "WHERE f.SecondUserID = :userId " +
                            "AND f.Status = 'Pending'", User.class
            );
            query.setParameter("userId", userId);
            @SuppressWarnings("unchecked")
            List<User> users = query.getResultList();
            return users;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public void updateFriendStatus(int firstUserId, int secondUserId, String status) {
        EntityManager entityManager = JPAConfiguration.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();

            Friend friend = entityManager.createQuery(
                            "SELECT f FROM Friend f WHERE (f.firstUserId.userId = :firstUserId AND f.secondUserId.userId = :secondUserId) " +
                                    "OR (f.firstUserId.userId = :secondUserId AND f.secondUserId.userId = :firstUserId)",
                            Friend.class
                    )
                    .setParameter("firstUserId", firstUserId)
                    .setParameter("secondUserId", secondUserId)
                    .getSingleResult();

            friend.setStatus(status);
            entityManager.merge(friend);
            transaction.commit();

        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public void createFriend(int firstUserId, int secondUserId) {
        EntityManager entityManager = JPAConfiguration.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();
            long existingCount = (long) entityManager.createQuery(
                            "SELECT COUNT(f) FROM Friend f " +
                                    "WHERE (f.firstUserId.userId = :firstUserId AND f.secondUserId.userId = :secondUserId) " +
                                    "OR (f.firstUserId.userId = :secondUserId AND f.secondUserId.userId = :firstUserId)"
                    )
                    .setParameter("firstUserId", firstUserId)
                    .setParameter("secondUserId", secondUserId)
                    .getSingleResult();
            if (existingCount == 0) {
                User firstUser = entityManager.find(User.class, firstUserId);
                User secondUser = entityManager.find(User.class, secondUserId);
                Friend friend = new Friend();
                friend.setFirstUserId(firstUser);
                friend.setSecondUserId(secondUser);
                friend.setStatus("Pending");
                entityManager.persist(friend);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public String getFriendStatus(int firstUserId, int secondUserId) {
        EntityManager entityManager = JPAConfiguration.getEntityManager();
        try {
            String status = entityManager.createQuery(
                            "SELECT f.status FROM Friend f " +
                                    "WHERE (f.firstUserId.userId = :firstUserId AND f.secondUserId.userId = :secondUserId) " +
                                    "OR (f.firstUserId.userId = :secondUserId AND f.secondUserId.userId = :firstUserId)",
                            String.class
                    )
                    .setParameter("firstUserId", firstUserId)
                    .setParameter("secondUserId", secondUserId)
                    .getSingleResult();
            if ("Pending".equals(status)) {
                Friend friend = entityManager.createQuery(
                                "SELECT f FROM Friend f " +
                                        "WHERE (f.firstUserId.userId = :firstUserId AND f.secondUserId.userId = :secondUserId) " +
                                        "OR (f.firstUserId.userId = :secondUserId AND f.secondUserId.userId = :firstUserId)",
                                Friend.class
                        )
                        .setParameter("firstUserId", firstUserId)
                        .setParameter("secondUserId", secondUserId)
                        .getSingleResult();

                if (friend.getFirstUserId().getUserId() == firstUserId) {
                    return "RequestReceived";
                } else {
                    return "RequestSent";
                }
            }

            return status != null ? status : "No relationship";
        } catch (NoResultException e) {
            return "No relationship";
        } finally {
            entityManager.close();
        }
    }


    @Override
    public void deleteFriend(int firstUserId, int secondUserId) {
        EntityManager entityManager = JPAConfiguration.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            Friend friend = entityManager.createQuery(
                            "SELECT f FROM Friend f WHERE (f.firstUserId.userId = :firstUserId AND f.secondUserId.userId = :secondUserId) " +
                                    "OR (f.firstUserId.userId = :secondUserId AND f.secondUserId.userId = :firstUserId)",
                            Friend.class
                    )
                    .setParameter("firstUserId", firstUserId)
                    .setParameter("secondUserId", secondUserId)
                    .getSingleResult();
            entityManager.remove(friend);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<User> findFriendByUserId(int userId) {
        EntityManager entityManager = JPAConfiguration.getEntityManager();
        try {
            Query query = entityManager.createNativeQuery(
                    "SELECT u.* " +
                            "FROM Users u " +
                            "JOIN Friends f ON (u.UserID = f.FirstUserID) " +
                            "WHERE f.SecondUserID = :userId " +
                            "AND f.Status = 'Friend'", User.class
            );
            query.setParameter("userId", userId);
            @SuppressWarnings("unchecked")
            List<User> users = query.getResultList();
            Query query1 = entityManager.createNativeQuery(
                    "SELECT u.* " +
                            "FROM Users u " +
                            "JOIN Friends f ON (u.UserID = f.SecondUserID) " +
                            "WHERE f.FirstUserID = :userId " +
                            "AND f.Status = 'Friend'", User.class
            );
            query1.setParameter("userId", userId);
            @SuppressWarnings("unchecked")
            List<User> users1 = query1.getResultList();
            users.addAll(users1);
            return users;
        } finally {
            entityManager.close();
        }
    }
}
