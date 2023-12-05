package com.example.mangxahoi.Controller;

import com.example.mangxahoi.Entities.UsersEntity;
import com.example.mangxahoi.JPAManager.JPAConfiguration;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "helloServlet", value = "/addNewUser")
public class UserController extends HttpServlet {
    private String message;

    public void init() {
        message = "Đã xong. Hãy thử kiểm tra dữ liệu trong CSDL";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        EntityManager entityManager = JPAConfiguration.getEntityManager();
        EntityTransaction entityTransaction = entityManager.getTransaction();
        entityTransaction.begin();
        UsersEntity usersEntity = new UsersEntity();
        usersEntity.setFullName("Ngo Ngoc Thong");
        usersEntity.setEmail("ngocthong@gmail.com");
        usersEntity.setPhoneNumber("0982087930");
        usersEntity.setPassword("ngocthong");
        usersEntity.setGender(true);
        entityManager.persist(usersEntity);
        entityTransaction.commit();
        JPAConfiguration.closeEntityManager();


        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h1>" + message + "</h1>");
        out.println("</body></html>");
    }

    public void destroy() {
    }
}