<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>개인 업무 수정</title>
<link rel="icon" href="/img/CC_favicon.png">
  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
</head>
<body class="hold-transition sidebar-mini">
<jsp:include page = "index.jsp"></jsp:include>
<!-- Site wrapper -->
<div class="wrapper">
  


  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
          <div class="col-sm-6">
            <h1>개인 업무 수정</h1>
        </div>
      </div>
    </section>

<form action="personalUpdate.do" method="post">

    <section class="content">
    
          <div class="card card-primary" style="margin: 40px;">
            <div class="card-header">
              <h3 class="card-title">개인 업무 작성</h3>
			<input type="hidden" type="text" name="id" value="${personal.id}" />
            </div>
            <div class="card-body">
              <div class="form-group">
				 <label for="inputName">업무 사항</label></br>
                <h4>${personal.title}</h4> 
              </div>
              
              <div class="form-group">
                <label for="inputPriod">시작일</label>
                <input type="date" class="form-control" name="start_at" placeholder="시작일" >
              </div>

              <div class="form-group">
                <label for="inputDeadLinePriod">마감일</label>
                <input type="date" class="form-control" name="end_at" placeholder="마감일">
              </div>
              
            </div>
            <!-- /.card-body -->
          </div>
          <!-- /.card -->
          <input type="submit"  style="margin-right: 40px;" onclick="return confirm('수정하시겠습니까?');" value="수정하기" class="btn btn-success float-right">

</section>
    </form>
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
  // 이전에 입력한 시작일과 마감일 값
  var startAt = "${personal.start_at}"; // personal.start_at은 이전에 입력한 시작일 값
  var endAt = "${personal.end_at}"; // personal.end_at은 이전에 입력한 마감일 값

  // 시작일과 마감일 필드
  var startAtField = document.querySelector('input[name="start_at"]');
  var endAtField = document.querySelector('input[name="end_at"]');

  // 시작일과 마감일 필드의 값을 이전 값으로 초기화
  startAtField.value = startAt;
  endAtField.value = endAt;
</script>
</html>
   