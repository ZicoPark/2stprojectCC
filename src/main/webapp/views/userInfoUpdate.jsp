<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>회원 정보 수정</title>

<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- icheck bootstrap -->
  <link rel="stylesheet" href="../../plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  
  <!-- 부트스트랩 JavaScript 파일 불러오기 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
<jsp:include page = "index.jsp"></jsp:include>
<div class="wrapper">
  <div class="content-wrapper">
    <section class="content-header">
    	<h1>마이 페이지</h1>         
    </section>
    <!-- Main content -->
    <section class="content">
    	
      <table class="table table-bordered table-hover dataTable dtr-inline">
         <tr> 
      		<th rowspan="10">
				<img width="500" height="500" src="photoView.do?path=${member.photoName}"/>
			</th>
         </tr>
         <tr>
            <th>아이디</th>
            <td>
               ${member.user_id}                
            </td>
         </tr>
         <tr>
            <th>비밀번호</th>
            <td>
               ********                             
            </td>
         </tr>
         <tr>
            <th>이름</th>
            <td>
               <input type="text" id="name" value="${member.name}" />               
            </td>            
         </tr>
         <tr>
            <th>생년월일</th>               
            <td>${member.birth_at}"</td>
         </tr>
         <tr>
            <th>입사일</th>               
            <td>${member.hire_at}"</td>
         </tr>     
         <tr>
            <th>직급</th>
            <td>
			<select name="job_level_id" id="job_level_id">
				<option value="8ade9167-1703-11ee-973f-0242ac110002">팀원</option>
				<option value="8bbf948d-1703-11ee-973f-0242ac110002">팀장</option>
				<option value="8c4e7542-1703-11ee-973f-0242ac110002">이사</option>
				<option value="8cdd8503-1703-11ee-973f-0242ac110002">사장</option>
			</select>
	   	   </td>
         </tr>
         <tr>
            <th>부서</th>
            <td>
				<select name="dept_id" id="dept_id">
		          	<option value="8e5f3282-1703-11ee-973f-0242ac110002">총무팀</option>
				  	<option value="8ee07433-1703-11ee-973f-0242ac110002">기획팀</option>
				  	<option value="8f963853-1703-11ee-973f-0242ac110002">촬영팀</option>
				  	<option value="9022f64a-1703-11ee-973f-0242ac110002">편집팀</option>
      	    	</select>
			</td>
         </tr>
         <tr>
            <th>이메일</th>
            <td><input type="email" id="email" value="${member.email}" /></td>
         </tr>
         <tr>
            <th>연락처</th>
            <td><input type="text" id="phone" value="${member.phone}" /></td>
         </tr>

         <tr>      
            <th colspan="2">
               <button class="btn btn-outline-dark" onclick="location.href='/userinfo.go'">완료</button>
            </th>
            </tr>
      </table>
    </section>
  </div>
</div>

</body>
<script>


	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}

</script>
</html>