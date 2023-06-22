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
  <style>
  	button {
		width: 25%;
		float: right;
	}
  </style>
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
    	<button type="button" class="btn btn-block btn-outline-success btn-lg" onclick="location.href='timeGo.do'">출근</button>
    	<button type="button" class="btn btn-block btn-outline-danger btn-lg" onclick="location.href='timeEnd.do'">퇴근</button> 
    	<table id="example2" class="table table-bordered table-hover dataTable dtr-inline" aria-describedby="example2_info">
    		<thead>
    			<tr>
    				<th class="sorting sorting_asc" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="Rendering engine: activate to sort column descending" aria-sort="ascending">번호</td>
    				<td>아이디</td>
    				<td>이름</td>
    				<td>날짜</td>
    				<td>출근 시간</td>
    				<td>퇴근 시간</td>
    				<td>근무 시간</td>
    				<td>날짜</td> 				
    				<td>수정</td>
    			</tr>    		
    		</thead>
    		<tbody>
    			<c:if test="${workList eq null}">
					<tr class="odd">
						<th colspan="8">등록된 근태가 없습니다.</th>
					</tr>
				</c:if>   		
	    		<c:forEach items="${workList}" var="workList">
					<tr class="odd">
	    				<td class="dtr-control sorting_1" tabindex="0">${workList.id}</td>
	    				<td class="dtr-control sorting_1" tabindex="0">${workList.member_id}</td>
	    				<td class="dtr-control sorting_1" tabindex="0">${workList.name}</td>
	    				<td class="dtr-control sorting_1" tabindex="0">${workList.date}</td>
	    				<td class="dtr-control sorting_1" tabindex="0">${workList.time_go}</td>
	    				<td class="dtr-control sorting_1" tabindex="0">${workList.time_end}</td>    				
	    				<td class="dtr-control sorting_1" tabindex="0">${(work.time_end.time - work.time_go.time) / (1000 * 60 * 60)}</td>
	    				<td class="dtr-control sorting_1" tabindex="0">${workList.date}</td>
	    				<td class="dtr-control sorting_1" tabindex="0"><a href="WorkChangeRequest.do?id=${workList.id}">수정</a></td>
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
