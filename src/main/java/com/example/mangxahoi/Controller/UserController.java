package com.example.mangxahoi.Controller;

import com.example.mangxahoi.Model.User;
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
        User user = new User();
        user.setFullName("Ngo Ngoc Thong");
        user.setEmail("ngocthong@gmail.com");
        user.setPhoneNumber("0982087930");
        user.setPassword("ngocthong");
        user.setGender(true);
        entityManager.persist(user);
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