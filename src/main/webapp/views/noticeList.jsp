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
            <h1>알림 리스트</h1>         
    </section>
    <!-- Main content -->
    <section class="content">
        <table>
			<colgroup>
				<col width="20%"/>
				<col width="20%"/>
				<col width="40%"/>
				<col width="10%"/>
				<col width="10%"/>
			</colgroup>
			<thead>
				<tr>
					<th>게시판</th>
					<th>알림 제목</th>
					<th>알림 내용</th>
					<th>게시판, 번호</th>
					<th>날짜/시간</th>
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
						<td>${alarmList.alarm_content}</td>
						<td>${alarmList.alarm_class}, ${alarmList.alarm_num}</td>
						<td>${alarmList.alarm_time}</td>
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
</body>
<script>
</script>
</html>