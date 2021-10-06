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
	 <link rel="stylesheet"
    href="${pageContext.servletContext.contextPath}/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
  <link rel="stylesheet"
    href="${pageContext.servletContext.contextPath}/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
  <link rel="stylesheet"
    href="${pageContext.servletContext.contextPath}/plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
<link rel="stylesheet"
    href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/plugins/fontawesome-free/css/all.min.css">
  
  
  <!-- DataTables -->
  <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
  
  
</head>

<body class="hold-transition sidebar-mini">
    <div class="wrapper">
        <nav class="main-header navbar navbar-expand navbar-white navbar-light">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
                </li>
                <li class="nav-item d-none d-sm-inline-block">
                    <a href="${pageContext.servletContext.contextPath}/index.html" class="nav-link">Home</a>
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
                </a>  </div>
            <div class="sidebar">
           
                <nav class="mt-2">
                    <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu"   data-accordion="false">
               
                        <li class="nav-item">
                             <a href="${pageContext.servletContext.contextPath}/admin/create.html" class="nav-link">
                               <i class="far fa-circle nav-icon"></i>
                                   <p>Thêm Truyện</p>
                                </a>
                                </li>
                                <li class="nav-item">
                                    <a href="${pageContext.servletContext.contextPath}/admin/data.html" class="nav-link active">
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
                        <div class="col-sm-6">
                            <h1>Tác Giả & Thể Loại & Trạng Thái</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="#">Trang Chủ</a></li>
                                <li class="breadcrumb-item active">Tác Giả & Thể Loại & Trạng Thái</li>
                            </ol>
                        </div>
                    </div>
                </div><!-- /.container-fluid -->
            </section>

            <section class="content">
                <div class="container-fluid">
                   <div class="row">
                    <!-- Author -->
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="card-title" style="padding-right: 20px;">Tác Giả</h3>
                                   <a href="#addAuthor" class="btn btn-sm btn-primary"  data-toggle="modal"><i class="fa fa-plus" aria-hidden="true"> </i> Thêm Tác Giả</a>     
                                </div>
                                <div class="card-body p-0">
                                    <table id="tableAuthor" class="table table-sm">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Tên</th>
                                                <th>Chỉnh sửa</th>
                                                <th>Xóa</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="iterator" items="${Authors}">
                                                <tr>
                                                    <td>${iterator.getId()}</td>
                                                    <td>${iterator.getName()}</td>
                                                    <td>
                                                        <a href="#editAuthor" class="btn btn-info btn-sm" data-toggle="modal" onclick="editAuthor(this)">
                                                        	<i class="fas fa-pencil-alt"> </i>
                                                        </a>
                                                    </td>
                                                    <td>
                                                        <a href="#delAuthor"  class="btn btn-danger btn-sm" data-toggle="modal" onclick="delAuthor(this)"> 
                                                         	<i class="fas fa-trash"></i>
							                              </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table> 
                                </div>
                            </div>
                        </div>
                         <!--end Author -->
                        <!-- /.col -->
                        
                         <!-- category -->
                        <div class="col-md-6" >
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="card-title" style="padding-right: 20px;">Thể Loại</h3>
                                    <a href="#addCategory" class="btn btn-sm btn-primary"   data-toggle="modal"><i class="fa fa-plus" aria-hidden="true"> </i> Thêm Thể Loại</a>     
                                    
                                </div>
                                <div class="card-body p-0">
                                  <table id="tableCategory" class="table table-sm">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Thể Loại</th>
                                                <th>Chỉnh Sửa</th>
                                                <th>Xóa</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                               				  <c:forEach var="iterator" items="${Categories}">
                                                <tr>
                                                    <td>${iterator.getId()}</td>
                                                    <td >${iterator.getName()}</td>
                                                    <td>
                                                        <a href="#editCategory" class="btn btn-info btn-sm" data-toggle="modal" onclick="editCategory(this)">
                                                        	<i class="fas fa-pencil-alt"> </i>
                                                        </a>
                                                    </td>
                                                    <td>
                                                        <a href="#delCategory" class="btn btn-danger btn-sm"  data-toggle="modal" onclick="delCategory(this)">
                                                        	<i class="fas fa-trash"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>          
                                        </tbody>
                                    </table> 
                                </div>
                            </div>
                        </div>
                           <!-- end category -->
                     </div>
                     
                     <div class="row">
	                     <div class="col">
	                            <div class="card">
	                                <div class="card-header">
	                                    <h3 class="card-title" style="padding-right: 20px;">Truyện</h3>
	                                </div>
	                                <div class="card-body p-0">
	                                    <table id="tableStory" class="table table-sm  ">
	                                        <thead>
	                                            <tr>
	                                                <th>#</th>
	                                                <th>Hình Ảnh</th>
	                                                <th>Tên</th>
	                                                <th>Tác Giả</th>
	                                                <th>Thể Loại</th>
	                                                <th>Nội Dung</th>
	                                                <th>Các Chương</th>
	                                                <th>Trạng Thái</th>
	                                                <th>Thêm Chương</th>
	                                                <th>Chỉnh sửa</th>
	                                              	<th>Xóa</th>
	                                            </tr>
	                                        </thead>
	                                        <tbody>
	                                            <c:forEach var="iterator" items="${Stories}">
	                                                <tr>
	                                                    <td>${iterator.getId()}</td>
	                                                    <td><a href="./view.html?id=${iterator.getId()}" class="edit" ><img width="100" class="rounded mx-auto d-block"  src="data:image/jpg;base64,${iterator.getImage()}"/></a> </td>
	                                                    <td width="200">${iterator.getName()}</td>
	                                                    <td>${iterator.getNameAuthor()}</td>
	                                                    <td>${iterator.listCategory("<br>")}</td>
	                                                 	<td width="200" >${iterator.getDescription256()}</td>
	                                                 	<td>${iterator.getlistChaperstr()}</td>
	                                                    <td>${iterator.getStatus()}</td>
	                                                     <td>
	                                                        <a href="./newChap.html?id=${iterator.getId()}" class="btn btn-primary btn-sm" ><i class="fas fa-plus"> </i></a>
	                                                    </td>
	                                                    <td>
	                                                        <a href="./edit-story.html?id=${iterator.getId()}" class="btn btn-info btn-sm" ><i class="fas fa-pencil-alt" aria-hidden="true"></i></a>
	                                                    </td>
	                                                    <td>
	                                                       <a href="#delStory" class="btn btn-danger btn-sm"  data-toggle="modal" onclick="delStory(this)">
                                                        		<i class="fas fa-trash"></i>
                                                        	</a>
                                                        </td>
	                                                </tr>
	                                            </c:forEach>
	                                        </tbody>
	                                    </table> 
	                                </div>
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

 
  <!-- DataTables  & Plugins -->
  <script src="${pageContext.servletContext.contextPath}/plugins/datatables/jquery.dataTables.min.js"></script>
  <script   src="${pageContext.servletContext.contextPath}/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
  <script  src="${pageContext.servletContext.contextPath}/plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
  <script   src="${pageContext.servletContext.contextPath}/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
  <script  src="${pageContext.servletContext.contextPath}/plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
  <script src="${pageContext.servletContext.contextPath}/plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
  <script src="${pageContext.servletContext.contextPath}/plugins/jszip/jszip.min.js"></script>
  <script src="${pageContext.servletContext.contextPath}/plugins/pdfmake/pdfmake.min.js"></script>
  <script src="${pageContext.servletContext.contextPath}/plugins/pdfmake/vfs_fonts.js"></script>
  <script src="${pageContext.servletContext.contextPath}/plugins/datatables-buttons/js/buttons.html5.min.js"></script>
  <script src="${pageContext.servletContext.contextPath}/plugins/datatables-buttons/js/buttons.print.min.js"></script>
  <script src="${pageContext.servletContext.contextPath}/plugins/datatables-buttons/js/buttons.colVis.min.js"></script>
  <!-- AdminLTE App -->
 
  <!-- AdminLTE for demo purposes -->

	
<!-- Add author -->
 <div class="modal fade" id="addAuthor" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Thêm tác giả</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
          
                  <form:form modelAttribute="author" action="data-addAuthor.html">
                        <form:input path="id" type="hidden" />
                        <div class="form-group">
                            <label for="author-name" class="col-form-label">Tên tác giả</label>
                            <form:input path="name" type="text" class="form-control" id="author-name" placeholder="Tên tác giả" />
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
<!-- ENd add author -->

<!-- Add Category -->
<div class="modal fade" id="addCategory" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Thêm thể loại</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
          
                  <form:form modelAttribute="category" action="data-addCategory.html">
                        <form:input path="id" type="hidden" />
                        <div class="form-group">
                            <label for="category-name" class="col-form-label">Thể loại</label>
                            <form:input path="name" type="text" class="form-control" id="category-name" placeholder="Tên thể loại" />
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
<!-- End Add Category -->

<!-- Edit Category -->
<div class="modal fade" id="editCategory" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Chỉnh sửa Thể loại</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
          
                  <form:form modelAttribute="category" action="data-editCategory.html">
                        
                        <div class="form-group">
                            <label id="edit-category-id-label" class="col-form-label">#</label>
                            <form:input path="id" id="edit-category-id" type="hidden" />
                        </div>
                        <div class="form-group">
                            <label for="edit-category-name" class="col-form-label">Thể loại</label>
                            <form:input path="name" type="text" class="form-control" id="edit-category-name" placeholder="Thể loại" />
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
<!-- End Edit Category -->

<!-- delete story -->
<div class="modal fade" id="delStory" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Bạn Có Muốn Xóa Truyện này không?</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
          
                  <form:form modelAttribute="story" action="delete-story.html">
                        
                        <div class="form-group">
                           <label id="del-story-name-label" class="col-form-label">Tên truyện</label>
                            <form:input path="id" id="del-story-id" type="hidden" />
                        </div>
                        <div class="form-group">
                            
                            <img style="max-width:450px;" id="del-story-img" />
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
<!-- end delete story -->

<!-- Delete Category -->
<div class="modal fade" id="delCategory" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Bạn Có Muốn Xóa Thể loại này không?</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
          
                  <form:form modelAttribute="category" action="data-delCategory.html">
                        
                        <div class="form-group">
                            <label id="del-category-id-label" class="col-form-label">#</label>
                            <form:input path="id" id="del-category-id" type="hidden" />
                        </div>
                        <div class="form-group">
                            <label id="del-category-name-label" class="col-form-label">Tác giả</label>
                            <form:input path="name" type="hidden" class="form-control" id="del-category-name" />
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
<!-- End Delete Category -->

<!-- Edit author -->
 <div class="modal fade" id="editAuthor" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Chỉnh Sửa Thông Tin Tác Giả</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
          
                  <form:form modelAttribute="author" action="data-editAuthor.html">
                        
                        <div class="form-group">
                            <label id="edit-author-id-label" class="col-form-label">#</label>
                            <form:input path="id" id="edit-author-id" type="hidden" />
                        </div>
                        <div class="form-group">
                            <label for="edit-author-name" class="col-form-label">Tên tác giả</label>
                            <form:input path="name" type="text" class="form-control" id="edit-author-name" placeholder="Tên tác giả" />
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
<!-- ENd edit author -->


<!-- del author -->
 <div class="modal fade" id="delAuthor" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Bạn Có Muốn Xóa Tác Giả</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
          
                  <form:form modelAttribute="author" action="data-delAuthor.html">
                        
                        <div class="form-group">
                            <label id="del-author-id-label" class="col-form-label">#</label>
                            <form:input path="id" id="del-author-id" type="hidden" />
                        </div>
                        <div class="form-group">
                            <label id="del-author-name-label" class="col-form-label">Tác giả</label>
                            <form:input path="name" type="hidden" class="form-control" id="del-author-name" />
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
<!-- ENd del author -->

  <script>
  
  		function delStory(id){
  			var root = id.parentNode.parentNode;
  		  $("#del-story-id").val(root.getElementsByTagName("td")[0].textContent);
          $("#del-story-name-label").text(root.getElementsByTagName("td")[2].textContent);
          $("#del-story-img").attr("src", root.getElementsByTagName("img")[0].src);
  		}
  
        // edit author
        function editAuthor(id) {
            var root = id.parentNode.parentNode;
            $("#edit-author-id-label").text("Tác Giả #" + root.getElementsByTagName("td")[0].textContent);
            $("#edit-author-id").val(root.getElementsByTagName("td")[0].textContent);
            $("#edit-author-name").val(root.getElementsByTagName("td")[1].textContent);
          
        }
        
        function delAuthor(id){
        	 var root = id.parentNode.parentNode;
             $("#del-author-id-label").text("Số Thứ Tự : \t" + root.getElementsByTagName("td")[0].textContent);
             $("#del-author-id").val(root.getElementsByTagName("td")[0].textContent);
             $("#del-author-name-label").text("Tên : \t"+root.getElementsByTagName("td")[1].textContent)
             $("#del-author-name").val(root.getElementsByTagName("td")[1].textContent);
           
        }
        
        function editCategory(id) {
            var root = id.parentNode.parentNode;
            $("#edit-category-id-label").text("Thể loại #" + root.getElementsByTagName("td")[0].textContent);
            $("#edit-category-id").val(root.getElementsByTagName("td")[0].textContent);
            $("#edit-category-name").val(root.getElementsByTagName("td")[1].textContent);
          
        }
        
        function delCategory(id) {
       	 	var root = id.parentNode.parentNode;
            $("#del-category-id-label").text("Số Thứ Tự : \t" + root.getElementsByTagName("td")[0].textContent);
            $("#del-category-id").val(root.getElementsByTagName("td")[0].textContent);
            $("#del-category-name-label").text("Tên : \t"+root.getElementsByTagName("td")[1].textContent)
            $("#del-category-name").val(root.getElementsByTagName("td")[1].textContent);
       }
      
    </script>
  <script>
  $(function () {
	  $("#tableStory").DataTable({
	        "responsive": true, "lengthChange": false, "autoWidth": false
	      }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');
	  $("#tableCategory").DataTable({
	        "responsive": true, "lengthChange": false, "autoWidth": false
	      }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');
	  $("#tableAuthor").DataTable({
	        "responsive": true, "lengthChange": false, "autoWidth": false
	      }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');
  });
  
  
  
</script>
</body>

</html>