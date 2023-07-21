<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>개인 업무 관리</title>
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
            <h1>개인 업무 관리</h1>
        </div>
      </div>
    </section>

<form action="personalWrite.do" method="post">
    <section class="content">
          <div class="card card-primary" style="margin: 40px;">
            <div class="card-header">
              <h3 class="card-title">개인 업무 작성</h3>

            </div>
            <div class="card-body">
              
              <div class="form-group">
				 <label for="inputName">업무 사항</label>
                <input type="text" class="form-control" name = "title" id="title">
              </div>
              
              <div class="form-group">
                <label for="inputPriod">시작일</label>
                <input type="date" class="form-control" name="start_at" id="start_at" placeholder="시작일">
              </div>

              <div class="form-group">
                <label for="inputDeadLinePriod">마감일</label>
                <input type="date" class="form-control" name="end_at" id="end_at" placeholder="마감일">
              </div>
              
            </div>
            <!-- /.card-body -->
          </div>
          <!-- /.card -->
	          <button type="button" id = "submit" onclick="pWrite()" class="btn btn-success float-right" style="margin-right: 40px;">작성하기</button>
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

var overlayChk = true;

function pWrite(){
   if(overlayChk == true){
      if($('#title').val()==''){
         alert('업무 사항을 입력해주세요!');
         $('#title').focus();
      }else if($('#start_at').val()==''){
         alert('시작일을 입력해주세요!');
         $('#start_at').focus();
      }else if($('#end_at').val()==''){
          alert('마감일을 입력해주세요!');
          $('#end_at').focus();
       }else{
         $('button').attr('type','submit');
      }
   }
}

</script>
</html>
   