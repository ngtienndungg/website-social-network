package com.example.mangxahoi.JPAManager;

import javax.persistence.EntityManager;
import javax.persistence.Persistence;

public class JPAConfiguration {
    private static final String PERSISTENCE_UNIT_NAME = "MangXaHoi";
    private static EntityManager entityManagerInstance = null;

    public static EntityManager getEntityManager() {
        if (entityManagerInstance == null || !entityManagerInstance.isOpen()) {
            entityManagerInstance = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME).createEntityManager();
            return entityManagerInstance;
        }
        return entityManagerInstance;
    }
}

