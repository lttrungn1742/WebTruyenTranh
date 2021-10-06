<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Managa Toon | Admin</title> 
         <link rel="icon" type="image/png" href="${pageContext.servletContext.contextPath}/dist/img/icon-128.png"/>
    <link rel="stylesheet"  href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback"> 
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/dist/css/adminlte.min.css">
    <link rel="stylesheet"  href="${pageContext.servletContext.contextPath}/assets/bootstrap-toggle-master/css/bootstrap-toggle.css">	
     <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/story/style.css">
    
</head>

<body class="hold-transition sidebar-mini">
    <div class="wrapper">
        <nav class="main-header navbar navbar-expand navbar-white navbar-light">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
                </li>
               
            </ul>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" data-widget="fullscreen" href="#" role="button">
                        <i class="fas fa-expand-arrows-alt"></i>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-widget="control-sidebar" data-slide="true" href="#" role="button">
                        <i class="fas fa-th-large"></i>
                    </a>
                </li>
            </ul>
        </nav>
        <aside class="main-sidebar sidebar-white-primary elevation-4">
            <div  class="brand-link" style="height: 70px;">
                <a href="${pageContext.servletContext.contextPath}/index.html">
                	<img style="transform: translateY(20px); " src="${pageContext.servletContext.contextPath}/dist/img/logo.svg" class="brand-image img-circle elevation-3" >
                </a>
            </div>
            <div class="sidebar">
           
                <nav class="mt-2">
                    <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu"   data-accordion="false">
               
                        <li class="nav-item">
                                    <a href="${pageContext.servletContext.contextPath}/admin/create.html" class="nav-link active">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Thêm Truyện</p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                   <a href="${pageContext.servletContext.contextPath}/admin/data.html" class="nav-link ">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Dữ Liệu</p>
                                  </a>
                           </li>
                              <li class="nav-item">
                                   <a href="${pageContext.servletContext.contextPath}/admin/profile.html" class="nav-link ">
                                        <i class="far fa-circle nav-icon"></i>
                                         <p>Trang cá nhân</p>
                                  </a>
                           </li>
                        
                    </ul>
                </nav>
            </div>
        </aside>
        <div class="content-wrapper">
            <section class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        
                        <div  style="float:right;">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="${pageContext.servletContext.contextPath}/admin/data.html">Home</a></li>
                                <li class="breadcrumb-item active">Thêm</li>
                            </ol>
                        </div>
                    </div>
                </div><!-- /.container-fluid -->
            </section>
			<div class="card">
					 <div class="row g-2 align-items-center" style="margin-top: 30px;">
				<div class="col-md-4" style="margin-left: 30px;">
					      <img width="400" height=600 style="float: left;" src="data:image/jpg;base64,${story.getImage()}" class="rounded mx-auto d-block" alt="">
				</div>
					        <div class="col-md-6">
					               		<div class="row">
					               			<h3 id="name-story">${story.getName()}</h3>
					                    	<span style=" background-color:#0dcaf0;margin-left:30px;text-align: center; " class="border border-info rounded-pill">${story.getStatus()}</span>
					                 
					                 	</div>
					                    <p >${story.listCategory(" / ")}</p>
					                    <p >Tên Tác Giả : ${story.getNameAuthor()}</p>
					                    <p>${story.getDescription()}</p>
				
					
					      </div>
				</div>
				<hr style=" border: 10px solid drakgray; width:100%; margin-top: 30px;">
				<div class="row row-cols-2 row-cols-lg-5 g-2 g-lg-3" style="margin-bottom: 100px;margin-left:30px;">
		            <c:forEach var="iterator" items="${story.getChapers()}" varStatus="status">
		                <div  class="chaper col" style="background-color: #C3D3E2; padding-left: 20px;">
		                    <div class="row">
		                    	<input type="hidden" value="${iterator.getId()}" >
		                    	<input type="hidden" value="${status.index + 1 }">
		                    	<div class="col">
		                    		<span>${status.index + 1 } Chương ${status.index + 1}</span><br>
		                    		<span>${iterator.getDateString()} </span></div>
		                   		<div class="col">
		                   			<a class="btn btn-primary btn-sm" href="./editChaper.html?id=${iterator.getId()}"><i class="fas fa-folder">  Xem</i></a>
				                    <a class="btn btn-danger btn-sm" data-toggle="modal" onclick="delChap(this)" href="#delChap"><i class="fas fa-trash"></i></a>
				                    
		                   		</div>
		                    </div>
		                </div>
		            </c:forEach>
		        </div> 
        </div>
			</div>
       
       
       
        <aside class="control-sidebar control-sidebar-dark">
        </aside>
    </div>
    
		<div class="modal fade" id="delChap" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		        <div class="modal-dialog" role="document">
		            <div class="modal-content">
		                <div class="modal-header">
		                    <h5 class="modal-title">Bạn Có Muốn Xóa Chương Này</h5>
		                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		                        <span aria-hidden="true">&times;</span>
		                    </button>
		                </div>
		                <div class="modal-body">
		          
		                  <form:form modelAttribute="chap" action="delChap.html">
		                        <form:input path="id" id="chap-id" type="hidden" />
		                        <div class="form-group">
		                            <label id="chap-id-label" class="col-form-label">#</label>
		                            
		                        </div>
		                        <div class="form-group">
		                            <label id="chap-label" class="col-form-label"></label>
		                           
		                        </div>
		                        
		                        <div class="modal-footer">
		                            <button class="btn btn-secondary" data-dismiss="modal">Đóng</button>
		                            <button type="submit" class="btn btn-primary">Lưu</button>
		                        </div>
		                    </form:form> 
		                </div>
		            </div>
		        </div>
		    </div>    
    
    <script>
    function delChap(id) {
      	 var root = id.parentNode.parentNode;
           $("#chap-id-label").text("Chương Thứ : \t" + $(root.getElementsByTagName("input")[1]).val());
           $("#chap-id").val($(root.getElementsByTagName("input")[0]).val());
           $("#chap-label").text("Của Truyện : \t"+ $("#name-story").html());
         
      }
    
    </script>
    <script src="${pageContext.servletContext.contextPath}/plugins/jquery/jquery.min.js"></script>
    <script src="${pageContext.servletContext.contextPath}/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.servletContext.contextPath}/dist/js/adminlte.min.js"></script>
    <script src="${pageContext.servletContext.contextPath}/dist/js/demo.js"></script>		
    <script src="${pageContext.servletContext.contextPath}/assets/bootstrap-toggle-master/js/bootstrap-toggle.js"></script>

</body>

</html>