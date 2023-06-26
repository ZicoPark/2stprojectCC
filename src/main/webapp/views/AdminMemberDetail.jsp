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
            <h1>관리자 회원 상세보기</h1>         
    </section>
    <!-- Main content -->
    <section class="content">
		<table class="table table-bordered">
			<tr>
				<th>사진</th>
			</tr>
			<tr>
				<td>사진 넣어야함</td>
			</tr>
		</table>
		<table class="table table-bordered">
			<tr>
				<th colspan="5">기본 정보</th>
			</tr>
			<tr>
				<td>이름 - ${detail.name}</td>
				<td>아이디 - ${detail.id}</td>
				<td>생년월일 - ${detail.birth_date}</td>
				<td>이메일 - ${detail.eamil}</td>
				<td>연락처 - ${detail.phone}</td>
			</tr>
		</table>
		<table class="table table-bordered">
			<tr>
				<th colspan="4">관리자</th>
			</tr>
			<tr>
				<td>관리자 설정</td>
				<td>직급 기록</td>
				<td>부서 기록</td>
				<td>근태 기록</td>
			</tr>
		</table>
		<table class="table table-bordered">
			<tr>
				<th colspan="5">인사 정보</th>
			</tr>
			<tr>
				<td>입사일</td>
				<td>부서</td>
				<td>직급</td>
				<td>계정 상태</td>
				<td>퇴사일</td>
			</tr>
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