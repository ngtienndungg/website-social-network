
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
</head>
<body>

<h2>Login</h2>
<form action="${pageContext.request.contextPath}/login" method="post">
    <label for="phoneNumber">Số điện thoại:</label>
    <input type="text" id="phoneNumber" name="phoneNumber" required>
    <br>

    <label for="password">Mật khẩu:</label>
    <input type="password" id="password" name="password" required>
    <br>
    <input type="submit" value="Login">
</form>

</body>
</html>
