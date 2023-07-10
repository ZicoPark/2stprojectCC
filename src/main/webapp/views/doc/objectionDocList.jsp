<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Creator Company</title>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>

<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="../../dist/css/adminlte.min.css">
<style>
</style>
</head>
<body>
	<jsp:include page="../index.jsp"/>
	<!-- Site wrapper -->
	<div class="wrapper">
		<div class="content-wrapper">
			<section class="content-header">
				<h1>반려문서함 목록</h1>
			</section>
			<!-- Main content -->
			<section class="content">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>문서번호</th>
							<th>제목</th>
							<th>결재종류</th>
							<th>반려처리자</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${list.size() == 0 }">
							<tr>
								<td colspan="4">반려처리된 문서가 없습니다.</td>
							</tr>
						</c:if>
						<c:if test="${list.size() > 0 }">
							<c:forEach items="${list }" var="i" varStatus="varStatus">
								<tr>
									<td>${varStatus.count }</td>
									<td><a href="objectionDocDetail.go?id=${i.id }">${i.subject }</a></td>
									<td>${i.approval_kind_name }단계 반려</td>
									<td>${i.objection_member_name }</td>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</section>
		</div>
	</div>
</body>
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>
<script>
</script>
</html>