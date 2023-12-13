package com.example.mangxahoi.DAO.FriendDAO;

import com.example.mangxahoi.JPAManager.JPAConfiguration;
import com.example.mangxahoi.Model.Friend;
import com.example.mangxahoi.Model.User;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
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
            for (User user : users) {
                System.out.println(user.getFullName());
            }
            return users;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public Friend updateFriendStatus(int firstUserId, int secondUserId, String status) {
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

            transaction.commit();

            return friend;
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
            return null;
        } finally {
            entityManager.close();
        }
    }


}
