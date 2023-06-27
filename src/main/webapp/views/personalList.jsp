<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>AdminLTE 3 | Projects</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
</head>
<body>
<jsp:include page = "index.jsp"></jsp:include>
<!-- Site wrapper -->
<div class="wrapper">
  <div class="content-wrapper">
    <section class="content-header">
            <h1>개인 업무 관리</h1>         
    </section>
    <!-- Main content -->
    <section class="content">
          

		<div class="card">
		<div class="card-header ui-sortable-handle">
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
		<li>
		
		
		<div class="icheck-primary d-inline ml-2">
		<input type="checkbox" value="" name="todo1" id="todoCheck1">
		<label for="todoCheck1"></label>
		</div>
		
		<span class="text">Design a nice theme</span>
		
		
		<div class="tools">
		<i class="fas fa-edit"></i>
		<i class="fas fa-trash-o"></i>
		</div>
		</li>
		<li class="done">

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
		<div class="icheck-primary d-inline ml-2">
		<input type="checkbox" value="" name="todo3" id="todoCheck3">
		<label for="todoCheck3"></label>
		</div>
		<span class="text">Let theme shine like a star</span>
		<div class="tools">
		<i class="fas fa-edit"></i>
		<i class="fas fa-trash-o"></i>
		</div>
		</li>
		<li>
		<div class="icheck-primary d-inline ml-2">
		<input type="checkbox" value="" name="todo4" id="todoCheck4">
		<label for="todoCheck4"></label>
		</div>
		<span class="text">Let theme shine like a star</span>
		<div class="tools">
		<i class="fas fa-edit"></i>
		<i class="fas fa-trash-o"></i>
		</div>
		</li>
		<li>

		<div class="icheck-primary d-inline ml-2">
		<input type="checkbox" value="" name="todo5" id="todoCheck5">
		<label for="todoCheck5"></label>
		</div>
		<span class="text">Check your messages and notifications</span>
		<div class="tools">
		<i class="fas fa-edit"></i>
		<i class="fas fa-trash-o"></i>
		</div>
		</li>
		<li>

		<div class="icheck-primary d-inline ml-2">
		<input type="checkbox" value="" name="todo6" id="todoCheck6">
		<label for="todoCheck6"></label>
		</div>
		<span class="text">Let theme shine like a star</span>
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





    </section>
  </div>
</div>
<!-- ./wrapper -->
<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>
</body>
<script>
</script>
</html>