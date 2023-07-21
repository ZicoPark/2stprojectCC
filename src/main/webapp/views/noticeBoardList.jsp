<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>공지사항</title>
<link rel="icon" href="/img/CC_favicon.png">

<!-- CSS only -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<!-- Tempusdominus Bootstrap 4 -->
<link rel="stylesheet"
	href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
<!-- overlayScrollbars-->
<link rel="stylesheet"
	href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
<!-- Ionicons -->
<link rel="stylesheet"
	href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">



<!--  Google Font: Source Sans Pro -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome-->
<link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
<!-- Theme style-->
<link rel="stylesheet" href="dist/css/adminlte.min.css">

<style>
</style>

</head>

<body class="hold-transition sidebar-mini">

	<!-- Site wrapper -->
	<div class="wrapper">

		<jsp:include page="index.jsp"></jsp:include>


		<div class="content-wrapper">
			<section class="content-header">
				<h1>공지사항</h1>
			</section>
			<!-- Main content -->
			<section class="content">

				<c:if test="${loginid.admin_chk eq 1}">
					<button onclick="location.href='noticeBoardWrite.go'"
						class="btn btn-primary float-right" style="margin-bottom: 10px;">
						<i class="fas fa-plus"></i> 작성
					</button>
				</c:if>
				<table class="table table-bordered table-hover dataTable dtr-inline">
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${list eq null}">
							<tr>
								<th colspan="6">등록된 글이 없습니다.</th>
							</tr>
						</c:if>
						<c:forEach items="${list}" var="noticeBoard" varStatus="loop">
							<tr>
								<td>${list.size() - loop.index}</td>
								<td><a
									href="noticeBoardDetail.do?type=list&id=${noticeBoard.id}">${noticeBoard.subject}</a></td>
								<td>${noticeBoard.name}(${noticeBoard.user_id})</td>
								<td>${noticeBoard.create_at.substring(0, 10)}</td>
								<td>${noticeBoard.hit}</td>
								<%--  				      <td><a href="noticeBoardDel.do?id=${noticeBoard.id}">삭제</a></td> --%>
							</tr>
						</c:forEach>

					</tbody>
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
	<script type="text/javascript"
		src="../../dist/js/jquery.twbsPagination.min.js"></script>



	<!-- jQuery UI 
<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
-->
	<!-- <script src="../../js/websocket.js"></script> -->
</body>
<script>

	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
	

</script>
</html>