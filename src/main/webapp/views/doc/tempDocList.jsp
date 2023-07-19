<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>임시저장함</title>
<link rel="icon" href="/img/CC_favicon.png">
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>

<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="../../dist/css/adminlte.min.css">
<style>
th{
	text-align: center;
}
</style>
</head>
<body>
	<jsp:include page="../index.jsp"/>
	<!-- Site wrapper -->
	<div class="wrapper">
		<div class="content-wrapper">
			<section class="content-header">
				<h1>임시저장함</h1>
			</section>
			<!-- Main content -->
			<section class="content">
				<button onclick="location.href='docWriteForm.go'" class="btn btn-primary float-right" style="margin-bottom: 10px;">
				<i class="fas fa-plus"></i>
				새 문서 작성
				</button>
				<table class="table table-bordered table-hover dataTable dtr-inline">
					<colgroup>
						<col width="5%"/>
						<col width="85%"/>
						<col width="10%"/>
					</colgroup>
					<thead>
						<tr>
							<th>순번</th>
							<th colspan="2">제목</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${list.size() == 0 }">
							<tr>
								<td colspan="3" style="text-align: center;">임시저장 중인 문서가 없습니다.</td>
							</tr>
						</c:if>
						<c:if test="${list.size() > 0 }">
							<c:forEach items="${list }" var="i" varStatus="varStatus">
								<tr>
									<td style="text-align: center;">${varStatus.count }</td>
									<td style="text-align: left;"><a href="tempDocUpdateForm.go?id=${i.id }">${i.subject }</a></td>
									<td style="text-align: center;">										
										<a class="btn btn-danger btn-sm" href="tempDocDelete.do?id=${i.id }">
                              				<i class="fas fa-trash"></i>
                              				삭제
                          				</a>
									</td>
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