<%@ page import="com.example.mangxahoi.Model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = (User) request.getSession().getAttribute("user");
%>
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
<form id="editForm" action="/updateprofile" method="post">
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
        <button type="button" onclick="saveChanges()">Save Changes</button>
        <button type="button" class="secondary" onclick="closeModal()">Close</button>
    </div>
</form>
<script>
    function closeModal() {
        // Redirect to /profile when closing the modal
        window.location.href = '/MangXaHoi/profile/<%= user.getUserId() %>';
    }


</script>
</body>
</html>
