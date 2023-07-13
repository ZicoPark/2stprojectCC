<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>AdminLTE 3 | Dashboard</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Tempusdominus Bootstrap 4 -->
  <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- JQVMap -->
  <link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="dist/css/adminlte.min.css">
  <!-- overlayScrollbars -->
  <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
  <!-- Daterange picker -->
  <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
  <!-- summernote -->
  <link rel="stylesheet" href="plugins/summernote/summernote-bs4.min.css">
</head>
<body class="hold-transition sidebar-mini">
<jsp:include page = "index.jsp"></jsp:include>

<div class="wrapper">

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <!-- /.content-header -->
<section class="content">
 <div class="row">
<div class="col-md-3">

<div class="card card-primary card-outline" style="border-top : 3px solid #20c997!important">
<div class="card-body box-profile">
<div style="display: flex; align-items: center; justify-content: center; height: 100%;">
 <c:choose>
   <c:when test="${not empty member.photoName}">
     <img src="photoView.do?path=${member.photoName}" class="profile-user-img img-fluid img-circle" id="preview" style= "height: 130px; width: 130px;">
   </c:when>
   <c:otherwise>
     <img class="profile-user-img img-fluid img-circle" src="img/cc.png" id="preview" style= "height: 130px; width: 130px;">
   </c:otherwise>
 </c:choose>
</div>
<div class="text-center">
</div>
<h3 class="profile-username text-center">${main.m_name }</h3>
<p class="text-muted text-center">${main.d_name} /  ${main.jl_name}</p>
<ul class="list-group list-group-unbordered mb-3">
<li class="list-group-item">
    <b>출근시간</b>
<a class="float-right" style=" FONT-SIZE: 13PX; COLOR: GREEN;">
    ${timeList.time_go}
</a>

</li>
<li class="list-group-item">
    <b>퇴근시간</b>
    <a class="float-right" style=" FONT-SIZE: 13PX; COLOR: RED;">
        ${timeList.time_end}
    </a>
</li>



<li class="list-group-item">
<h4 id="clock"></h4>
</li>
</ul>
<button type="button" class="btn btn-success btn-sm" onclick="location.href='mtimeGo.do'">출근</button>&nbsp;&nbsp;
<button type="button" class="btn btn-danger btn-sm" onclick="location.href='mtimeEnd.do'">퇴근</button>&nbsp;&nbsp;
</div>

</div>


<div class="card card-primary">
<div class="card-header" style=" background-color: #20c997!important;">
<h3 class="card-title">DashBoard</h3>
</div>

<div class="card-body">
<strong><i class="far fa-file-alt mr-1"></i><a href="/msReceiveList.go"> 받은 쪽지함 &nbsp ${ms}</a></strong>

<hr>
<strong><i class="fas fa-pencil-alt mr-1"></i><a href="#"> 결재 대기함 &nbsp ${doc}</a></strong>

<hr>
<strong><i class="fas fa-book mr-1"></i><a href="projects.go"> 진행중인 프로젝트 &nbsp ${pro}</a></strong>

<hr>

</div>

</div>

</div>

<div class="col-md-9">
  <div class="col-lg-6">
    <div class="card">
      <div class="card-header border-0">
        <h3 class="card-title">공지사항</h3>
        <div class="card-tools">
          <a href="/noticeBoard.go" class="btn btn-tool btn-sm">
            더보기
          </a>
        </div>
      </div>
      <div class="card-body table-responsive p-0">
        <table class="table table-striped table-valign-middle">
          <thead>
            <tr>
              <th>제목</th>
              <th>작성자</th>
              <th>등록일</th>
            </tr>
          </thead>
          <tbody>
	        <c:forEach items="${Nolist}" var="i">
	          <tr>
	            <td>${i.subject}</td>
	            <td>${i.name}</td>
	            <td>${i.create_at}</td>
	            <td><input type ="hidden" id = "${i.id}" /></td>
	          </tr>
	        </c:forEach>
          </tbody>
        </table>
      </div>
    </div>
  <div class="card">
<div class="card-header ui-sortable-handle" style="cursor: move;">
<h3 class="card-title">
<i class="ion ion-clipboard mr-1"></i>
To Do List
</h3>
<div class="card-tools">
<ul class="pagination pagination-sm">
<li class="page-item"><a href="#" class="page-link">«</a></li>
<li class="page-item"><a href="#" class="page-link">1</a></li>
<li class="page-item"><a href="#" class="page-link">2</a></li>
<li class="page-item"><a href="#" class="page-link">3</a></li>
<li class="page-item"><a href="#" class="page-link">»</a></li>
</ul>
</div>
</div>

<div class="card-body">
<ul class="todo-list ui-sortable" data-widget="todo-list">

<li class="" style="">

<span class="handle ui-sortable-handle">
<i class="fas fa-ellipsis-v"></i>
<i class="fas fa-ellipsis-v"></i>
</span>

<div class="icheck-primary d-inline ml-2">
<input type="checkbox" value="" name="todo1" id="todoCheck1">
<label for="todoCheck1"></label>
</div>

<span class="text">Design a nice theme</span>

<small class="badge badge-danger"><i class="far fa-clock"></i> 2 mins</small>

<div class="tools">
<i class="fas fa-edit"></i>
<i class="fas fa-trash-o"></i>
</div>
</li><li class="done">
<span class="handle ui-sortable-handle">
<i class="fas fa-ellipsis-v"></i>
<i class="fas fa-ellipsis-v"></i>
</span>
<div class="icheck-primary d-inline ml-2">
<input type="checkbox" value="" name="todo2" id="todoCheck2" checked="">
<label for="todoCheck2"></label>
</div>
<span class="text">Make the theme responsive</span>
<small class="badge badge-info"><i class="far fa-clock"></i> 4 hours</small>
<div class="tools">
<i class="fas fa-edit"></i>
<i class="fas fa-trash-o"></i>
</div>
</li>
<li>
<span class="handle ui-sortable-handle">
<i class="fas fa-ellipsis-v"></i>
<i class="fas fa-ellipsis-v"></i>
</span>
<div class="icheck-primary d-inline ml-2">
<input type="checkbox" value="" name="todo3" id="todoCheck3">
<label for="todoCheck3"></label>
</div>
<span class="text">Let theme shine like a star</span>
<small class="badge badge-warning"><i class="far fa-clock"></i> 1 day</small>
<div class="tools">
<i class="fas fa-edit"></i>
<i class="fas fa-trash-o"></i>
</div>
</li>
<li>
<span class="handle ui-sortable-handle">
<i class="fas fa-ellipsis-v"></i>
<i class="fas fa-ellipsis-v"></i>
</span>
<div class="icheck-primary d-inline ml-2">
<input type="checkbox" value="" name="todo4" id="todoCheck4">
<label for="todoCheck4"></label>
</div>
<span class="text">Let theme shine like a star</span>
<small class="badge badge-success"><i class="far fa-clock"></i> 3 days</small>
<div class="tools">
<i class="fas fa-edit"></i>
<i class="fas fa-trash-o"></i>
</div>
</li>
<li>
<span class="handle ui-sortable-handle">
<i class="fas fa-ellipsis-v"></i>
<i class="fas fa-ellipsis-v"></i>
</span>
<div class="icheck-primary d-inline ml-2">
<input type="checkbox" value="" name="todo5" id="todoCheck5">
<label for="todoCheck5"></label>
</div>
<span class="text">Check your messages and notifications</span>
<small class="badge badge-primary"><i class="far fa-clock"></i> 1 week</small>
<div class="tools">
<i class="fas fa-edit"></i>
<i class="fas fa-trash-o"></i>
</div>
</li>
<li>
<span class="handle ui-sortable-handle">
<i class="fas fa-ellipsis-v"></i>
<i class="fas fa-ellipsis-v"></i>
</span>
<div class="icheck-primary d-inline ml-2">
<input type="checkbox" value="" name="todo6" id="todoCheck6">
<label for="todoCheck6"></label>
</div>
<span class="text">Let theme shine like a star</span>
<small class="badge badge-secondary"><i class="far fa-clock"></i> 1 month</small>
<div class="tools">
<i class="fas fa-edit"></i>
<i class="fas fa-trash-o"></i>
 </div>
</li>
</ul>
</div>

<div class="card-footer clearfix">
<button type="button" class="btn btn-primary float-right"><i class="fas fa-plus"></i> Add item</button>
</div>
</div>
  
  
  
  </div>
</div>


</div>
 </section>         
           
           
           
           
  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->
</div>
</div>

<!-- jQuery -->
<script src="plugins/jquery/jquery.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button)
</script>
<!-- Bootstrap 4 -->
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- ChartJS -->
<script src="plugins/chart.js/Chart.min.js"></script>
<!-- Sparkline -->
<script src="plugins/sparklines/sparkline.js"></script>
<!-- JQVMap -->
<script src="plugins/jqvmap/jquery.vmap.min.js"></script>
<script src="plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
<!-- jQuery Knob Chart -->
<script src="plugins/jquery-knob/jquery.knob.min.js"></script>
<!-- daterangepicker -->
<script src="plugins/moment/moment.min.js"></script>
<script src="plugins/daterangepicker/daterangepicker.js"></script>
<!-- Tempusdominus Bootstrap 4 -->
<script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
<!-- Summernote -->
<script src="plugins/summernote/summernote-bs4.min.js"></script>
<!-- overlayScrollbars -->
<script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/adminlte.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="dist/js/demo.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="dist/js/pages/dashboard.js"></script>
</body>
<script>
var msg = "${msg}";
if(msg != ""){
	alert(msg);
}	


setInterval(function(){
    var timer = new Date();
    var h = timer.getHours();
    var m = timer.getMinutes();
    var s = timer.getSeconds();
    document.getElementById('clock').innerHTML = h + ":" + m + ":" + s;
},1000);
</script>


</html>
