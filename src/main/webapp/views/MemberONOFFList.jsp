<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<style>
	#btn{
		width: 80px;
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
            <h1>사원 승인/삭제</h1>         
    	</section>
    	<!-- Main content -->
	    <section class="content">
	    <br/>
		<br/>
	    	<table class="table table-bordered">
	    		<tr>
					<th>번호</th>
					<th>이름</th>
					<th>아이디</th>
					<th>부서</th>
					<th>처리상태</th>
					<th>상세보기</th>
				</tr>
				<c:forEach items="${list}" var="member" varStatus="loop">
					<tr>
			    		<td>${fn:length(list) - loop.index}</td>
						<td>${member.name}</td>
						<td>${member.id}</td>
						<td>${member.dept_name}</td>
						<td>대기중</td>
						<td id="but">
					    	<button id="btn" onclick="location.href='MemberONOFFListDetail.go?id=${member.id}'">상세보기</button>
					    </td>
					</tr>
				</c:forEach>
	    	</table>
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