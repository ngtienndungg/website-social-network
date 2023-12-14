package com.example.mangxahoi.DAO.PostDAO;

import com.example.mangxahoi.Entity.Post;
import com.example.mangxahoi.Entity.User;
import com.example.mangxahoi.JPAManager.JPAConfiguration;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import java.time.LocalDateTime;
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
}
