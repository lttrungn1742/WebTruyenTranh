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
     <link rel="stylesheet"  href="${pageContext.servletContext.contextPath}/story/style.css">	
    
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
                </a>    </div>
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
                                <li class="breadcrumb-item active">Thêm</li>
                            </ol>
                        </div>
                    </div>
                </div><!-- /.container-fluid -->
            </section>
			<div class="card" style="margin-left:30px;">
				    <form:form modelAttribute="chapter" action="editChaper.html">
				          <form:input path="chap.id" id="edit-author-id" type="hidden" />
					            <c:forEach var="iterator" items="${chapter.getImages()}" varStatus="status">
					                	<div class=" rounded rounded-3 border border-secondary" style="margin-bottom: 10px;" >
	                                           	<a onclick="trash(this)"><i class="fa fa-trash fa-3x" aria-hidden="true"></i></a>
	                                    <label for="${status.index}"  >
                                            <i class="fa fa-upload fa-3x"  aria-hidden="true"></i>
                                        </label>
	                                  		<input style="display:none;" type="file" onchange="changeInput(this)"  id="${status.index}"  accept="image/*"/>
                                            <img src="data:image/jpg;base64,${iterator}" class="rounded rounded-3 border border-primary"  width="200" height="300"  id="image-show-${status.index}">
                                            <form:input path="images[${status.index}]" type="hidden" value="${iterator}" /> 
	                                  	</div>
	                                   
					            </c:forEach>
					           <div id="box-insert">
                                    <%-- <div class="image-upload" >
                                        <img  src="#" width="200" height="300"  id="image-show-${length}">
                                        
                                        <label for="${length}" id="icon-input-${length}"  class="image2">
                                            <i class="fa fa-upload" style="font-size:48px;margin-left: 40%;margin-top: 40%;" aria-hidden="true"></i>
                                        </label>
                                        
                                        <div class="image2" style="display:none;" id="icon-input-times-${length}">
                                        	<a href="#" onclick="remove(this)" style="float:right;color:black;" ><i class="fa fa-times fa-2x" aria-hidden="true"></i></a>
                                        </div>
 
                                        <input  class="image2"  type="file"  onchange="changeInput(this)"  id="${length}"  accept="image/*"/>
                                         
                                        <form:input type="hidden" path="images[${length}]" />
                                    </div>  --%>
                                   <div class="rounded rounded-3 border border-secondary" style="margin-bottom: 10px;">
                                      	<a onclick="trash(this)"><i class="fa fa-trash fa-3x" aria-hidden="true"></i></a>
                                      	 <label for="${length}"  >
                                            <i class="fa fa-upload fa-3x"  aria-hidden="true"></i>
                                        </label>
								          	<input style="display:none;"  type="file" onchange="changeInput(this)"  id="${length}"  accept="image/*"/>
							                <img  src="#" width="200" height="300" class="rounded rounded-3 border border-primary" id="image-show-${length}">
							              	<form:input type="hidden" path="images[${length}]" />
							  			</div>
                               </div>
				      			<div class="row" id="form-footer" style="margin-top: 2%; margin-bottom:2%;">
			                        <button type="submit" class="btn btn-primary mb-3" style="margin-left:30%;width: 20%;font-size: medium;">Cập nhật</button>
			                     </div>
				    </form:form>
				          
			</div>
       
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

        var count = ${length + 1};

        function changeInput(id) {
            var str = `  <div class="rounded rounded-3 border border-secondary" style="margin-bottom: 10px;">
               				<a onclick="trash(this)"><i class="fa fa-trash fa-3x" aria-hidden="true"></i></a>
			               	<label for="`+count+`"  >
			                	<i class="fa fa-upload fa-3x"  aria-hidden="true"></i>
			            	</label>
				          	<input style="display:none"  type="file" onchange="changeInput(this)"  id="`+count+`"  accept="image/*"/>
			                <img  src="#" width="200" height="300" class="rounded rounded-3 border border-primary" id="image-show-`+count+`">
			              	<input type="hidden" id="images`+count+`" name="images[`+count+`]" />
			  			</div>
			  		`;
            
            if (id.files && id.files[0]) {
                var reader = new FileReader();
                
                reader.onload = function (e) {
                    $('#image-show-' + id.id).attr('src', e.target.result);
                    toDataURL(e.target.result, function (dataUrl) {
                        $("#images" + id.id).val(dataUrl.substr(23));
                    /*     $("#image-show-" + id.id).attr("style","display:block");
                        $("#icon-input-"+id.id).attr("style","display:none");
                        $("#icon-input-times-"+id.id).attr("style","width:100%;display:block;"); */
                    });
                   
                    if ((count - 1) == parseInt(id.id)) {
                    	
                        $("#box-insert").append(str);
                        
                        count++;
                    }
                }
                reader.readAsDataURL(id.files[0]);
            }
        }

        function trash(id){
            var node = id.parentNode;
            $(node.getElementsByTagName("img")).attr("src",'#');
            $(node.getElementsByTagName("input")[1]).val("");
        }

    </script> 
</body>

</html>