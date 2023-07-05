<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Creator Company</title>

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
            <h1>개인 업무 관리</h1>
        </div>
      </div>
    </section>

<form action="personalWrite.do" method="post">
    <section class="content">
    
          <div class="card card-primary">
            <div class="card-header">
              <h3 class="card-title">개인 업무 작성</h3>

            </div>
            <div class="card-body">
              
              <div class="form-group">
				 <label for="inputName">업무 사항</label>
                <input type="text" class="form-control" name = "title">
              </div>
              
              <div class="form-group">
                <label for="inputPriod">시작일</label>
                <input type="date" class="form-control" name="start_at" placeholder="시작일">
              </div>

              <div class="form-group">
                <label for="inputDeadLinePriod">마감일</label>
                <input type="date" class="form-control" name="end_at" placeholder="마감일">
              </div>
              
            </div>
            <!-- /.card-body -->
          </div>
          <!-- /.card -->

          <a href="/personal.go" class="btn btn-secondary">돌아가기</a>
          <input type="submit" value="작성하기" class="btn btn-success float-right">

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
</script>
</html>
   