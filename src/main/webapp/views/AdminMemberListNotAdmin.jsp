<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="kr.co.cc.admin.service.AdminService" %>
<%@ page import="kr.co.cc.admin.dto.AdminDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html lang="en">
<style>
    .row {
        float: right;
    }
    .container {
        float: right;
    }
    .contents {
   	 text-align: center;
    }
	#btn, #list{
		border-top-left-radius: 5px;
		border-top-right-radius: 5px;
		border-bottom-left-radius: 5px;
		border-bottom-right-radius: 5px;
	}
	#but button{
		border: 1px solid #20c997;
		background-color: rgba(0,0,0,0);
		color: #20c997;
	}
	#but button:hover{
		color: white;
		background-color: #20c997;
	}
</style>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>관리자 회원 리스트</title>
<link rel="icon" href="/img/CC_favicon.png">
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
			<h1>관리자 회원 리스트</h1>         
	    </section>
	    <!-- Main content -->
		<section class="content">
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<div class ="contents" id="content">
				<h5>관리자 권한이 존재하지 않습니다.</h5>
			</div>
			<br>
			<% 
			    String id = (String) session.getAttribute("id");
			    if (id != null) { 
			%>
			    <div class="contents" id="but">
			        <button id="list" onclick="location.href='/main.go'">메인페이지로 돌아가기</button>
			    </div>
			<% } else { %>
			    <div class="contents" id="but">
			        <button id="list" onclick="location.href='/'">로그인페이지로 돌아가기</button>
			    </div>
			<% } %>
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