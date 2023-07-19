<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>출/퇴근 수정 페이지</title>
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
            <h1>출/퇴근 수정 페이지</h1>         
    </section>
     <br/>
    <!-- Main content -->
    <section class="content">
    <form action="WorkChangeRequest.do">
		<table id="popupTable" class="table table-bordered">
			<tbody>
				<tr>
					<th>날짜:</th>
					<td>
						<input type="date" id="date" name="date" value="${params.date}" readonly>
						<input type="hidden" id="working_hour_id" name="working_hour_id" value="${params.working_hour_id}" readonly>
						<input type="hidden" id="name" name="name" value="${params.name}" readonly>
						<input type="hidden" id="member_id" name="member_id" value="${params.member_id}" readonly>
						<input type="hidden" id="time_go" name="time_go" value="${params.time_go}" readonly>
						<input type="hidden" id="time_end" name="time_end" value="${params.time_end}" readonly>
					</td>
				</tr>
				<tr>
					<th>수정 시간:</th>
					<td>
						<input type="number" id="update_time_h" name="update_time_h" max="24" placeholder="시 입력">:
						<input type="number" id="update_time_m" name="update_time_m" max="60" placeholder="분 입력">
					</td>
				</tr>
				<tr>
					<th>수정 유형:</th>
					<td>
						<select name="type">
							<option value="출근">출근</option>
							<option value="퇴근">퇴근</option>
						</select>         
					</td>
				</tr>
				<tr>
					<th>수정 사유:</th>
					<td><input type="text" id="reason" name="reason" placeholder="ex)시스템 오류"></td>
				</tr>
			</tbody>
		</table>
		<button type="submit" class="btn btn-primary">수정 신청</button>
	</form>
	<br/>
	<button onclick="location.href='workHistoryList.go'" class="btn btn-info btn-sm">돌아가기</button>
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
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}

</script>
</html>
