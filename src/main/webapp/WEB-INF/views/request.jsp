<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.example.mangxahoi.Entity.User" %>
<%@ page import="java.util.ArrayList" %>
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

        .container {
            width: 100%; /* Đảm bảo rằng container chiếm toàn bộ chiều rộng của trang */
        }

        header {
            background-color: #f0f0f0; /* Màu nền của header */
            padding: 10px; /* Điều chỉnh phần đệm bên trong header để tạo khoảng trống xung quanh nội dung */
        }

        .horizontal-menu {
            list-style-type: none;
            margin: 0;
            padding: 0;
            display: flex; /* Hiển thị các phần tử trong menu theo chiều ngang */
        }

        .horizontal-menu li {
            margin-right: 10px;
        }

        .search-bar {
            margin-left: auto;
            display: flex;
            align-items: center;
        }

        .search-input {
            align-items: center;
            width: 400px;
            padding: 5px;
            margin-right: 5px;
        }

        .search-button {
            padding: 5px 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }

        .search-button:hover {
            background-color: #45a049;
        }
        .horizontal-menu li {
            display: inline-block;
            margin-right: 10px;
        }

        .link-style {
            text-decoration: none;
            color: #000;
        }

        /* Đảm bảo nội dung của header ngang chứ không phải dọc */
        nav {
            display: flex;
            align-items: center;
        }

        /* Tùy chỉnh chiều cao của header (thay đổi giá trị theo nhu cầu của bạn) */
        header {
            height: 70px;
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

        .button-container {
            display: flex; /* Sử dụng flexbox để các phần tử con nằm trong một hàng ngang */
            gap: 20px; /* Đặt khoảng cách giữa các phần tử con là 20px */
        }

        .accept-btn {
            /* Tùy chỉnh kiểu và màu sắc cho nút Chấp nhận nếu cần thiết */
        }

        .reject-btn {
            background-color: red;
            color: white;
            /* Tùy chỉnh kiểu cho nút Reject nếu cần thiết */
        }

        .form-container {
            display: flex;
        }

        .form-inline {
            display: flex;
        }

        .form-gap {
            width: 20px;
        }

    </style>
</head>
<body>
<div class="container">
    <header>
        <nav>
            <ul class="horizontal-menu">
                <li><a href="${pageContext.request.contextPath}/home" class="link-style">Trang chủ</a></li>
                <li><a href="${pageContext.request.contextPath}/friend-request" class="link-style">Yêu cầu kết bạn</a></li>
                <li><a href="${pageContext.request.contextPath}/profile/${cookie.userId.value}" class="link-style">Trang cá nhân</a></li>
                <li><a href="${pageContext.request.contextPath}/logout" class="link-style">Đăng xuất</a></li>
                <div class="search-bar">
                    <input type="text" placeholder="Tìm kiếm..." class="search-input">
                    <button class="search-button">Tìm kiếm</button>
                </div>
            </ul>
        </nav>
    </header>
    <c:set var="requests" value="<%= requests %>"/>
    <div class="row">
        <c:forEach var="request" items="${requests}">
            <div class="col-md-8">
                <div class="people-nearby">
                    <div class="nearby-user">
                        <div class="row">
                            <div class="col-md-2 col-sm-2">
                                <a href="${pageContext.request.contextPath}/profile/${request.userId}">
                                    <img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="user"
                                         class="profile-photo-lg">
                                </a>
                            </div>
                            <div class="col-md-7 col-sm-7">
                                <h5><a href="${pageContext.request.contextPath}/profile/${request.userId}" class="profile-link">${request.fullName}</a></h5>
                            </div>
                            <div class="col-md-3 col-sm-3">
                                <div class="form-container">
                                    <form action="request-response" method="post" class="form-inline m-0">
                                        <button type="submit" class="btn btn-primary accept-btn"
                                                onclick="acceptFriend(this)">Chấp nhận
                                        </button>
                                        <input type="hidden" name="friendID" value="${request.userId}">
                                    </form>

                                    <div class="form-gap"></div> <!-- Khoảng cách giữa hai form -->

                                    <form action="${pageContext.request.contextPath}/request-response" method="post"
                                          class="form-inline m-0">
                                        <input type="hidden" name="friendID" value="${request.userId}">
                                        <button type="submit" class="btn btn-danger reject-btn"
                                                onclick="rejectFriend(this)">Từ chối
                                        </button>
                                        <input type="hidden" name="friendID" value="${request.userId}">
                                    </form>
                                </div>
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