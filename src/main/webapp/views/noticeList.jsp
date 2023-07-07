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

<div class="col-12">
<div class="card">
<div class="card-header">
<h3 class="card-title">Fixed Header Table</h3>
<div class="card-tools">
<div class="input-group input-group-sm" style="width: 150px;">
<input type="text" name="table_search" class="form-control float-right" placeholder="Search">
<div class="input-group-append">
<button type="submit" class="btn btn-default">
<i class="fas fa-search"></i>
</button>
</div>
</div>
</div>
</div>

<div class="card-body table-responsive p-0" style="height: 300px;">
<table class="table table-head-fixed text-nowrap">
<thead>
				<tr>
					<th>분류</th>
					<th>알림 제목</th>
					<th>발신인</th>
					<th>날짜</th>
				</tr>
</thead>
<tbody>
 				<c:if test="${noticeList eq null}">
					<tr>
						<th colspan="5">알림이 없습니다.</th>
					</tr>
				</c:if>
							
				<c:forEach items="${noticeList}" var="noticeList">
					<tr>
						<td>${noticeList.send_id}</td>
						<td><a href="fdetail.do?fbNo=${alarmList.alarm_num}">${alarmList.alarm_title}</a></td>
						<td>${alarmList.alarm_class}, ${alarmList.alarm_num}</td>
						<td>${alarmList.alarm_time}</td>
					</tr>				
				</c:forEach>
<tr>
<td>183</td>
<td>John Doe</td>
<td>11-7-2014</td>
<td><span class="tag tag-success">Approved</span></td>
<td>Bacon ipsum dolor sit amet salami venison chicken flank fatback doner.</td>
</tr>
<tr>
<td>219</td>
<td>Alexander Pierce</td>
<td>11-7-2014</td>
<td><span class="tag tag-warning">Pending</span></td>
<td>Bacon ipsum dolor sit amet salami venison chicken flank fatback doner.</td>
</tr>
<tr>
<td>657</td>
<td>Bob Doe</td>
<td>11-7-2014</td>
<td><span class="tag tag-primary">Approved</span></td>
<td>Bacon ipsum dolor sit amet salami venison chicken flank fatback doner.</td>
</tr>
<tr>
<td>175</td>
<td>Mike Doe</td>
<td>11-7-2014</td>
<td><span class="tag tag-danger">Denied</span></td>
<td>Bacon ipsum dolor sit amet salami venison chicken flank fatback doner.</td>
</tr>
<tr>
<td>134</td>
<td>Jim Doe</td>
<td>11-7-2014</td>
<td><span class="tag tag-success">Approved</span></td>
<td>Bacon ipsum dolor sit amet salami venison chicken flank fatback doner.</td>
</tr>
<tr>
<td>494</td>
<td>Victoria Doe</td>
<td>11-7-2014</td>
<td><span class="tag tag-warning">Pending</span></td>
<td>Bacon ipsum dolor sit amet salami venison chicken flank fatback doner.</td>
</tr>
<tr>
<td>832</td>
<td>Michael Doe</td>
<td>11-7-2014</td>
<td><span class="tag tag-primary">Approved</span></td>
<td>Bacon ipsum dolor sit amet salami venison chicken flank fatback doner.</td>
</tr>
<tr>
<td>982</td>
<td>Rocky Doe</td>
<td>11-7-2014</td>
<td><span class="tag tag-danger">Denied</span></td>
<td>Bacon ipsum dolor sit amet salami venison chicken flank fatback doner.</td>
</tr>
</tbody>
</table>
</div>

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




