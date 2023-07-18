<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<style>
	.btn{
		width: 70px;
		height: 35px;
		border-top-left-radius: 5px;
		border-top-right-radius: 5px;
		border-bottom-left-radius: 5px;
		border-bottom-right-radius: 5px;
	}
	#but button{
		border: 1px solid #20c997;
		background-color: rgba(0,0,0,0);
		color: #20c997;
		padding: 5px;
	}
	#but button:hover{
		color: white;
		background-color: #20c997;
	}
</style>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>AdminLTE 3 | Projects</title>
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
            <h1>사원 승인/삭제 상세보기</h1>         
    	</section>
    	<!-- Main content -->
	    <section class="content">
	    <br/>
		<br/>
	    	<table class="table table-bordered">
	    		<tr>
					<th>이름</th>
					<th>아이디</th>
					<th>생년월일</th>
					<th>입사일</th>
					<th>부서</th>
					<th>직급</th>
					<th>이메일</th>
					<th>연락처</th>
				</tr>
				<tr>
					<td>${detail.name}</td>
					<td>${detail.id}</td>
					<td>${detail.birth_at}</td>
					<td>${detail.hire_at}</td>
					<td>${detail.dept_name}</td>
					<td>${detail.job_name}</td>
					<td>${detail.email}</td>
					<td>${detail.phone}</td>
				</tr>
	    	</table>
	    	<div id="but">
	    		<button class="btn" onclick="location.href='MemberONOFFList.go'">목록</button>
	    		<button class="btn" onclick="location.href='MemberONOFFDelete.go'">삭제</button>
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