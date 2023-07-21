<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>근태 변경 요청 리스트</title>
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
            <h1>근태 변경 요청 리스트</h1>
    </section>
    <br/>
    <!-- Main content -->
    <section class="content">
    	<table class="table table-bordered">
    		<thead>
    			<tr>
    				<th>날짜</th>
    				<th>요청 시간</th>
    				<th>요청 유형</th>
    				<th>처리 상태</th>				
    			</tr>    		
    		</thead>
    		<tbody>
    			<c:if test="${dto eq null}">
					<tr>
						<th colspan="4">근태 수정 요청 사항이 없습니다.</th>
					</tr>
				</c:if>   		
	    		<c:forEach items="${dto}" var="dto">
					<tr>
	    				<td>${dto.date}</td>
	    				<td>${dto.update_at}</td>
	    				<td>${dto.type}</td>
	    				<c:if test="${dto.approval eq 0}"><td>대기</td></c:if>
	    				<c:if test="${dto.approval eq 1}"><td>승인</td></c:if>
	    				<c:if test="${dto.approval eq 2}"><td>반려</td></c:if>
	    			</tr>			
				</c:forEach>				
    		</tbody>    	
    	</table>
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
</script>
</html>
