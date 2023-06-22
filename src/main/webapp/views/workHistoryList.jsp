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
  	.btn btn-block btn-outline-success btn-lg, .btn btn-block btn-outline-danger btn-lg {
		width: 25%;
		float: right;
	}
	
	#myModal{
		width:30%;
		display: none;
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
    	<table class="table table-bordered">
    		<thead>
    			<tr>
    				<th>번호</th>
    				<th>아이디</th>
    				<th>이름</th>
    				<th>날짜</th>
    				<th>출근 시간</th>
    				<th>퇴근 시간</th>
    				<th>근무 시간</th>
    				<th>날짜</th> 				
    				<th>수정</th>
    			</tr>    		
    		</thead>
    		<tbody>
    			<c:if test="${workList eq null}">
					<tr>
						<th colspan="8">등록된 근태가 없습니다.</th>
					</tr>
				</c:if>   		
	    		<c:forEach items="${workList}" var="workList">
					<tr>
	    				<td>${workList.id}</td>
	    				<td>${workList.member_id}</td>
	    				<td>${workList.name}</td>
	    				<td>${workList.date}</td>
	    				<td>${workList.time_go}</td>
	    				<td>${workList.time_end}</td>    				
	    				<td>${(work.time_end.time - work.time_go.time) / (1000 * 60 * 60)}</td>
	    				<td>${workList.date}</td>
	    				<td><a href="#" id="openModal">수정</a></td>
	    			</tr>			
				</c:forEach>
    		</tbody>    	
    	</table>
    </section>
  </div>
</div>

<div id="myModal" class="modal">
	<table class="table table-bordered">
		<tr>
			<th>아이디</th>
			<td>
				<input type="text" id="id" placeholder="아이디를 입력해주세요 !"/>
			</td>
		</tr>
		<tr>
			<th>날짜</th>
			<td><input type="password" id="pw" placeholder="비밀번호를 입력해주세요 !"/></td>
		</tr>
		<tr>
			<th>요청 유형, 변경 시간, 사유, 번호</th>
			<td><input type="password" id="pw" placeholder="비밀번호를 입력해주세요 !"/></td>
		</tr>
		<tr>
			<th colspan="2">
				<button onclick="WorkChangeRequest()">전송</button>
			</th>            
		</tr>
	</table>
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
	
	
	document.getElementById("openModal").addEventListener("click", function() {
	    // 모달 창 열기
	    var modal = document.getElementById("myModal");
	    modal.style.display = "block";
	});

	document.getElementById("submitBtn").addEventListener("click", function() {
	    // 입력한 데이터 가져오기
	    var inputData = document.getElementById("dataInput").value;

	    // AJAX를 사용하여 데이터를 컨트롤러로 전송
	    var xhr = new XMLHttpRequest();
	    xhr.open("POST", "/your-controller-url", true);
	    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	    xhr.onreadystatechange = function() {
	        if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
	            // 응답 처리
	            console.log(xhr.responseText);
	        }
	    };
	    var data = "inputData=" + encodeURIComponent(inputData);
	    xhr.send(data);

	    // 모달 창 닫기
	    var modal = document.getElementById("myModal");
	    modal.style.display = "none";
	});
	
	function alarmList(){
		console.log("loginId : " + loginId);
		$.ajax({
			type:'get',
			url:'alarmList.ajax',			
			data:{},
			dataType:'json',
			success:function(data){
				console.log("data : " + data.alarmList);
				alarmListDraw(data.alarmList);				
			},
			cache: false,
			error:function(e){
				console.log(e);
			}
		});	
	}
	
</script>
</html>
