<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>AdminLTE 3 | Read Mail</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
</head>
<body class="hold-transition sidebar-mini">
<jsp:include page = "index.jsp"></jsp:include>
<div class="wrapper">

  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Compose</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Compose</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
 
        <div class="col-md-9">
          <div class="card card-primary card-outline">
            <div class="card-header">
              <h3 class="card-title">${detailms.subject}</h3>

              <div class="card-tools">
                <a href="#" class="btn btn-tool" title="Previous"><i class="fas fa-chevron-left"></i></a>
                <a href="#" class="btn btn-tool" title="Next"><i class="fas fa-chevron-right"></i></a>
              </div>
            </div>
            <!-- /.card-header -->
            <div class="card-body p-0">
              <div class="mailbox-read-info">
                문서번호 ${detailms.id} <br>
				분류 ${detailms.category}
                <h6>
                  <span class="mailbox-read-time float-right"> 
                  작성자 ${detailms.name} < ${detailms.dept_name} > <br>
                  작성일  &nbsp ${detailms.create_date}
                  &nbsp &nbsp 조회수 &nbsp ${detailms.hit}
                  </span></h6>
              </div>
     
              </div>
              <!-- /.mailbox-controls -->
              <div class="mailbox-read-message">
                <p>${detailms.content}</p>
              </div>
              <!-- /.mailbox-read-message -->
            </div>
            <!-- /.card-body -->
    

            <div class="card-footer bg-white">
              <ul class="mailbox-attachments d-flex align-items-stretch clearfix">
			  	<c:if test="${detailFile.size() == 0 }">
					<div>첨부파일 없음.</div>
				</c:if>       
				<c:if test="${detailFile.size() > 0 }">
					<c:forEach items="${detailFile}" var="i">
                  <div class="mailbox-attachment-info">
                    <a class="mailbox-attachment-name"><i class="fas fa-paperclip"></i> &nbsp ${i.oriFileName}</a>
					&nbsp &nbsp
                    <a href="msdownload.do?path=${i.newFileName}" class="btn btn-default btn-sm float-right"><i class="fas fa-cloud-download-alt"></i></a>
                    
                  </div>
       
       
       			
            	</c:forEach>
			</c:if>
              </ul>
            </div>
            <!-- /.card-footer -->
            <div class="card-footer">
              <div class="float-right">
            	 <button type="button" onclick="location.href='/archiveUpdate.go?id=${detailms.id}&member_id=${detailms.member_id}'" class="btn btn-default"> 수정</button>
                <button type="button" onclick="location.href='/archiveBoard.go'" class="btn btn-default"> 목록</button>
              </div>

            </div>
            <!-- /.card-footer -->
          </div>
          <!-- /.card -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
    </section>
      </div><!-- /.container-fluid -->
   
  </div>

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