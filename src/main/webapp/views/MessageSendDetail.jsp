<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>보낸쪽지함</title>
<link rel="icon" href="/img/CC_favicon.png">
  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
</head>
<style>
.btn-primary {
    color: #fff;
    background-color: #20c997;
    border-color: #20c997;
    box-shadow: none;
}
  
.card-primary.card-outline {
    border-top: 3px solid #20c997;
}  
</style>
<body class="hold-transition sidebar-mini">
<jsp:include page = "index.jsp"></jsp:include>
<div class="wrapper">
  <!-- Navbar -->
  

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>보낸쪽지함</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">보낸쪽지함</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
	<!-- row 밑에  -->
	<div class="col-md-3">
	<a href="/msWrite.go" class="btn btn-primary btn-block mb-3">쪽지 작성</a>
	<div class="card">
	<div class="card-header">
	<h3 class="card-title">쪽지</h3>
	<div class="card-tools">
	<button type="button" class="btn btn-tool" data-card-widget="collapse">
	<i class="fas fa-minus"></i>
	</button>
	</div>
	</div>
	<div class="card-body p-0">
	<ul class="nav nav-pills flex-column">
	<li class="nav-item active">

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
        <div class="col-md-9">
          <div class="card card-primary card-outline">
            <div class="card-header">
              

              <div class="card-tools">
                <a href="#" class="btn btn-tool" title="Previous"><i class="fas fa-chevron-left"></i></a>
                <a href="#" class="btn btn-tool" title="Next"><i class="fas fa-chevron-right"></i></a>
              </div>
            </div>
            <!-- /.card-header -->
            <div class="card-body p-0">
              <div class="mailbox-read-info">
              	<h5>${detailms.title}</h5>
                <div>
                  <h6>From: ${detailms.name} < ${detailms.user_id} > 
                    <span class="badge badge-success">${detailms.dept_name}</span>
                 
                  	<span class="mailbox-read-time float-right">${detailms.send_at}</span>
                   </h6>
                 </div>
                </div>

              </div>
              <!-- /.mailbox-controls -->
              <div class="mailbox-read-message" style="height: 310px;">
                <p>${detailms.content}</p>
              </div>
              <!-- /.mailbox-read-message -->
				<c:if test="${detailFile.size() > 0 }">
					<c:forEach items="${detailFile}" var="i">
                  <div class="mailbox-attachment-info">
                    <a class="mailbox-attachment-name"><i class="fas fa-paperclip"></i> &nbsp ${i.ori_file_name}</a>
					&nbsp &nbsp
                    <a href="msdownload.do?path=${i.id}"><i clawss="fas fa-cloud-download-alt"></i></a>
                    
                  </div>

            	</c:forEach>
			</c:if>


 

            <!-- /.card-footer -->
            <div class="card-footer">
              <div class="float-right">
              <button type="button" class="btn btn-default" onclick="location.href='msDelete.do?id=${detailms.id}'"><i class="far fa-trash-alt"></i></button>
                <button type="button" onclick="location.href='/msSendList.go'" class="btn btn-default"> 목록</button>
 			</div>
            </div>
            </div>
            <!-- /.card-body -->
    
            <!-- /.card-footer -->
          </div>
          <!-- /.card -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
    </section>
      </div><!-- /.container-fluid -->
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <div class="float-right d-none d-sm-block">
      <b>Version</b> 3.2.0
    </div>
    <strong>Copyright &copy; 2014-2021 <a href="https://adminlte.io">AdminLTE.io</a>.</strong> All rights reserved.
  </footer>
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

<script type="text/javascript" src="../../dist/js/jquery.twbsPagination.min.js"></script>

<script>



</script>

</body>
</html>