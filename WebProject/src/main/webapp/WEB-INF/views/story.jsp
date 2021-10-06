<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="icon" type="image/png" href="https://mangatoon.mobi/images/icon-128.png">
    <title>Manga Toon - Truyện tranh</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <link rel="stylesheet"
        href="${pageContext.servletContext.contextPath}/assets/bootstrap-5.0.1-dist/css/bootstrap.min.css">
    <script
        src="${pageContext.servletContext.contextPath}/assets/bootstrap-5.0.1-dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/story/style.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>

<body>
    <div class="top">
        <div class="top-top">
            <div class="top-icon-left">
                <a href="${pageContext.servletContext.contextPath}/index.html">
                    <img src="${pageContext.servletContext.contextPath}/images/icon-128.png" alt="icon"
                        style="margin-right: 2px;width: 18px;">
                    <span style="font-size: 17px;margin-right: 30px;">ManagaToon</span>
                </a>
            </div>
            <div class="login-user">
                ${sign}
            </div>
        </div>
        <div class="top-bottom">
            <div class="icon">
                <a href="index.html"><img src="${pageContext.servletContext.contextPath}/images/logo.svg" alt=""></a>
            </div>
        </div>
    </div>
    <img src="${pageContext.servletContext.contextPath}/images/circle-left.png" class="circle-left">
    <img src="${pageContext.servletContext.contextPath}/images/circle-right.png" class="circle-right">
    <div class="container-fluid" style="margin-left: 10%;margin-right: 10%; width: 80%;">
        <div class="row g-2 align-items-center" style="margin-top: 130px;">
            <div class="col-md-6">
                <img width="550" style="float: left;" src="data:image/jpg;base64,${story.getImage()}"
                    class="rounded mx-auto d-block" alt="">
            </div>
            <div class="col-md-5">
                <div class="row">
                    <h3 style=" width: auto;">${story.getName()}</h3>
                    <h7 style="width: auto;background-color:#0dcaf0; height: auto;"
                        class="border border-info rounded-pill">${story.getStatus()}</h7>
                    <p>${story.listCategory(" / ")}</p>
                    <p>Tên Tác Giả : ${story.getNameAuthor()}</p>
                    <p>${story.getDescription()}</p>
                </div>

            </div>
        </div>
        <div class="row" style="margin-top: 50px;">
            <a href="#" style="width: auto;">
                <div class="div" style="height: 50px;width: 200px;color: whitesmoke;background: #FF204E;box-shadow: 0px 5px 10px rgb(255 32 78 / 30%);    opacity: 1;    border-radius: 100px;    display: flex;   justify-content: center;    align-items: center;   padding: 0 15px;">
                    <span>Bắt Đầu Xem Ch.1</span>
                </div>
            </a>
            <h4 style="width:auto; float:right;color:darkgray;">Đã cập nhật ${story.getChapers().size()} chương </h4>
            <hr style=" border: 10px solid drakgray; width:100%; margin-top: 30px;">
        </div> 
        <div class="row row-cols-2 row-cols-lg-4 g-2 g-lg-3" style="margin-bottom: 100px;">
            <c:forEach var="iterator" items="${story.getChapers()}" varStatus="status">
                <a href="${pageContext.servletContext.contextPath}/index/watch/${iterator.getId()}.html" class="chaper col" style="background-color: #C3D3E2; padding-left: 20px;">
                    <span>${status.index + 1 } Chương ${status.index +1}</span><br>
                    <span>${iterator.getDateString()} </span>
                </a>
            </c:forEach>

        </div>
    </div>
    <footer class="main-footer">

    </footer>
</body>

</html>