<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>연차/휴가 등록</title>

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
            <h1>연차/휴가 등록</h1>         
    </section>
    <!-- Main content -->
    <section class="content">
    <form action="annualRegistration.do">
		<table class="table table-bordered">
			<tbody>
				<tr>
					<th>승인자 : </th>
					<td>
					<select name="approval_id">
						<c:forEach items="${admin}" var="admin">
						<option value="${admin.id}">${admin.name}</option>
						</c:forEach>
					</select>
					</td>
				</tr>
				<tr>
					<th>연차 시작일 : </th>
					<td>
						<input type="number" id="year" name="year" placeholder="2023" value="2023">년
						<input type="number" id="month" name="month" max="12" placeholder="월 입력">월
						<input type="number" id="day" name="day" max="32" placeholder="일 입력">일
					</td>
				</tr>
				<tr>
					<th>연차 종료일 : </th>
					<td>
						<select name="type">
							<option value="출근">출근</option>
							<option value="퇴근">퇴근</option>
						</select>         
					</td>
				</tr>
				<tr>
					<th>사용 일 수 : </th>
					<td><input type="number" id="reason" name="reason" placeholder="ex)시스템 오류"></td>
				</tr>
				<tr>
					<th>연차 사유 : </th>
					<td><input type="text" id="reason" name="reason" placeholder="ex)시스템 오류"></td>
				</tr>
				<tr>
					<th>연차 유형 : </th>
					<td>
						<select name="type">
							<option value="A">출근</option>
							<option value="B">퇴근</option>
						</select>				
					</td>
				</tr>
			</tbody>
		</table>
		<button>수정 신청</button>
	</form>
	<br/>
	<button onclick="location.href='workHistoryList.go'">돌아가기</button>
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
