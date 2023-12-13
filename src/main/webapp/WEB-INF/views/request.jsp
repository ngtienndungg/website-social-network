<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.example.mangxahoi.Entity.User" %>
<%@ page import="com.example.mangxahoi.Entity.Post" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    ArrayList<User> requests;
    if (request.getAttribute("requestList") != null) {
        requests = (ArrayList<User>) request.getAttribute("requestList");
    } else {
        requests = new ArrayList<>();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
        }

        header {
            display: flex;
            background-color: #333; /* Màu nền của thanh navigation bar */
            color: #fff; /* Màu chữ */
            justify-content: space-around; /* Chia đều khoảng cách giữa các mục */
            align-items: center; /* Căn giữa theo chiều dọc */
            height: 220px; /* Độ cao của thanh navigation bar */
        }

        header a, header button {
            text-decoration: none;
            color: #fff; /* Màu chữ cho liên kết */
            padding: 15px; /* Kích thước của padding tùy thuộc vào thiết kế của bạn */
            flex: 1; /* Mỗi mục chiếm đều không gian trong header */
            text-align: center; /* Căn giữa nội dung trong mỗi mục */
            cursor: pointer; /* Biến con trỏ thành hình bàn tay khi di chuột qua */
        }

        header a.link-style {
            display: block; /* Đặt liên kết dưới dạng khối để chiếm toàn bộ width của mục */
        }
    </style>


    <title>bs4 beta friend list - Bootdey.com</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://netdna.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        body {
            margin-top: 20px;
            background: #FAFAFA;
        }

        /*==================================================
          Nearby People CSS
          ==================================================*/

        .people-nearby .google-maps {
            background: #f8f8f8;
            border-radius: 4px;
            border: 1px solid #f1f2f2;
            padding: 20px;
            margin-bottom: 20px;
        }

        .people-nearby .google-maps .map {
            height: 300px;
            width: 100%;
            border: none;
        }

        .people-nearby .nearby-user {
            padding: 20px 0;
            border-top: 1px solid #f1f2f2;
            border-bottom: 1px solid #f1f2f2;
            margin-bottom: 20px;
        }

        img.profile-photo-lg {
            height: 80px;
            width: 80px;
            border-radius: 50%;
        }

    </style>
</head>
<body>
<div class="container">
    <header>
        <a href="#" class="link-style">Trang chủ</a>
        <a href="${pageContext.request.contextPath}/friend-request" class="link-style">Yêu cầu kết bạn</a>
        <a href="${pageContext.request.contextPath}/profile/${cookie.userId.value}" class="link-style">Trang cá nhân</a>
        <a href="${pageContext.request.contextPath}/logout" class="link-style">Đăng xuất</a>
    </header>
    <c:set var="requests" value="<%= requests %>"/>
    <div class="row">
        <c:forEach var="request" items="${requests}">
            <div class="col-md-8">
                <div class="people-nearby">
                    <div class="nearby-user">
                        <div class="row">
                            <div class="col-md-2 col-sm-2">
                                <img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="user"
                                     class="profile-photo-lg">
                            </div>
                            <div class="col-md-7 col-sm-7">
                                <h5><a href="#" class="profile-link">${request.fullName}</a></h5>
                            </div>
                            <div class="col-md-3 col-sm-3">
                                <form action="request-response" method="post">
                                    <input type="hidden" name="friendID" value="${request.userId}">
                                    <button type="submit" class="btn btn-primary pull-right"
                                            onclick="acceptFriend(this)">Chấp nhận
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <script>
        function acceptFriend(button) {
            button.innerHTML = 'Đã đồng ý';
        }
    </script>

</div>

<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="ttps://netdna.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<script type="text/javascript">

</script>
</body>
</html>