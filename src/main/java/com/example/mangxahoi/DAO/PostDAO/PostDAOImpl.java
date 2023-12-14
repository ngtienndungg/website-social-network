package com.example.mangxahoi.DAO.PostDAO;

import com.example.mangxahoi.Entity.Post;
import com.example.mangxahoi.Entity.User;
import com.example.mangxahoi.JPAManager.JPAConfiguration;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;

public class PostDAOImpl implements PostDAO {
    @Override
    public List<Post> findPostByUserId(int userId) {
        try {
            EntityManager entityManager = JPAConfiguration.getEntityManager();
            TypedQuery<Post> query = entityManager.createQuery(
                    "SELECT post FROM Post post WHERE post.userId.userId = :id",
                    Post.class
            );
            query.setParameter("id", userId);
            return query.getResultList();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public void createPost(int userId, String content, String image) {
        EntityManager entityManager = JPAConfiguration.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            User user = entityManager.find(User.class, userId);
            Post post = new Post();
            post.setContent(content);
            if (image != null) {
                post.setImage(image);
            }
            post.setUserId(user);
            post.setTimestamp(LocalDateTime.now());
            entityManager.persist(post);
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
    public List<Post> findPostsOfFriends(int userId) {
        EntityManager entityManager = JPAConfiguration.getEntityManager();
        try {
            List<Integer> friendIds = entityManager.createQuery(
                            "SELECT CASE " +
                                    "   WHEN f.firstUserId.userId = :userId THEN f.secondUserId.userId " +
                                    "   WHEN f.secondUserId.userId = :userId THEN f.firstUserId.userId " +
                                    "END " +
                                    "FROM Friend f " +
                                    "WHERE (f.firstUserId.userId = :userId OR f.secondUserId.userId = :userId) " +
                                    "AND f.status = 'Friend'",
                            Integer.class
                    )
                    .setParameter("userId", userId)
                    .getResultList();
            if (!friendIds.isEmpty()) {
                return entityManager.createQuery(
                                "SELECT p FROM Post p WHERE p.userId.userId IN :friendIds",
                                Post.class
                        )
                        .setParameter("friendIds", friendIds)
                        .getResultList();
            } else {
                return Collections.emptyList();
            }
        } finally {
            entityManager.close();
        }
    }

}
