<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>근무 히스토리</title>

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
            <h1>근무 히스토리</h1>         
    </section>
    <br/>
    <!-- Main content -->
    <section class="content">
    <br/>
    	<div>
    	<button type="button" id="b1" class="btn btn-block btn-outline-success btn-lg" onclick="location.href='timeGo.do'">출근</button>&nbsp;&nbsp;&nbsp;&nbsp;
    	<button type="button" id="b2" class="btn btn-block btn-outline-danger btn-lg" onclick="location.href='timeEnd.do'">퇴근</button>
    	<button type="button" id="b3" class="btn btn-block btn-outline-warning btn-lg" onclick="location.href='workHistoryReqList.go'">수정 요청 리스트</button>
    	</div>
    	<table class="table table-bordered">
    		<thead>
    			<tr>
    				<th>날짜</th>
    				<th>아이디</th>
    				<th>이름</th>
    				<th>출근 시간</th>
    				<th>퇴근 시간</th>
    				<th>근무 시간</th>				
    				<th>수정</th>
    			</tr>    		
    		</thead>
    		<tbody>
    			<c:if test="${workList eq null}">
					<tr>
						<th colspan="7">등록된 근태가 없습니다.</th>
					</tr>
				</c:if>   		
	    		<c:forEach items="${workList}" var="workList">
					<tr>
	    				<td>${workList.date}</td>
	    				<td>${workList.member_id}</td>
	    				<td>${workList.name}</td>
	    				<td>${workList.time_go}</td>
	    				<td>${workList.time_end}</td>    				
	    				<td>${String.format('%.1f', (workList.time_end.time - workList.time_go.time) / (1000.0 * 60 * 60))}</td>
	    				<td>	    			
	    				<a href="WorkChangeRequest.go?date=${workList.date}&member_id=${workList.member_id}&name=${workList.name}&id=${workList.id}&time_go=${workList.time_go}&time_end=${workList.time_end}">
	    					수정
	    				</a>
	    				
	    				</td>
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
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}	
</script>
</html>
