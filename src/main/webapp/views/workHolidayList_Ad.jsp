<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>전 사원 연차/휴가 현황</title>

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
    <br/>
    	<div>
    	<form action="holidayListFind.do">
			<input type="number" min=1 max=12 id="holidayList" name="holidayList"/>월
			<button>월 검색</button>
    	</form>
    	</div>
    	<div style="text-align: right;">
    		<form action="giveAnnualLeave_id.do">
    			<input type="text" name="galId" placeholder="연차 등록할 아이디를 입력해주세요.">
		        <button>연차 등록</button>
		    </form>
    		<br/>
		    <form action="giveAnnualLeave.do">
		        <button>모든 사원 연차 초기화</button>
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
    				<th>
    					연차 상태
    					<select id="approvalChange">
    						<option value="0">대기</option>
    						<option value="1">승인</option>
    						<option value="2">반려</option>
    					</select>
    				</th>
    				<th>연차 타입</th>
    				<th>연차 승인/반려</th>
    			</tr>    		
    		</thead>
    		<tbody id="holidayBody">
    			<c:if test="${dto eq null}">
					<tr>
						<th colspan="7">등록된 연차가 없습니다.</th>
					</tr>
				</c:if>   		
	    		<c:forEach items="${dto}" var="holiday">
					<tr> 
	    				<td>${holiday.user_id}</td>
	    				<td>${holiday.name}</td>
	    				<td>${holiday.start_at}</td>
	    				<td>${holiday.end_at}</td>
	    				<td>${holiday.use_cnt}</td>
	    				<c:if test="${holiday.approval.equals('0')}"><td>대기</td></c:if>
	    				<c:if test="${holiday.approval.equals('1')}"><td>승인</td></c:if> 
	    				<c:if test="${holiday.approval.equals('2')}"><td>반려</td></c:if>
	    				
	    				<c:if test="${holiday.type.equals('A')}"><td>일반(연차 소진 O)</td></c:if>
	    				<c:if test="${holiday.type.equals('B')}"><td>특별(연차 소진 X)</td></c:if>
	    				
	    				<td>
	    					<div class="btn-group" role="group">
			              		<button id="b1" type="button" class="btn btn-success btn-sm" onclick="location.href='holidayApproval.do?approval=1&id=${holiday.id}&regist_id=${holiday.regist_id}&use_cnt=${holiday.use_cnt}&type=${holiday.type}&start_at=${holiday.start_at}&end_at=${holiday.end_at}'">승인</button>
			              		<button id="b2" type="button" class="btn btn-danger btn-sm" onclick="location.href='holidayApproval.do?approval=2&id=${holiday.id}&regist_id=${holiday.regist_id}&use_cnt=${holiday.use_cnt}&type=${holiday.type}&start_at=${holiday.start_at}&end_at=${holiday.end_at}'">반려</button>
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
	
	$('#approvalChange').on('change', function(e){
		   var approvalChange = $('#approvalChange').val();      
		   console.log("approvalChange ? " + approvalChange);      
		   $.ajax({
		      type: 'get'
		      ,url: 'approvalChange.ajax'
		      ,data:{'approval':approvalChange}
		      ,dataType:'json'
		      ,success:function(data){		         
		         if(data != ""){
		        	 console.log("연차 상태 호출");
		        	 holidayDraw(data.list);
		         } else {
		            alert('오류가 발생하였습니다.');
		         }
		      }
		      ,error:function(e){
		         console.log(e);
		      }
		   });
	})
	
	function holidayDraw(list) {
        console.log("list : " + list);
        var content = '';
        if (list.length > 0) {
            console.log("list if : " + list);
            list.forEach(function (item, index) {
                content += '<tr>';
                content += '<td>' + item.user_id + '</td>';
                content += '<td>' + item.name + '</td>';
                content += '<td>' + item.start_at + '</td>';
                content += '<td>' + item.end_at + '</td>';
                content += '<td>' + item.use_cnt + '</td>';                
                
                if (item.approval == '0') {
                    content += '<td>대기</td>';
                } else if (item.approval == '1') {
                    content += '<td>승인</td>';
                } else if (item.approval == '2') {
                    content += '<td>반려</td>';
                }
                
                if (item.type == "A") {
                    content += '<td>일반(연차 소진 O)</td>';
                } else if (item.type == "B") {
                    content += '<td>특별(연차 소진 X)</td>';
                }
                
                
                content += '<td>';
                content += '<div class="btn-group" role="group">';
                content += '<button id="b1" type="button" class="btn btn-success btn-sm" onclick="location.href=\'holidayApproval.do?approval=1&id=' + item.id + '&regist_id=' + item.regist_id + '&use_cnt=' + item.use_cnt + '&type=' + item.type + '&start_at=' + item.start_at + '&end_at=' + item.end_at + '\'">승인</button>';
                content += '<button id="b2" type="button" class="btn btn-danger btn-sm" onclick="location.href=\'holidayApproval.do?approval=2&id=' + item.id + '&regist_id=' + item.regist_id + '&use_cnt=' + item.use_cnt + '&type=' + item.type + '&start_at=' + item.start_at + '&end_at=' + item.end_at + '\'">반려</button>';
                content += '</div>';
                content += '</td>';

                content += '</tr>';
            });
            console.log("list forEach : " + content);
        } else {
			content = '<tr><th colspan="7">검색 조건에 맞는 결과가 없습니다.</th></tr>';			
		}
		$('#holidayBody').empty();
		$('#holidayBody').append(content);
	}
	
	
</script>
</html>
