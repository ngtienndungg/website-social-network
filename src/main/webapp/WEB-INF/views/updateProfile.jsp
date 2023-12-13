<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.example.mangxahoi.Entity.User" %>
<%@ page import="com.example.mangxahoi.Service.UserService.UserService" %>
<%@ page import="com.example.mangxahoi.Service.UserService.UserServiceImpl" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = null;
    Cookie[] cookies = request.getCookies();
    for (Cookie cookie : cookies) {
        if (cookie.getName().equals("userId")) {
            UserService userService = new UserServiceImpl();
            user = userService.getUserById(Integer.valueOf(cookie.getValue().toString()));
        }
    }
%>

<c:set var="loggedInUser" value="<%= user %>" scope="session"/>

<html>
<head>
    <title>Update Thông Tin </title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }

        form {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 300px;
        }

        label {
            display: block;
            margin-bottom: 8px;
        }

        input,
        textarea,
        select {
            width: 100%;
            padding: 8px;
            margin-bottom: 16px;
            box-sizing: border-box;
        }

        button {
            background-color: #007bff;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button.secondary {
            background-color: #6c757d;
        }

    </style>
</head>
<body>
<form id="editForm" action="<%= request.getContextPath() %>/updateprofile" method="post">
    <input type="hidden" id="baseUrl" value="<%= request.getContextPath() %>">

    <label for="fullName">Full Name:</label>
    <input type="text" id="fullName" name="fullName" value="<%= user.getFullName() %>">

    <label for="biography">Biography:</label>
    <textarea id="biography" name="biography"><%= user.getBiography() %></textarea>

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" value="<%= user.getEmail() %>">

    <label for="gender">Gender:</label>
    <select id="gender" name="gender">
        <option value="true" <%= user.getGender() ? "selected" : "" %>>Nam</option>
        <option value="false" <%= !user.getGender() ? "selected" : "" %>>Nữ</option>
    </select>

    <div>
        <button type="submit">Lưu lại thay đổi</button>
        <button type="button" class="secondary" onclick="closeModal()">Close</button>
    </div>
</form>

</body>
</html>
