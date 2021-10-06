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
                </a> </div>
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
                                <li class="breadcrumb-item"><a href="#">Trang Chủ</a></li>
                                <li class="breadcrumb-item active">Thêm Chương Mới</li>
                            </ol>
                        </div>
                    </div>
                </div><!-- /.container-fluid -->
            </section>

            <section class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-9" style="transform: translateX(10%);">
                            <div class="card"  >
                                <div class="card-header">
                                    <h2 class="card-title"> Thêm Chương Thứ ${length + 1}</h2>
                                    
                                </div>
                                <form:form  modelAttribute="chap" style="margin-left: 10%;" enctype="multipart/form-data" action="newChap.html" >
                                      <form:input path="chap.idStory" type="hidden" value="${idStory}"/>
                                      <form:input path="chap.serial" type="hidden" value="${length + 1}"/>
                                       <form:input path="chap.id" type="hidden" />
                                
                                <div id="chapter">
                                	 <div class="row g-2 align-items-center" style="margin-top: 2%; margin-bottom:2%;">
                                
                                        <div class="col-md-2">
                                            <label for="image" class="form-label">Hình Ảnh </label>
                                        </div>
                                        <div class="col-md-6">
                                           	<input  type="file" onchange="changeInput(this)" class="form-control-file" id="0"  accept="image/*"/>
                                            <img src="#"  class="img-thumbnail" id="image-show-0">
                                            <form:input path="images[0]" type="hidden" /> 
                                        </div>
                                    </div>
                                </div>
                                   
									          
									<div class="row" id="form-footer" style="margin-top: 2%; margin-bottom:2%;">
                                       <button type="submit" class="btn btn-primary mb-3" style="margin-left:30%;width: 20%;font-size: medium;">Thêm</button>
                                    </div>
									
                                </form:form>
                            </div>
                        </div>
                        
                        
                     </div>
                   </div>
            </section>
        </div>
        <footer class="main-footer">
            
        </footer>
        <aside class="control-sidebar control-sidebar-dark">
        </aside>
    </div>
    <script src="${pageContext.servletContext.contextPath}/plugins/jquery/jquery.min.js"></script>
    <script src="${pageContext.servletContext.contextPath}/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.servletContext.contextPath}/dist/js/adminlte.min.js"></script>
    <script src="${pageContext.servletContext.contextPath}/dist/js/demo.js"></script>		
    <script src="${pageContext.servletContext.contextPath}/assets/bootstrap-toggle-master/js/bootstrap-toggle.js"></script>

    <script type="text/javascript">
        function toDataURL(url, callback) {
            var xhr = new XMLHttpRequest();
            xhr.onload = function () {
                var reader = new FileReader();
                reader.onloadend = function () {
                    callback(reader.result);
                }
                reader.readAsDataURL(xhr.response);
            };
            xhr.open('GET', url);
            xhr.responseType = 'blob';
            xhr.send();
        }

        var count = 1;

        function changeInput(id) {
            var str = `<div class="row g-2 align-items-center" style="margin-top: 2%; margin-bottom:2%;">
                            <div class="col-md-2">
                                <label for="image" class="form-label">Hình Ảnh</label>
                            </div>
                            <div class="col-md-6">
                                <input type="file" onchange="changeInput(this)" class="form-control-file" id="`+ count + `" accept="image/*">
                                <img src="#" class="img-thumbnail" id="image-show-`+ count + `">
                                <input id="images`+ count + `" name="images[` + count + `]" type="hidden" value=""> 
                            </div>
                        </div>
                        `;
          
            if (id.files && id.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#image-show-' + id.id).attr('src', e.target.result);
                    toDataURL(e.target.result, function (dataUrl) {
                        $("#images" + id.id).val(dataUrl.substr(23));
                    });
                    if (count - 1 == parseInt(id.id)) {
                        $("#chapter").append(str);
                        
                        count++;
                    }
                }
                reader.readAsDataURL(id.files[0]);
            }
        }
    </script>
  
</body>

</html>