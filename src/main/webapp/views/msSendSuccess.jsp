<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>쪽지 전송 성공</title>
<link rel="icon" href="/img/CC_favicon.png">

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
    
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            margin: 50px auto;
            width: 400px;
            padding: 20px;
            text-align: center;
        }
        h2 {
            color: #555;
            font-size : 15px;
        }
        .icon {
            margin-top: 20px;
            font-size: 50px;
            color: #3498db;
        }
        .buttons {
            margin-top: 30px;
        }
        .button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #20c997;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }
        .button:hover {
            background-color: #2980b9;
        }
    </style>
<body class="hold-transition sidebar-mini">

<jsp:include page = "index.jsp"></jsp:include>
<!-- Site wrapper -->
<div class="wrapper">
    <section class="content">


	
	
    <div class="container">
        <h2>쪽지 작성이 완료되었습니다!</h2>
        <div class="icon">📩</div>

    <div class="buttons">
      <a href="/msSendList.go" class="button"><b>보낸 쪽지함</b></a>
      <a href="/msWrite.go" class="button"><b>추가 쪽지 작성</b></a>
  
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
