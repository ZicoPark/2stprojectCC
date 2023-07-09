<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <h1>이전 알림</h1>         
    </section>
    <!-- Main content -->
    <section class="content">


<div class="card">
<div class="card-header">
<h3 class="card-title"><!-- 헤더 제목 넣을거면 넣고 --></h3>
</div>

<div class="card-body p-0">
<table class="table table-striped">
<thead>
<tr>
<th style="text-align:center">분류</th>
<th style="text-align:center">알림 제목</th>
<th style="text-align:center">발신인</th>
<th style="text-align:center">날짜</th>
</tr>
</thead>
<tbody>
 				<c:if test="${noticeList eq null}">
					<tr>
						<th colspan="5" style="text-align:center">알림이 없습니다.</th>
					</tr>
				</c:if>
							
				<c:forEach items="${list}" var="noticeList">
					<tr>
						<td style="text-align:center">${noticeList.type}</td>
						<td style="text-align:center"><a href="alarmDetail.do?id=${noticeList.id}">${noticeList.identify_value}</a></td>
						<td style="text-align:center">${noticeList.name}</td>
						<td style="text-align:center">${noticeList.create_at}</td>
					</tr>				
				</c:forEach>
<tr>
</tbody>

</table>
</div>
<div class="card-footer clearfix">
<ul class="pagination pagination-sm m-0 float-right">
<li class="page-item"><a class="page-link" href="#">«</a></li>
<li class="page-item"><a class="page-link" href="#">1</a></li>
<li class="page-item"><a class="page-link" href="#">2</a></li>
<li class="page-item"><a class="page-link" href="#">3</a></li>
<li class="page-item"><a class="page-link" href="#">»</a></li>
</ul>
</div>
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
