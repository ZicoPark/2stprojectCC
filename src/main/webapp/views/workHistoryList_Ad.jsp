<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>근태 관리 (관리자)</title>
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
            <h1>근태 관리 (관리자)</h1>
    </section>
    <br/>
    <!-- Main content -->
    <section class="content">
    	<table class="table table-bordered">
    		<thead>
    			<tr>
    				<th>날짜</th>
    				<th>이름</th>
    				<th>아이디</th>
    				<th>요청 시간</th>
    				<th>요청 유형</th>
    				<th>요청 사유</th>
    				<th>
    					처리 상태
    					<select id="historyChange">
    						<option value="0">대기</option>
    						<option value="1">승인</option>
    						<option value="2">반려</option>
    					</select>
    				</th>
    				<th>승인/반려</th>			
    			</tr>    		
    		</thead>
    		<tbody id="historyBody">
    			<c:if test="${dto eq null || dto.size() == 0}">
					<tr>
						<th colspan="8">근태 수정 요청 사항이 없습니다.</th>
					</tr>
				</c:if>   		
	    		<c:forEach items="${dto}" var="dto">
					<tr>
	    				<td>${dto.date}</td>
	    				<td>${dto.name}</td>
	    				<td>${dto.user_id}</td>
	    				<td>${dto.update_at}</td>
	    				<td>${dto.type}</td>
	    				<td>${dto.reason}</td>
	    				<c:if test="${dto.approval eq 0}"><td>대기</td></c:if>
	    				<c:if test="${dto.approval eq 1}"><td>승인</td></c:if>
	    				<c:if test="${dto.approval eq 2}"><td>반려</td></c:if>
	    				<td>
						<div class="btn-group" role="group">
							<button type="button" class="btn btn-success btn-sm" onclick="location.href='WorkChangeAdmin.do?approval=1&working_hour_id=${dto.working_hour_id}&type=${dto.type}&update_at=${dto.update_at}'">승인</button>
							<button type="button" class="btn btn-danger btn-sm" onclick="location.href='WorkChangeAdmin.do?approval=2&working_hour_id=${dto.working_hour_id}&type=${dto.type}&update_at=${dto.update_at}'">반려</button>
        				</div>
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
	
	$('#historyChange').on('change', function(e){
		   var historyChange = $('#historyChange').val();      
		   console.log("historyChange ? " + historyChange);      
		   $.ajax({
		      type: 'get'
		      ,url: 'historyChange.ajax'
		      ,data:{'historyChange':historyChange}
		      ,dataType:'json'
		      ,success:function(data){		         
		         if(data != ""){
		        	 historyDraw(data.list);
		         } else {
		            alert('오류가 발생하였습니다.');
		         }
		      }
		      ,error:function(e){
		         console.log(e);
		      }
		   });
	})
	
	function historyDraw(list) {
	    console.log("list : " + list);
	    var content = '';
	    if (list.length > 0) {
	        console.log("list if : " + list);
	        list.forEach(function (item, index) {
	            content += '<tr>';
	            content += '<td>' + item.date + '</td>';
	            content += '<td>' + item.name + '</td>';
	            content += '<td>' + item.user_id + '</td>';
	            content += '<td>' + item.update_at + '</td>';
	            content += '<td>' + item.type + '</td>';
	            content += '<td>' + item.reason + '</td>';
	
	            if (item.approval == 0) {
	                content += '<td>대기</td>';
	            } else if (item.approval == 1) {
	                content += '<td>승인</td>';
	            } else if (item.approval == 2) {
	                content += '<td>반려</td>';
	            }
	
	            content += '<td>';
	            content += '<div class="btn-group" role="group">';
	            content += '<button type="button" class="btn btn-success btn-sm" onclick="location.href=\'WorkChangeAdmin.do?approval=1&working_hour_id=' + item.working_hour_id + '&type=' + item.type + '&update_at=' + item.update_at + '\'">승인</button>';
	            content += '<button type="button" class="btn btn-danger btn-sm" onclick="location.href=\'WorkChangeAdmin.do?approval=2&working_hour_id=' + item.working_hour_id + '&type=' + item.type + '&update_at=' + item.update_at + '\'">반려</button>';
	            content += '</div>';
	            content += '</td>';
	
	            content += '</tr>';
	        });
	        console.log("list forEach : " + content);
	    } else {
	        content = '<tr><th colspan="8">검색 조건에 맞는 결과가 없습니다.</th></tr>';
	    }
	    $('#historyBody').empty();
	    $('#historyBody').append(content);
	}	
</script>
</html>
