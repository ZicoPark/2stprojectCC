<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body class="hold-transition sidebar-mini">
<jsp:include page="index.jsp"></jsp:include>
<div class="wrapper">

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Inbox</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <div style="text-align: center;">
      <i class="fas fa-envelope"></i>
      <h3>쪽지가 전송되었습니다 !</h3>
    </div>

    <div style="display: flex; justify-content: space-between;">
      <a href="#" class="btn btn-block bg-gradient-primary btn-lg"><b>보낸 쪽지함</b></a>
      <a href="#" class="btn btn-block bg-gradient-primary btn-lg"><b>추가 쪽지 작성</b></a>
    </div>

    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <div class="float-right d-none d-sm-block">
      <b>Version</b> 3.2.0
    </div>
    <strong>
      Copyright &copy; 2014-2021
      <a href="https://adminlte.io">AdminLTE.io</a>.
    </strong> All rights reserved.
  </footer>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->
</div>

</body>
</html>
