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
           <%--  <div class="login-user">
                <a href="${pageContext.servletContext.contextPath}/login.html">Đăng Nhập</a>
                <div class="logout-user" style="display: none;">
                    <a href="${pageContext.servletContext.contextPath}/logout.html">Đăng Xuất</a>
                </div>
            </div> --%>
        </div>
        <div class="top-bottom">
            <div class="icon" >
                <a href="${pageContext.servletContext.contextPath}/index.html"><img src="${pageContext.servletContext.contextPath}/images/logo.svg" alt=""></a> 
             
            </div>

        </div>
    </div>
    <img src="${pageContext.servletContext.contextPath}/images/circle-left.png" class="circle-left">
    <img src="${pageContext.servletContext.contextPath}/images/circle-right.png" class="circle-right">
    
    <div class="container-fluid" style="margin-left: 10%;margin-right: 10%; width: 80%; margin-top: 130px;">
    
            <div class="row">
            	<c:forEach var="iterator" items="${list}">
                <img width="70%" class="rounded mx-auto d-block " src="data:image/jpg;base64,${iterator.getImg()}"/> 
            </c:forEach>
            </div>
            <div class="row">
            	 <div class="nav-bar-bottom">
                <div class="bottom-bar">
                    ${front}
                    ${back}
                </div>
            </div> 
            </div>
    </div>
     
</body>

</html>