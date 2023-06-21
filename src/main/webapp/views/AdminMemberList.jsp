<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>AdminLTE 3 | Projects</title>

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
          <table class="table table-bordered">
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>아이디</th>
				<th>부서</th>
				<th>계정상태</th>
				<th>관리자여부</th>
				<th>상세보기</th>
			</tr>
			<c:forEach items="${list}" var="member" varStatus="loop">
			    <tr>
			        <td>${fn:length(list) - loop.index}</td>
			        <td>${member.name}</td>
			        <td>${member.id}</td>
			        <td>${member.dept_name}</td>
			        <td><span style="color: ${member.status ? 'blue' : 'red'}; display: inline-block; text-align: center; width: 100%;">${member.status ? 'Y' : 'N'}</span></td>
			        <td><span style="color: ${member.admin_chk ? 'blue' : 'red'}; display: inline-block; text-align: center; width: 100%;">${member.admin_chk ? 'Y' : 'N'}</span></td>
			        <td><button onclick="location.href='AdminMemberDetail.go'">상세보기</button></td>
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