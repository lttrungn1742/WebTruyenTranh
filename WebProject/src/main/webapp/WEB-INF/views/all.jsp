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
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/bootstrap-5.0.1-dist/css/bootstrap.min.css">
    <script src="${pageContext.servletContext.contextPath}/assets/bootstrap-5.0.1-dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/story/style.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>

<body>
    <div class="top">
        <div class="top-top">
            <div class="top-icon-left">
                <a href="${pageContext.servletContext.contextPath}/index.html">
                    <img src="${pageContext.servletContext.contextPath}/images/icon-128.png" alt="icon" style="margin-right: 2px;width: 18px;">
                    <span style="font-size: 17px;margin-right: 30px;">ManagaToon</span>
                </a>
            </div>
            <div class="login-user">
                ${sign}
                
            </div>
        </div>
        <div class="top-bottom">
            <div class="icon">
                <a href="${pageContext.servletContext.contextPath}/index.html"><img src="${pageContext.servletContext.contextPath}/images/logo.svg" alt=""></a>
            </div>

        </div>
    </div>
    <img src="${pageContext.servletContext.contextPath}/images/circle-left.png" class="circle-left">
    <img src="${pageContext.servletContext.contextPath}/images/circle-right.png" class="circle-right">
    <div class="container-fluid" style="margin-left: 10%;margin-right: 10%; width: 80%;">
        <div class="row" style="margin-top: 100px;background:#E7ECF0;">
            <div class="row" style="margin-top:5%; margin-bottom:5%">
            	<div class="col-md-2" >
            		<h4 style="margin-left:40%;">Thể Loại</h4>
            	</div>
            	<div class="col">
            		 <div class="row row-cols-auto row-cols-lg-auto g-2 g-lg-3" >
            		 <div class="col">
	                        	<a href="${pageContext.servletContext.contextPath}/all.html"><span style="padding: 5px;background-color:#0CE6FA" class="border  rounded-pill">Tất cả </span></a>
		                    </div>
                 		<c:forEach var="iterator" items="${category}">
	                   
		                    <div class="col">
	                        	<a href="${pageContext.servletContext.contextPath}/all/${iterator.getId()}.html"><span style="padding: 5px;background-color:#F94364" class="border rounded-pill">${iterator.getName()}</span></a>
		                    </div>
		             </c:forEach>		
                 
           </div>
            	</div>
            </div>
            
       
        </div>
    	   <div class="row row-cols-4 row-cols-lg-6 " style="margin-top: 50px;margin-bottom: 100px">
                 <c:forEach var="iterator" items="${list}">
	                 <div class="col">
                     	 <a href="${pageContext.servletContext.contextPath}/index/${iterator.getId()}.html"><img    src="data:image/jpg;base64,${iterator.getImage()}"/></a>

                        <span>${iterator.getName(15)}</span>
                    </div>
	             </c:forEach>
                 
           </div>
    </div>
       
    
</body>

</html>