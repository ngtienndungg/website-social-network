<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.example.mangxahoi.Entity.User" %>
<%@ page import="com.example.mangxahoi.Entity.Post" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.mangxahoi.Service.FriendService.FriendService" %>
<%@ page import="com.example.mangxahoi.Service.FriendService.FriendServiceImpl" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.example.mangxahoi.Entity.Friend" %>
<%@ page import="com.example.mangxahoi.SupportModel.PostSupportModel" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = new User();
    if (request.getAttribute("user") != null) {
        user = (User) request.getAttribute("user");
    }

    ArrayList<PostSupportModel> posts;
    if (request.getAttribute("posts") != null) {
        posts = (ArrayList<PostSupportModel>) request.getAttribute("posts");
    } else {
        posts = new ArrayList<>();
    }
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm dd-MM-yyyy");

    ArrayList<User> friends;
    if (request.getAttribute("friends") != null) {
        friends = (ArrayList<User>) request.getAttribute("friends");
    } else {
        friends = new ArrayList<>();
    }
%>

<c:set var="userId" value=""/>
<c:set var="formatter" value="<%= formatter %>"/>

<%
    int currentUserId = 0;
    javax.servlet.http.Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (javax.servlet.http.Cookie cookie : cookies) {
            if (cookie.getName().equals("userId")) {
                pageContext.setAttribute("userId", cookie.getValue());
                currentUserId = Integer.parseInt(cookie.getValue());
            }
        }
    }

    String profileId = "";
    if (request.getAttribute("pathInfo") != null) {
        profileId = request.getAttribute("pathInfo").toString();
    } else {
        profileId = String.valueOf(currentUserId);
    }

    FriendService friendService = new FriendServiceImpl();
    String friendStatus = friendService.getFriendStatus(user.getUserId(), currentUserId);
%>

<c:set var="profileId" value="<%= profileId %>"/>
<c:set var="gender" value="<%= user.getGender() %>"/>
<c:set var="status" value="<%= friendStatus %>"/>
<c:set var="friends" value="<%= friends %>"/>

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
            height: 100px; /* Độ cao của thanh navigation bar */
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

        .link-style {
            text-decoration: none;
            color: #000;
        }

        /* Đảm bảo nội dung của header ngang chứ không phải dọc */
        nav {
            display: flex;
            align-items: center;
        }

        header {
            height: 70px;
        }
    </style>
    <title>social network user profile example - Bootdey.com</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        body {
            background-color: #f9fafb;
            margin-top: 20px;
        }

        .profile-page .profile-header {
            box-shadow: 0 0 10px 0 rgba(183, 192, 206, 0.2);
            border: 1px solid #f2f4f9;
        }

        .profile-page .profile-header .cover {
            position: relative;
            border-radius: .25rem .25rem 0 0;
        }


        .profile-page .profile-header .cover figure {
            margin-bottom: 0;
        }

        @media (max-width: 767px) {
            .profile-page .profile-header .cover figure {
                height: 110px;
                overflow: hidden;
            }
        }

        @media (min-width: 2400px) {
            .profile-page .profile-header .cover figure {
                height: 280px;
                overflow: hidden;
            }
        }

        .profile-page .profile-header .cover figure img {
            border-radius: .25rem .25rem 0 0;
            width: 100%;
        }

        @media (max-width: 767px) {
            .profile-page .profile-header .cover figure img {
                -webkit-transform: scale(2);
                transform: scale(2);
                margin-top: 15px;
            }
        }

        @media (min-width: 2400px) {
            .profile-page .profile-header .cover figure img {
                margin-top: -55px;
            }
        }

        .profile-page .profile-header .cover .gray-shade {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 1;
            background: linear-gradient(rgba(255, 255, 255, 0.1), #fff 99%);
        }

        .profile-page .profile-header .cover .cover-body {
            position: absolute;
            bottom: -20px;
            left: 0;
            z-index: 2;
            width: 100%;
            padding: 0 20px;
        }

        .profile-page .profile-header .cover .cover-body .profile-pic {
            border-radius: 50%;
            width: 100px;
        }

        @media (max-width: 767px) {
            .profile-page .profile-header .cover .cover-body .profile-pic {
                width: 70px;
            }
        }

        .profile-page .profile-header .cover .cover-body .profile-name {
            font-size: 20px;
            font-weight: 600;
            margin-left: 17px;
        }

        .profile-page .profile-header .header-links {
            padding: 15px;
            display: -webkit-flex;
            display: flex;
            -webkit-justify-content: center;
            justify-content: center;
            background: #fff;
            border-radius: 0 0 .25rem .25rem;
        }

        .profile-page .profile-header .header-links ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
        }

        .profile-page .profile-header .header-links ul li a {
            color: #000;
            -webkit-transition: all .2s ease;
            transition: all .2s ease;
        }

        .profile-page .profile-header .header-links ul li:hover,
        .profile-page .profile-header .header-links ul li.active {
            color: #727cf5;
        }

        .profile-page .profile-header .header-links ul li:hover a,
        .profile-page .profile-header .header-links ul li.active a {
            color: #727cf5;
        }

        .profile-page .profile-body .left-wrapper .social-links a {
            width: 30px;
            height: 30px;
        }

        .profile-page .profile-body .right-wrapper .latest-photos > .row {
            margin-right: 0;
            margin-left: 0;
        }

        .profile-page .profile-body .right-wrapper .latest-photos > .row > div {
            padding-left: 3px;
            padding-right: 3px;
        }

        .profile-page .profile-body .right-wrapper .latest-photos > .row > div figure {
            -webkit-transition: all .3s ease-in-out;
            transition: all .3s ease-in-out;
            margin-bottom: 6px;
        }

        .profile-page .profile-body .right-wrapper .latest-photos > .row > div figure:hover {
            -webkit-transform: scale(1.06);
            transform: scale(1.06);
        }

        .profile-page .profile-body .right-wrapper .latest-photos > .row > div figure img {
            border-radius: .25rem;
        }

        .rtl .profile-page .profile-header .cover .cover-body .profile-name {
            margin-left: 0;
            margin-right: 17px;
        }

        .img-xs {
            width: 37px;
            height: 37px;
        }

        .rounded-circle {
            border-radius: 50% !important;
        }

        img {
            vertical-align: middle;
            border-style: none;
        }

        .card-header:first-child {
            border-radius: 0 0 0 0;
        }

        .card-header {
            padding: 0.875rem 1.5rem;
            margin-bottom: 0;
            background-color: rgba(0, 0, 0, 0);
            border-bottom: 1px solid #f2f4f9;
        }

        .card-footer:last-child {
            border-radius: 0 0 0 0;
        }

        .card-footer {
            padding: 0.875rem 1.5rem;
            background-color: rgba(0, 0, 0, 0);
            border-top: 1px solid #f2f4f9;
        }

        .grid-margin {
            margin-bottom: 1rem;
        }

        .card {
            box-shadow: 0 0 10px 0 rgba(183, 192, 206, 0.2);
            -webkit-box-shadow: 0 0 10px 0 rgba(183, 192, 206, 0.2);
            -moz-box-shadow: 0 0 10px 0 rgba(183, 192, 206, 0.2);
            -ms-box-shadow: 0 0 10px 0 rgba(183, 192, 206, 0.2);
        }

        .rounded {
            border-radius: 0.25rem !important;
        }

        .card {
            position: relative;
            display: flex;
            flex-direction: column;
            min-width: 0;
            word-wrap: break-word;
            background-color: #fff;
            background-clip: border-box;
            border: 1px solid #f2f4f9;
            border-radius: 0.25rem;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .modal-content label {
            margin-bottom: 5px;
        }

        .modal-content input,
        .modal-content textarea,
        .modal-content select {
            width: 100%;
            margin-bottom: 10px;
            padding: 5px;
            box-sizing: border-box;
        }

        .modal-content button {
            width: auto;
        }

        .btn-edit-profile {
            cursor: pointer;
        }

        #postDialog {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 400px;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            text-align: center;
            z-index: 1000;
            height: 600px; /* Điều chỉnh chiều cao tại đây */
        }

        #postDialog textarea {
            width: 100%;
            height: 100px; /* Điều chỉnh chiều cao tại đây */
            margin-bottom: 10px;
        }

        #postButton {
            cursor: pointer;
            padding: 10px 20px;
            background-color: #3498db;
            color: #ffffff;
            border: none;
            border-radius: 5px;
        }

        .closeButton {
            position: absolute;
            top: 10px;
            right: 10px;
            cursor: pointer;
            font-size: 20px;
            color: #999999;
        }

        #imageInput {
            display: none;
        }

        #imageDisplay {
            width: 100%;
            height: 150px; /* Điều chỉnh chiều cao tại đây */
            margin-bottom: 10px;
        }

        #addImageButton {
            cursor: pointer;
            padding: 10px 20px;
            margin-top: 10px; /* Thêm margin-top để tạo khoảng cách giữa các nút */
            background-color: #3498db;
            color: #ffffff;
            border: none;
            border-radius: 5px;
        }

        #addImageButton {
            margin-right: 10px; /* Thêm margin-right để tạo khoảng cách giữa nút "Thêm ảnh" và nút "Đăng" */
        }

        #imageFrame {
            width: 100%; /* Đặt chiều rộng của khung ảnh là 100% */
            height: 300px; /* Đặt chiều cao của khung ảnh */
            border: 1px solid #ccc; /* Đặt đường viền cho khung ảnh */
            overflow: hidden; /* Ngăn chặn ảnh vượt qua khung */
        }

        #imagePreview {
            max-width: 100%;
            max-height: 100%; /* Giữ chiều cao của ảnh không vượt qua chiều cao của khung */
            display: block;
            margin: auto;
        }

        #likeButton {
            cursor: pointer;
            display: inline-flex;
            align-items: center;
        }

        #likeButton.active {
            color: red; /* Màu khi nút đã được like */
        }

        #likeButton.active svg path {
            fill: red; /* Đổi màu hình trái tim khi nút đã được like */
        }

        label {
            display: block;
            margin-bottom: 8px;
            text-align: left;
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


        #postDialog1 {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 400px;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            text-align: center;
            z-index: 1000;
            height: 480px; /* Điều chỉnh chiều cao tại đây */
        }

        .like-button {
            cursor: pointer;
            display: inline-flex;
            align-items: center;
        }

        .like-button.active {
            color: red;
        }

        .like-button.active svg path {
            fill: red;
        }
    </style>
</head>
<body>
<div class="container">
    <header>
        <nav>
            <ul class="horizontal-menu">
                <li><a href="${pageContext.request.contextPath}/home" class="link-style">Trang chủ</a></li>
                <li><a href="${pageContext.request.contextPath}/friend-request" class="link-style">Yêu cầu kết bạn</a>
                </li>
                <li><a href="${pageContext.request.contextPath}/profile/${cookie.userId.value}" class="link-style">Trang
                    cá nhân</a></li>
                <li><a href="${pageContext.request.contextPath}/logout" class="link-style">Đăng xuất</a></li>
                <div class="search-bar">
                    <form action="${pageContext.request.contextPath}/search" method="get">
                        <input type="text" name="name" placeholder="Tìm kiếm..." class="search-input">
                        <button type="submit" class="search-button">Tìm kiếm</button>
                    </form>
                </div>
            </ul>
        </nav>
    </header>
    <div class="profile-page tx-13">
        <div class="row">
            <div class="col-12 grid-margin">
                <div class="profile-header">
                    <div class="cover">
                        <div class="gray-shade"></div>
                        <figure>
                            <img src="https://bootdey.com/img/Content/bg1.jpg" class="img-fluid" alt="profile cover"
                                 style="max-height: 300px;">
                        </figure>
                        <div class="cover-body d-flex justify-content-between align-items-center">
                            <div>
                                <img class="profile-pic"
                                     src="https://bootdey.com/img/Content/avatar/avatar6.png"
                                     alt="profile">
                                <span class="profile-name"><%= ((User) request.getAttribute("user")).getFullName() %></span>

                            </div>
                            <div class="d-none d-md-block">
                                <c:choose>
                                    <c:when test="${userId == profileId}">
                                        <form id="updateProfileForm" method="post"
                                              action="${pageContext.request.contextPath}/profile/${userId}/updateprofile">
                                            <button type="submit" class="btn btn-primary btn-icon-text btn-edit-profile"
                                                    id="editProfileButton">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                     viewBox="0 0 24 24"
                                                     fill="none" stroke="currentColor" stroke-width="2"
                                                     stroke-linecap="round"
                                                     stroke-linejoin="round"
                                                     class="feather feather-edit btn-icon-prepend">
                                                    <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                                                    <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                                                </svg>
                                                Chỉnh sửa thông tin
                                            </button>
                                        </form>
                                    </c:when>
                                    <c:when test="${status == 'RequestReceived' }">
                                        <style>
                                            .profile-form {
                                                margin-bottom: 20px;
                                            }
                                        </style>

                                        <form id="acceptForm" class="profile-form"
                                              action="${pageContext.request.contextPath}/request-response"
                                              method="post">
                                            <input type="hidden" name="friendID" value="${profileId}">
                                            <input type="hidden" name="profile" value="profile">
                                            <button type="submit"
                                                    class="btn btn-primary btn-icon-text btn-edit-profile">
                                                Chấp nhận
                                            </button>
                                        </form>

                                        <style>
                                            .profile-form {
                                                margin-bottom: 20px;
                                            }

                                            .reject-button {
                                                background-color: red;
                                                color: white; /* Để đảm bảo văn bản trên button có đủ độ tương phản */
                                            }
                                        </style>
                                        <form id="rejectForm" class="profile-form" method="get"
                                              action="${pageContext.request.contextPath}/request-response">
                                            <input type="hidden" name="friendID" value="${profileId}">
                                            <input type="hidden" name="profile" value="profile">
                                            <button type="submit"
                                                    class="btn btn-primary btn-icon-text btn-edit-profile reject-button">
                                                Từ chối
                                            </button>
                                        </form>
                                    </c:when>
                                    <c:when test="${status == 'Friend' }">
                                        <style>
                                            .profile-form {
                                                margin-bottom: 20px;
                                            }
                                        </style>
                                        <input type="hidden" name="friendID" value="${profileId}" class="profile-form">
                                        <input type="hidden" name="profile" value="profile">
                                        <button type="submit"
                                                class="btn btn-primary btn-icon-text btn-edit-profile">
                                            Hai bạn là bạn bè
                                        </button>

                                        <style>
                                            .profile-form {
                                                margin-bottom: 20px;
                                            }

                                            .reject-button {
                                                background-color: red;
                                                color: white; /* Để đảm bảo văn bản trên button có đủ độ tương phản */
                                            }
                                        </style>
                                        <form id="rejectForm" class="profile-form" method="get"
                                              action="${pageContext.request.contextPath}/request-response">
                                            <input type="hidden" name="friendID" value="${profileId}">
                                            <input type="hidden" name="profile" value="profile">
                                            <button type="submit"
                                                    class="btn btn-primary btn-icon-text btn-edit-profile reject-button">
                                                Xoá bạn bè
                                            </button>
                                        </form>
                                    </c:when>
                                    <c:when test="${status == 'RequestSent' }">
                                        <form id="rejectForm" class="profile-form" method="get"
                                              action="${pageContext.request.contextPath}/request-response">
                                            <input type="hidden" name="friendID" value="${profileId}">
                                            <input type="hidden" name="profile" value="profile">
                                            <button type="submit"
                                                    class="btn btn-primary btn-icon-text btn-edit-profile reject-button">
                                                Huỷ lời mời
                                            </button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <form id="addFriendForm" method="post"
                                              action="${pageContext.request.contextPath}/add-friend">
                                            <input type="hidden" name="friendId" value="${profileId}">
                                            <button type="submit" class="btn btn-primary btn-icon-text btn-add-friend">
                                                Thêm bạn
                                            </button>
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    <div class="header-links">
                        <ul class="links d-flex align-items-center mt-3 mt-md-0">
                            <li class="header-link-item ml-3 pl-3 border-left d-flex align-items-center">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                     fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                     stroke-linejoin="round" class="feather feather-columns mr-1 icon-md">
                                    <path d="M12 3h7a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-7m0-18H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h7m0-18v18"></path>
                                </svg>
                                <a class="pt-1px d-none d-md-block" href="#">Dòng thời gian</a>
                            </li>
                            <li class="header-link-item ml-3 pl-3 border-left d-flex align-items-center">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                     fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                     stroke-linejoin="round" class="feather feather-user mr-1 icon-md" id="userIcon">
                                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                    <circle cx="12" cy="7" r="4"></circle>
                                </svg>
                                <c:if test="${userId == profileId}">
                                    <a class="pt-1px d-none d-md-block" href="#" id="userInfoLink">Tạo Bài Viết </a>
                                </c:if>
                                <c:if test="${userId != profileId}">
                                    <a class="pt-1px d-none d-md-block" href="#" id="userInfoLink">..... </a>
                                </c:if>

                            </li>
                            <li class="header-link-item ml-3 pl-3 border-left d-flex align-items-center">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                     fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                     stroke-linejoin="round" class="feather feather-users mr-1 icon-md">
                                    <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                                    <circle cx="9" cy="7" r="4"></circle>
                                    <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                                    <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                                </svg>
                                <a class="pt-1px d-none d-md-block"
                                   href="${pageContext.request.contextPath}/friend-list">Bạn bè <span
                                        class="text-muted tx-12">${friends.size()}</span></a>
                            </li>
                            <li class="header-link-item ml-3 pl-3 border-left d-flex align-items-center">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                     fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                     stroke-linejoin="round" class="feather feather-image mr-1 icon-md">
                                    <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                                    <circle cx="8.5" cy="8.5" r="1.5"></circle>
                                    <polyline points="21 15 16 10 5 21"></polyline>
                                </svg>
                                <a class="pt-1px d-none d-md-block" href="#">Hình ảnh</a>
                            </li>
                            <li class="header-link-item ml-3 pl-3 border-left d-flex align-items-center">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                     fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                     stroke-linejoin="round" class="feather feather-video mr-1 icon-md">
                                    <polygon points="23 7 16 12 23 17 23 7"></polygon>
                                    <rect x="1" y="5" width="15" height="14" rx="2" ry="2"></rect>
                                </svg>
                                <a class="pt-1px d-none d-md-block" href="#">Video</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="row profile-body">
            <div class="d-none d-md-block col-md-4 col-xl-3 left-wrapper">
                <div class="card rounded">
                    <div class="card-body">
                        <div class="d-flex align-items-center justify-content-between mb-2"><label
                                class="tx-11 font-weight-bold mb-0 text-uppercase">Giới thiệu:</label>
                            <div class="dropdown">
                                <button class="btn p-0" type="button" id="dropdownMenuButton" data-toggle="dropdown"
                                        aria-haspopup="true" aria-expanded="false">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                         fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                         stroke-linejoin="round"
                                         class="feather feather-more-horizontal icon-lg text-muted pb-3px">
                                        <circle cx="12" cy="12" r="1"></circle>
                                        <circle cx="19" cy="12" r="1"></circle>
                                        <circle cx="5" cy="12" r="1"></circle>
                                    </svg>
                                </button>
                                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                    <a class="dropdown-item d-flex align-items-center" href="#">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                             viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                             stroke-linecap="round" stroke-linejoin="round"
                                             class="feather feather-edit-2 icon-sm mr-2">
                                            <path d="M17 3a2.828 2.828 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5L17 3z"></path>
                                        </svg>
                                        <span class>Edit</span></a>
                                    <a class="dropdown-item d-flex align-items-center" href="#">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                             viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                             stroke-linecap="round" stroke-linejoin="round"
                                             class="feather feather-git-branch icon-sm mr-2">
                                            <line x1="6" y1="3" x2="6" y2="15"></line>
                                            <circle cx="18" cy="6" r="3"></circle>
                                            <circle cx="6" cy="18" r="3"></circle>
                                            <path d="M18 9a9 9 0 0 1-9 9"></path>
                                        </svg>
                                        <span class>Update</span></a>
                                    <a class="dropdown-item d-flex align-items-center" href="#">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                             viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                             stroke-linecap="round" stroke-linejoin="round"
                                             class="feather feather-eye icon-sm mr-2">
                                            <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                                            <circle cx="12" cy="12" r="3"></circle>
                                        </svg>
                                        <span class>View all</span></a>
                                </div>
                            </div>
                        </div>
                        <p><%= ((User) request.getAttribute("user")).getBiography() %>
                        </p>
                        <div class="mt-3">
                        </div>
                        <div class="mt-3">
                            <label class="tx-11 font-weight-bold mb-0 text-uppercase">Email:</label>
                            <p class="text-muted"><%= ((User) request.getAttribute("user")).getEmail() %>
                            </p>
                        </div>
                        <div class="mt-3">
                        </div>
                        <div class="mt-3">
                            <label class="tx-11 font-weight-bold mb-0 text-uppercase">Giới tính:</label>
                            <p class="text-muted">
                                <c:choose>
                                    <c:when test="${gender}">
                                        Nam
                                    </c:when>
                                    <c:otherwise>
                                        Nữ
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        <div class="mt-3 d-flex social-links">
                            <a href="javascript:;"
                               class="btn d-flex align-items-center justify-content-center border mr-2 btn-icon github">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                     fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                     stroke-linejoin="round" class="feather feather-github" data-toggle="tooltip" title
                                     data-original-title="github.com/nobleui">
                                    <path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"></path>
                                </svg>
                            </a>
                            <a href="javascript:;"
                               class="btn d-flex align-items-center justify-content-center border mr-2 btn-icon twitter">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                     fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                     stroke-linejoin="round" class="feather feather-twitter" data-toggle="tooltip" title
                                     data-original-title="twitter.com/nobleui">
                                    <path d="M23 3a10.9 10.9 0 0 1-3.14 1.53 4.48 4.48 0 0 0-7.86 3v1A10.66 10.66 0 0 1 3 4s-4 9 5 13a11.64 11.64 0 0 1-7 2c9 5 20 0 20-11.5a4.5 4.5 0 0 0-.08-.83A7.72 7.72 0 0 0 23 3z"></path>
                                </svg>
                            </a>
                            <a href="javascript:;"
                               class="btn d-flex align-items-center justify-content-center border mr-2 btn-icon instagram">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                     fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                     stroke-linejoin="round" class="feather feather-instagram" data-toggle="tooltip"
                                     title data-original-title="instagram.com/nobleui">
                                    <rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect>
                                    <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path>
                                    <line x1="17.5" y1="6.5" x2="17.51" y2="6.5"></line>
                                </svg>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-8 col-xl-6 middle-wrapper">
                <div class="row">
                    <div class="col-md-12 grid-margin">
                        <c:set var="posts" value="<%= posts %>"/>

                        <c:set var="userName" value="<%= user.getFullName() %>"/>
                        <c:choose>
                        <c:when test="${not empty posts and posts.size() > 0}">
                        <c:forEach var="post" items="${posts}">
                            <div class="col-md-12">
                                <div class="card rounded">
                                    <div class="card-header">
                                        <div class="d-flex align-items-center justify-content-between">
                                            <div class="d-flex align-items-center">
                                                <img class="img-xs rounded-circle"
                                                     src="https://bootdey.com/img/Content/avatar/avatar6.png" alt>
                                                <div class="ml-2">
                                                    <p>${userName}</p>
                                                    <p>${post.post.timestamp.format(formatter)}</p>
                                                </div>
                                            </div>
                                            <div class="dropdown">
                                                <button class="btn p-0" type="button" id="dropdownMenuButton3"
                                                        data-toggle="dropdown" aria-haspopup="true"
                                                        aria-expanded="false">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                         viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                         stroke-width="2"
                                                         stroke-linecap="round" stroke-linejoin="round"
                                                         class="feather feather-more-horizontal icon-lg pb-3px">
                                                        <circle cx="12" cy="12" r="1"></circle>
                                                        <circle cx="19" cy="12" r="1"></circle>
                                                        <circle cx="5" cy="12" r="1"></circle>
                                                    </svg>
                                                </button>
                                                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton3">
                                                    <a class="dropdown-item d-flex align-items-center" href="#">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                             viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                             stroke-width="2" stroke-linecap="round"
                                                             stroke-linejoin="round"
                                                             class="feather feather-meh icon-sm mr-2">
                                                            <circle cx="12" cy="12" r="10"></circle>
                                                            <line x1="8" y1="15" x2="16" y2="15"></line>
                                                            <line x1="9" y1="9" x2="9.01" y2="9"></line>
                                                            <line x1="15" y1="9" x2="15.01" y2="9"></line>
                                                        </svg>
                                                        <span class>Unfollow</span></a>
                                                    <a class="dropdown-item d-flex align-items-center" href="#">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                             viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                             stroke-width="2" stroke-linecap="round"
                                                             stroke-linejoin="round"
                                                             class="feather feather-corner-right-up icon-sm mr-2">
                                                            <polyline points="10 9 15 4 20 9"></polyline>
                                                            <path d="M4 20h7a4 4 0 0 0 4-4V4"></path>
                                                        </svg>
                                                        <span class>Go to post</span></a>
                                                    <a class="dropdown-item d-flex align-items-center" href="#">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                             viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                             stroke-width="2" stroke-linecap="round"
                                                             stroke-linejoin="round"
                                                             class="feather feather-share-2 icon-sm mr-2">
                                                            <circle cx="18" cy="5" r="3"></circle>
                                                            <circle cx="6" cy="12" r="3"></circle>
                                                            <circle cx="18" cy="19" r="3"></circle>
                                                            <line x1="8.59" y1="13.51" x2="15.42" y2="17.49"></line>
                                                            <line x1="15.41" y1="6.51" x2="8.59" y2="10.49"></line>
                                                        </svg>
                                                        <span class>Share</span></a>
                                                    <a class="dropdown-item d-flex align-items-center" href="#">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                             viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                             stroke-width="2" stroke-linecap="round"
                                                             stroke-linejoin="round"
                                                             class="feather feather-copy icon-sm mr-2">
                                                            <rect x="9" y="9" width="13" height="13" rx="2"
                                                                  ry="2"></rect>
                                                            <path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path>
                                                        </svg>
                                                        <span class>Copy link</span></a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <p class="mb-3 tx-14">${post.post.content}</p>
                                        <img class="img-fluid" src="../../../assets/images/sample2.jpg" alt>
                                    </div>
                                    <div class="card-footer">
                                        <div class="d-flex post-actions">
                                            <a href="javascript:;" class="d-flex align-items-center text-muted mr-4">
                                                <div id="likeButton" onclick="toggleLike(this, ${post.post.postId})"
                                                     data-post-id="${post.post.postId}">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                         viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                         stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                                         class="feather feather-heart icon-md">
                                                        <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                                                    </svg>
                                                    <p class="d-none d-md-block ml-2">Like</p>
                                                    <p class="like-count">(${post.likeCount})</p>
                                                </div>

                                            </a>
                                            <a href="javascript:;" class="d-flex align-items-center text-muted mr-4">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                     viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                     stroke-width="2"
                                                     stroke-linecap="round" stroke-linejoin="round"
                                                     class="feather feather-message-square icon-md">
                                                    <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
                                                </svg>
                                                <p class="d-none d-md-block ml-2">Comment</p>
                                            </a>
                                            <a href="javascript:;" class="d-flex align-items-center text-muted">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                     viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                     stroke-width="2"
                                                     stroke-linecap="round" stroke-linejoin="round"
                                                     class="feather feather-share icon-md">
                                                    <path d="M4 12v8a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2v-8"></path>
                                                    <polyline points="16 6 12 2 8 6"></polyline>
                                                    <line x1="12" y1="2" x2="12" y2="15"></line>
                                                </svg>
                                                <p class="d-none d-md-block ml-2">Share</p>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="friend" items="${friends}">
                            <div class="d-flex align-items-center">
                                <a href="${pageContext.request.contextPath}/profile/${friend.userId}">
                                    <img class="img-xs rounded-circle"
                                         src="https://bootdey.com/img/Content/avatar/avatar6.png" alt>
                                </a>
                                <div class="ml-2">
                                    <p>${friend.fullName}</p>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="postDialog">
    <span class="closeButton" onclick="closePostDialog()">&times;</span>
    <form action="${pageContext.request.contextPath}/upload-post" method="post" accept-charset="UTF-8">
        <textarea name="postContent" placeholder="Nhập nội dung bài viết"></textarea>
        <div id="imageFrame">
            <img id="imagePreview" alt="Image Preview">
        </div>
        <label for="imageInput" id="addImageButtonLabel" class="custom-file-upload">
            Thêm ảnh
        </label>
        <input type="file" name="imageInput" id="imageInput" onchange="previewImage()" style="display:none;">
        <button type="submit" id="postButton">Đăng</button>
    </form>
</div>

<div id="postDialog1">
    <span class="closeButton" onclick="closeEditDialog()">&times;</span>
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
        </div>
    </form>
</div>

<script data-cfasync="false" src="/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script>
<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    function redirectToUpdateProfile() {
        window.location.href = "<%= request.getContextPath() %>/profile/<%= user.getUserId() %>/updateprofile";

    }
</script>
<script>
    function openPostDialog() {
        document.getElementById('postDialog').style.display = 'block';
    }

    function closePostDialog() {
        document.getElementById('postDialog').style.display = 'none';
        // Reset input file và hình xem trước khi đóng dialog
        document.getElementById('imageInput').value = '';
        document.getElementById('imagePreview').innerHTML = '';
        document.getElementById('postContent').value = ''; // Reset giá trị của textarea nội dung
    }

    function openImageInput() {
        document.getElementById('imageInput').click();
    }

    // Bắt sự kiện khi nhấn vào liên kết "Thông tin người dùng"
    document.getElementById('userInfoLink').addEventListener('click', function (event) {
        event.preventDefault();
        // Mở dialog khi nhấn vào liên kết "Thông tin người dùng"
        openPostDialog();
    });

    function previewImage() {
        var input = document.getElementById('imageInput');
        var imagePreview = document.getElementById('imagePreview');

        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                // Hiển thị ảnh trong thẻ <img> trong khung
                imagePreview.src = e.target.result;
            };

            reader.readAsDataURL(input.files[0]);
        }
    }
</script>
<script>
    function toggleLike() {
        var likeButton = document.getElementById('likeButton');
        likeButton.classList.toggle('active');
    }

</script>
<script>
    document.getElementById('editProfileButton').addEventListener('click', function (event) {
        event.preventDefault();
        openEditDialog();
    });

    function openEditDialog() {
        document.getElementById('postDialog1').style.display = 'block';
        // Các bước khác để chuẩn bị dialog khi cần
    }

    function closeEditDialog() {
        document.getElementById('postDialog1').style.display = 'none';
        // Các bước khác để đóng dialog khi cần
    }

    function toggleLike(likeButton, postId) {
        likeButton.classList.toggle('active');

        fetch('${pageContext.request.contextPath}/action-like', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                action: 'like',
                postId: postId,
            }),
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                // Handle the response from the servlet if needed
                console.log(data);

                // Assuming the response includes the updated like count
                const updatedLikeCount = data.updatedLikeCount;

                // Update the like count in the HTML
                const postContainer = likeButton.closest('.post-container');
                const likeCountElement = postContainer.querySelector('.like-count');
                likeCountElement.textContent = updatedLikeCount;
            })
            .catch(error => {
                console.error('There was a problem with the fetch operation:', error);
            });
    }

</script>
</body>
</html>