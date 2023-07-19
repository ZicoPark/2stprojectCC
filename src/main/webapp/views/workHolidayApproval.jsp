<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>전 사원 연차/휴가 현황</title>
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
            <h1>전 사원 연차/휴가 현황</h1>         
    </section>
    <br/>
    <!-- Main content -->
    <section class="content">
    	<div class="input-group" style="width: 20%;">
    	<form action="holidayListFind.do">
			<input type="number" class="form-control" max=12 id="holidayList" name="holidayList" value=""/>
			<button class="btn btn-primary">월 검색</button>
    	</form>
    	</div>
    	<table class="table table-bordered">
    		<thead>
    			<tr>
    				<th>아이디</th>
    				<th>이름</th>
    				<th>연차 시작 날짜</th>
    				<th>연차 종료 날짜</th>
    				<th>연차 사용 일수</th>
    				<th>연차 처리</th>
    			</tr>    		
    		</thead>
    		<tbody>
    			<c:if test="${dto eq null}">
					<tr>
						<th colspan="5">등록된 연차가 없습니다.</th>
					</tr>
				</c:if>   		
	    		<c:forEach items="${dto}" var="holiday">
					<tr> 
	    				<td>${holiday.member_id}</td>
	    				<td>${holiday.name}</td>
	    				<td>${holiday.start_date}</td>
	    				<td>${holiday.end_date}</td>
	    				<td>${holiday.use_cnt}</td>
	    				<td>
							<button type="button" class="btn btn-success btn-sm" onclick="confirmApproval(${holiday.id}, '${holiday.type}', 1)">승인</button>
							<button type="button" class="btn btn-danger btn-sm" onclick="confirmApproval(${holiday.id}, '${holiday.type}', 2)">반려</button>
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
	

	function confirmApproval(id, type, approval) {
	    var message = approval === 1 ? '승인' : '반려';
	    if (confirm(message + '하시겠습니까?')) {
	        // 사용자가 확인을 누른 경우
	        location.href = 'workAnnualApproval.do?id=' + id + '&type=' + type + '&approval=' + approval;
	    } else {
	    }
	}


</script>
</html>
