<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.mangxahoi.Entity.Post" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    ArrayList<Post> posts;
    if (request.getAttribute("posts") != null) {
        posts = (ArrayList<Post>) request.getAttribute("posts");
    } else {
        posts = new ArrayList<>();
    }
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm dd-MM-yyyy");
%>
<c:set var="formatter" value="<%= formatter %>"/>

<html>
<head>
    <title>Title</title>
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
            color: #999999; để tạo khoảng cách giữa nút "Thêm ảnh" và nút "Đăng" */
        }
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
            margin-right: 10px; /* Thêm margin-right
        #imageFrame {
            width: 100%; /* Đặt chiều rộng của khung ảnh là 100% */
            height: 300px; /* Đặt chiều cao của khung ảnh */
            border: 1px solid #ccc; /* Đặt đường viền cho khung ảnh */
            overflow: hidden; /* Ngăn chặn ảnh vượt qua khung */
        }

        #imagePreview {
            max-width: 100%;
            max-height: 100%;/* Giữ chiều cao của ảnh không vượt qua chiều cao của khung */
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
            </ul>
        </nav>
    </header>
    <div class="col-md-8 col-xl-6 middle-wrapper">
        <div class="row">
            <div class="col-md-12 grid-margin">
                <c:set var="posts" value="<%= posts %>"/>
                <c:forEach var="post" items="${posts}">
                    <div class="col-md-12">
                        <div class="card rounded">
                            <div class="card-header">
                                <div class="d-flex align-items-center justify-content-between">
                                    <div class="d-flex align-items-center">
                                        <img class="img-xs rounded-circle"
                                             src="https://bootdey.com/img/Content/avatar/avatar6.png" alt>
                                        <div class="ml-2">
                                            <p>${post.userId.fullName}</p>
                                            <p>${post.timestamp.format(formatter)}</p>
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
                                <p class="mb-3 tx-14">${post.content}</p>
                                <img class="img-fluid" src="../../../assets/images/sample2.jpg" alt>
                            </div>
                            <div class="card-footer">
                                <div class="d-flex post-actions">
                                    <a href="javascript:;" class="d-flex align-items-center text-muted mr-4">
                                        <div id="likeButton" onclick="toggleLike()">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                 viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                 stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                                 class="feather feather-heart icon-md">
                                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                                            </svg>
                                            <p class="d-none d-md-block ml-2">Like</p>
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
        </div>
    </div>
</div>
</div>
</body>
</html>
