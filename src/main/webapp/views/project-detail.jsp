<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>CreatorCompany</title>

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
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>프로젝트 상세</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Project Detail</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">

      <!-- Default box -->
      <div class="card">
        <div class="card-header">
          <h3 class="card-title">Projects Detail</h3>

          <div class="card-tools">
           <a href="projectInsert.go?id=${project_id}" class="btn btn-sm btn-primary">추가</a>
           <a href="projectDel.do?id=${project_id}" class="btn btn-danger btn-sm">철회</a>
                          				
            <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
              <i class="fas fa-minus"></i>
            </button>
            <button type="button" class="btn btn-tool" data-card-widget="remove" title="Remove">
              <i class="fas fa-times"></i>
            </button>

          </div>
        </div>

        <div class="card-body">
          <div id="projectDetailContainer"></div>
        </div>
        <!-- /.card-body -->
      </div>
      <!-- /.card -->

    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->


  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->
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
<script>
$(document).ready(function() {
	console.log("함수 실행");


  var projectId = "${project_id}";
  
  $.ajax({
    url: "projectDetail.ajax?id=" + projectId, // 서버에서 데이터를 가져올 URL
    method: "GET",
    dataType: "json",
    success: function(data) {
      var container = $("#projectDetailContainer");

      $.each(data.detailList, function(index, detail) {
        var html = '<div class="row">';
        html += '<div class="col-12 col-md-12 col-lg-8 order-2 order-md-1">';
        html += '<div class="row">';
        html += '<div class="col-12">';
        html += '<span style="border: 1px solid green; border-radius: 5px; padding: 3px;">' + detail.step + '</span>';
        html += '<span style="border: 1px solid red; border-radius: 5px; padding: 3px;">' + detail.status + '</span>';
        html += '<div class="post">';
        html += '<div class="user-block">';
        html += '<img class="img-circle img-bordered-sm" src="../../dist/img/user1-128x128.jpg" alt="user image">';
        html += '<span class="username">';
        html += '<a href="#">' + detail.user_id + '</a>';
        html += '</span>';
        html += '<span class="description">' + detail.reate_at + '</span>';
        html += '</div>';
        html += '<p>' + detail.content + '</p>';
        html += '<p><a href="/upload/' + detail.new_file_name + '">' + detail.new_file_name + '</a></p>';
        html += '</div>';

        container.prepend(html);
      });
    },
    error: function(xhr, status, error) {
      console.log(error);
    }
  });
});

</script>
</body>
</html>
