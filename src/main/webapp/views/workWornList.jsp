<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>근태 경고 리스트</title>
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
            <h1>근태 경고 리스트</h1>         
    </section>
    <br/>
    <!-- Main content -->
    <section class="content">
    	<table class="table table-bordered">
	   		<thead>
	   			<tr>
	   				<th>아이디</th>
	   				<th>이름</th>
	   				<th>부서</th>
	   				<th>날짜</th>
	   				<th>경고 횟수</th>			
	   			</tr>    		
	   		</thead>
	   		<tbody id="wornListIdAll">
	   			<c:if test="${wornAllList eq null}">
					<tr>
						<th colspan="5">등록된 근태 경고가 없습니다.</th>
					</tr>
				</c:if>   		
	    		<c:forEach items="${wornAllList}" var="wornAllList">
					<tr>
	    				<td>${wornAllList.user_id}</td>
	    				<td>${wornAllList.name}</td>
	    				<td>${wornAllList.dept_name}</td>
	    				<td>${wornAllList.week}</td>
	    				<td>${wornAllList.total_worn}</td>  				
	    			</tr>			
				</c:forEach>				
	   		</tbody>    	
	   	</table>
    	
	    <br/>
	    <b>근태 경고 내역</b>
	    <div class="input-group" style="width: 20%;">
		    <select id="wornFind1" class="form-control">
		    	<option value="name">이름</option>
		    	<option value="member_id">아이디</option>
		    </select>	    
			<input type="text" id="wornFind2" value="" class="form-control"/>
			<button class="btn btn-primary" onclick="wornListFind()">검색</button>	
    	</div>
    	<br/>
	   	<table class="table table-bordered">
	   		<thead>
	   			<tr>
	   				<th>아이디</th>
	   				<th>이름</th>
	   				<th>부서</th>
	   				<th>날짜</th>
	   				<th>근무 시간</th>			
	   				<th>경고 해제</th>
	   			</tr>    		
	   		</thead>
	   		<tbody id="wornListId">
	   			<c:if test="${wornList eq null}">
					<tr>
						<th colspan="6">등록된 근태 경고가 없습니다.</th>
					</tr>
				</c:if>   		
	    		<c:forEach items="${wornList}" var="wornList">
					<tr> 
	    				<td>${wornList.user_id}</td>
	    				<td>${wornList.name}</td>
	    				<td>${wornList.dept_name}</td>
	    				<td>${wornList.week}</td>
	    				<td>${wornList.total_time}</td>  				
	    				<td>
	    					<button class="btn btn-danger btn-sm" onclick="wornDel('${wornList.member_id}', '${wornList.week}')">경고 해제</button>
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
	
	function wornListFind(){
		var wornFind1 = $('#wornFind1').val();
		var wornFind2 = $('#wornFind2').val();
		
		console.log(wornFind1+wornFind2);
		
		$.ajax({
			type:'get',
			url:'wornListFind.ajax',
			data:{
				'wornFind1':wornFind1,
				'wornFind2':wornFind2				
			},
			dataType:'json',
			success:function(data){
				console.log(data);
				wornListDraw(data.dto);
			},error:function(e){
				console.log(e);
			}		
		});		
	}
	    
	function wornListDraw(list){
		console.log("list : " + list);
		var content ='';
		if(list.length>0){
			console.log("list if : " + list);
			list.forEach(function(item,index){
				content += '<tr>';
				content += '<td>'+item.user_id+'</td>';
				content += '<td>'+item.name+'</td>';
				content += '<td>'+item.dept_name+'</td>';
				content += '<td>'+item.week+'</td>';
				content += '<td>'+item.total_time+'</td>';
				content += '<td><button class="btn btn-danger btn-sm" onclick="wornDel(\'' + item.member_id + '\', \'' + item.week + '\')">경고 해제</button></td>';
				content += '</tr>';
			})
			console.log("list forEach : " + content);			
		} else {
			content = '<tr><th colspan="6">검색 조건에 맞는 결과가 없습니다.</th></tr>';
			
		}
		$('#wornListId').empty();
		$('#wornListId').append(content);
	}
	
	
	function wornListDrawAll(list){
		console.log("list : " + list);
		var allContent ='';
		if(list.length>0){
			console.log("list if : " + list);
			list.forEach(function(item,index){
				allContent += '<tr>';
				allContent += '<td>' + item.user_id + '</td>';
				allContent += '<td>' + item.name + '</td>';
				allContent += '<td>' + item.dept_name + '</td>';
				allContent += '<td>' + item.week + '</td>';
				allContent += '<td>' + item.total_worn + '</td>';
				allContent += '</tr>';
			})
			console.log("list forEach : " + allContent);			
		} else {
			allContent = '<tr><th colspan="5">등록된 근태 경고가 없습니다.</th></tr>';
			
		}
		$('#wornListIdAll').empty();
		$('#wornListIdAll').append(allContent);
	}
	
	
    function wornDel(memberID, week) {
    	console.log("wornDel");
    	var wornFind1 = $('#wornFind1').val();
		var wornFind2 = $('#wornFind2').val();
        $.ajax({
            type: 'GET',
            url: 'wornDel.ajax',
            data: {
                'member_id': memberID,
                'week': week,
                'wornFind1':wornFind1,
				'wornFind2':wornFind2
            },
            dataType: 'json',
            success:function(data){
            	console.log("wornDel");
				console.log(data);
				wornListDraw(data.dto);
				wornListDrawAll(data.dto2);
				
			},error:function(e){
				console.log("wornDel");
				console.log(e);
			}		
		});		
	}


</script>
</html>
