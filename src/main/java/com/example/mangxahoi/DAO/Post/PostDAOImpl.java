package com.example.mangxahoi.DAO.Post;

import com.example.mangxahoi.JPAManager.JPAConfiguration;
import com.example.mangxahoi.Model.Post;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
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
}
