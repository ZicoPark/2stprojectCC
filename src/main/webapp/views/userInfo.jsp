<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>직원 리스트</title>
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
<div class="wrapper">
  <div class="content-wrapper">
    <section class="content-header">
    	<h1>　마이 페이지</h1>         
    </section>
    <!-- Main content -->
    <section class="content">
    	
      <table class="table table-bordered table-hover dataTable dtr-inline">
         <tr> 
      		<th rowspan="10" style="width: 500px;">
			  <div style="display: flex; align-items: center; justify-content: center; height: 100%;">
			    <c:choose>
			      <c:when test="${not empty member.photoName}">
			        <img src="photoView.do?path=${member.photoName}" style="max-width: 100%; max-height: 100%;">
			      </c:when>
			      <c:otherwise>
			        <img src="img/cc.png" style="max-width: 100%; max-height: 100%;">
			      </c:otherwise>
			    </c:choose>
			  </div>
			</th>
         </tr>
         <tr>
            <th>아이디</th>
            <td>
				<input type="hidden" name = "id" value="${member.id }"/>
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
               ${member.name}               
            </td>            
         </tr>
         <tr>
            <th>생년월일</th>               
            <td>${member.birth_at}</td>
         </tr>
         <tr>
            <th>입사일</th>               
            <td>${member.hire_at}</td>
         </tr>
         <tr>
		 	<th>직급</th>
		   <td>
			    <c:choose>
			        <c:when test="${member.job_level_id eq '8ade9167-1703-11ee-973f-0242ac110002'}">
			            팀원 &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;   &nbsp; &nbsp;
			        </c:when>
			        <c:when test="${member.job_level_id eq '8bbf948d-1703-11ee-973f-0242ac110002'}">
			            팀장 &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;   &nbsp; &nbsp;
			        </c:when>
			        <c:when test="${member.job_level_id eq '8c4e7542-1703-11ee-973f-0242ac110002'}">
			            이사 &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;   &nbsp; &nbsp;
			        </c:when>
			        <c:when test="${member.job_level_id eq '8cdd8503-1703-11ee-973f-0242ac110002'}">
			            사장 &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;   &nbsp; &nbsp;
			        </c:when>
			    </c:choose>
			</td>
		</tr>
         <tr>
            <th>부서</th>
			<td>
			    <c:choose>
			        <c:when test="${member.dept_id eq '8e5f3282-1703-11ee-973f-0242ac110002'}">
			            총무팀 &nbsp; &nbsp; &nbsp; &nbsp; 
			        </c:when>
			        <c:when test="${member.dept_id eq '8ee07433-1703-11ee-973f-0242ac110002'}">
			            기획팀 &nbsp; &nbsp; &nbsp; &nbsp; 
			        </c:when>
			        <c:when test="${member.dept_id eq '8f963853-1703-11ee-973f-0242ac110002'}">
			            촬영팀 &nbsp; &nbsp; &nbsp; &nbsp; 
			        </c:when>
			        <c:when test="${member.dept_id eq '9022f64a-1703-11ee-973f-0242ac110002'}">
			            편집팀 &nbsp; &nbsp; &nbsp; &nbsp; 
			        </c:when>
			    </c:choose>
			</td>
         </tr>
         <tr>
            <th>이메일</th>
            <td>${member.email}</td>
         </tr>
         <tr>
            <th>연락처</th>
            <td>${member.phone}</td>
         </tr>

         <tr>      
            <th colspan="4" style="text-align: center;">
               <button class="btn btn-outline-dark" onclick="location.href='userinfoupdate.go?id=${member.id}'">회원정보 수정</button>
            </th>
            </tr>
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