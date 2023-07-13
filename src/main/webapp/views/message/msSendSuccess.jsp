<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>AdminLTE 3 | Projects</title>


 <!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<!-- Tempusdominus Bootstrap 4 -->
<link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
<!-- overlayScrollbars-->
<link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
<!-- Ionicons -->
<link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">



<!--  Google Font: Source Sans Pro -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome-->
<link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
<!-- Theme style-->
<link rel="stylesheet" href="dist/css/adminlte.min.css">

</head>

<body class="hold-transition sidebar-mini">

<!-- Site wrapper -->
<div class="wrapper">
<jsp:include page = "../index.jsp"></jsp:include>
    <section class="content">
      <div class="row">
	<!-- row 밑에  -->
	<div class="col-md-3">
	<a href="/msWrite.go" class="btn btn-primary btn-block mb-3">쪽지 작성</a>
	<div class="card">
	<div class="card-header">
	<h3 class="card-title">보관함</h3>
	<div class="card-tools">
	<button type="button" class="btn btn-tool" data-card-widget="collapse">
	<i class="fas fa-minus"></i>
	</button>
	</div>
	</div>
	<div class="card-body p-0">
	<ul class="nav nav-pills flex-column">
	<li class="nav-item active">
	<a href="#" class="nav-link">
	<i class="far fa-envelope"></i> 전체 쪽지
	<span class="badge bg-primary float-right">12</span>
	</a>
	</li>
	<li class="nav-item">
	<a href="/msReceiveList.go" class="nav-link">
	<i class="fas fa-inbox"></i> 받은 쪽지
	</a>
	</li>
	<li class="nav-item">
	<a href="/msSendList.go" class="nav-link">
	<i class="far fa-file-alt"></i> 보낸 쪽지
	</a>
	</li>
	<li class="nav-item">
	<a href="/msRemoveList.go" class="nav-link">
	<i class="far fa-trash-alt"></i> 휴지통
	</a>
	</li>
	</ul>
	</div>
	</div>
	</div> 
	<!-- col-md-9 위에  -->  
	
	
    <div style="text-align: center;">
      <i class="fas fa-envelope"></i>
      <h3>쪽지가 전송되었습니다 !</h3>
    </div>

    <div style="display: flex; justify-content: space-between;">
      <a href="#" class="btn btn-block bg-gradient-primary btn-lg"><b>보낸 쪽지함</b></a>
      <a href="#" class="btn btn-block bg-gradient-primary btn-lg"><b>추가 쪽지 작성</b></a>
  
  </div>
</div>
    </section>

<!--   <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    Control sidebar content goes here
  </aside>
  /.control-sidebar
</div>

 -->
<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>





</body>
</html>
