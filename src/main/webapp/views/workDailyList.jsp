<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>일별 전 사원 근태 현황</title>
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
            <h1>일별 전 사원 근태 현황</h1>         
    </section>
    <br/>
    <!-- Main content -->
    <section class="content">
    	<div class="input-group" style="width: 20%;">
		    <input type="date" id="dailyList" name="dailyList" class="form-control" value=""/>
		    <button class="btn btn-primary" onclick="daliyListFind()">검색</button>	
		</div>
		<br/>

    	<table class="table table-bordered">
    		<thead>
    			<tr>
    				<th>부서</th>
    				<th>아이디</th>
    				<th>이름</th>
    				<th>직급</th>
    				<th>근무일</th>
    				<th>출근 시간</th>
    				<th>퇴근 시간</th>				
    				<th>근무 시간</th>
    			</tr>    		
    		</thead>
    		<tbody id="dailyListId">
    			<c:if test="${dto eq null}">
					<tr>
						<th colspan="8">등록된 근태가 없습니다.</th>
					</tr>
				</c:if>   		
	    		<c:forEach items="${dto}" var="workList">
					<tr> 
	    				<td>${workList.dept_name}</td>
	    				<td>${workList.user_id}</td>
	    				<td>${workList.name}</td>
	    				<td>${workList.job_name}</td>
	    				<td>${workList.date}</td>
	    				<td>${workList.time_go}</td>    				
	    				<td>${workList.time_end}</td>
	    				<td>
	    					${String.format('%.1f', (workList.time_end.time - workList.time_go.time) / (1000.0 * 60 * 60))}
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
	
	function daliyListFind(){
		var dailyListDate = $('#dailyList').val();
		console.log(dailyListDate);			
		$.ajax({
			type:'get',
			url:'dailyListFind.ajax',
			data:{'dailyListDate':dailyListDate},
			dataType:'json',
			success:function(data){
				console.log(data);
				dailyListDraw(data.dto);
			},error:function(e){
				console.log(e);
			}		
		});		
	}
	
	
	function dailyListDraw(list){
		console.log("list : " + list);
		var content ='';
		if(list.length>0){
			console.log("list if : " + list);
			list.forEach(function(item,index){
				content += '<tr>';
				content += '<td>'+item.dept_name+'</td>';
				content += '<td>'+item.user_id+'</td>';
				content += '<td>'+item.name+'</td>';
				content += '<td>'+item.job_name+'</td>';
				content += '<td>'+item.date+'</td>';
				content += '<td>'+item.time_go+'</td>';
				content += '<td>'+item.time_end+'</td>';
				var timeEnd = parseTimeString(item.time_end);
			    var timeGo = parseTimeString(item.time_go);
				var duration = (timeEnd.getTime() - timeGo.getTime()) / (1000 * 60 * 60);
		        content += '<td>' + duration.toFixed(1) + '</td>';
				content += '</tr>';
			})
			console.log("list forEach : " + content);			
		} else {
			content = '<tr><th colspan="7">해당 날짜에 등록된 근태가 없습니다.</th></tr>';
		}
		$('#dailyListId').empty();
		$('#dailyListId').append(content);
	}
	
	function parseTimeString(timeString) {
		  var parts = timeString.split(':');
		  if (parts.length === 3) {
		    var hours = parseInt(parts[0], 10);
		    var minutes = parseInt(parts[1], 10);
		    var seconds = parseInt(parts[2], 10);
		    return new Date(1970, 0, 1, hours, minutes, seconds);
		  }
		  return null;
	}
	
</script>
</html>
