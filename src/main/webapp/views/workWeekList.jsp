<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>주별 전 사원 근태 현황</title>
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
            <h1>주별 전 사원 근태 현황</h1>         
    </section>
    <br/>
    <!-- Main content -->
    <section class="content">
	    <form action="weekListFind.do">
		    <div class="input-group" style="width: 20%;">
		    	<input type="date" id="date" name="date" class="form-control"/>
		    	<button class="btn btn-primary">검색</button><br/>
		    </div>
				검색을 원하시는 주의 날짜를 선택해주세요. (해당 주의 월요일 ~ 금요일이 검색됩니다.)		
	    </form>
	<table class="table table-bordered">    	
   		<thead>
   			<tr>
   				<th>부서</th>
   				<th>아이디</th>
   				<th>이름</th>
   				<th>직급</th>	
   				<th>시작일</th>			
   				<th>근무 시간</th>		
   				<th>경고 상태</th>
   				<th>경고</th>
   			</tr>    		
   		</thead>
   		<tbody id="weekListId">
   			<c:if test="${dto.size()<1}">
				<tr>
					<th colspan="6">검색을 원하시는 주의 날짜를 선택해주세요. (해당 주의 월요일 ~ 금요일이 검색됩니다.)</th>
				</tr>
			</c:if>   		
    		<c:forEach items="${dto}" var="work">
				<tr> 
    				<td>${work.dept_name}</td>
    				<td>${work.user_id}</td>
    				<td>${work.name}</td>
    				<td>${work.job_name}</td>
    				<td>${week}</td>
    				<td>${work.total_time}</td>
    				<td>${work.worn == true ? 'O' : 'X'}</td>
    				<td>
	    				<a class="btn btn-danger btn-sm" href="workWorn.do?member_id=${work.user_id}&dept_name=${work.dept_name}&name=${work.name}&job_name=${work.job_name}&week=${week}&total_time=${work.total_time}">
	    					경고
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
	var currentDate = new Date().toISOString().split("T")[0];
	document.getElementById("date").value = currentDate;
</script>
</html>
