<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>근태 관리</title>
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
            <h1>근태 관리</h1>         
    </section>
     <br/>
    <!-- Main content -->
    <section class="content">
    	<div class="btn-group" role="group">
		    <button type="button" class="btn btn-success btn-sm" onclick="location.href='timeGo.do'">출근</button>&nbsp;&nbsp;
		    <button type="button" class="btn btn-danger btn-sm" onclick="location.href='timeEnd.do'">퇴근</button>&nbsp;&nbsp;
		    <button type="button" class="btn btn-info btn-sm" onclick="location.href='workHistoryReqList.go'">수정 요청 리스트</button>
		</div>
		<br/><br/>
    	<form action="historyListFind.do">
		<div class="input-group" style="width: 20%;">		
			<input type="number" min=1 max=12 id="historyList" name="historyList" class="form-control" placeholder="월 검색"/>
			<button class="btn btn-primary">월 검색</button>
    	</div>
    	</form>

		<br/>
    	<table class="table table-bordered">
    		<thead>
    			<tr>
    				<th>날짜</th>
    				<th>이름</th>
    				<th>출근 시간</th>
    				<th>퇴근 시간</th>
    				<th>근무 시간</th>				
    				<th>수정</th>
    			</tr>    		
    		</thead>
    		<tbody>
    			<c:if test="${workList == null || workList.size() == 0}">
					<tr>
						<th colspan="6">등록된 근태가 없습니다.</th>
					</tr>
				</c:if>   		
	    		<c:forEach items="${workList}" var="workList">
					<tr>
	    				<td>${workList.date}</td>
	    				<td>${workList.name}</td>
	    				<td>${workList.time_go}</td>
	    				<td>${workList.time_end}</td>    				
	    				<td>${String.format('%.1f', (workList.time_end.time - workList.time_go.time) / (1000.0 * 60 * 60))}</td>
	    				<td>	    			
	    				<a class="btn btn-primary" href="WorkChangeRequest.go?date=${workList.date}&member_id=${workList.member_id}&name=${workList.name}&working_hour_id=${workList.id}&time_go=${workList.time_go}&time_end=${workList.time_end}">
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
