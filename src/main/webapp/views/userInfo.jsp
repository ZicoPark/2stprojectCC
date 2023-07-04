<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>직원 리스트</title>

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
    	<h1>마이 페이지</h1>         
    </section>
    <!-- Main content -->
    <section class="content">
    	
      <table class="table table-bordered table-hover dataTable dtr-inline">
         <tr>
      		<td colspan="2">
				<!--  <img width="200" src="/photo/${member.photoName}"/>-->
			</td>
			<td></td>
         </tr>

         <tr>
            <th>아이디</th>
            <td>
               <input type="text" id="id" name="id" value="${member.user_id}" readonly/>                           
            </td>
         </tr>
         <tr>
            <th>비밀번호</th>
            <td>
               <input type="password" id="password" value="${member.password}" readonly/>                              
            </td>
         </tr>
         <tr>
            <th>이름</th>
            <td>
               <input type="text" id="name" value="${member.name}" readonly/>               
            </td>            
         </tr>
         <tr>
            <th>생년월일</th>               
            <td><input type="text" id ="birth_at" value="${member.birth_at}" readonly/></td>
         </tr>
         <tr>
            <th>입사일</th>               
            <td><input type="text" id ="hire_at" value="${member.hire_at}" readonly/></td>
         </tr>     
         <tr>
            <th>직급</th>
            <td>
				<input type="text" id ="job_level_id " value="${member.job_level_id}" readonly/>
	   	   </td>
         </tr>
         <tr>
            <th>부서</th>
            <td>
				<input type="text" id ="dept_id" value="${member.dept_id}" readonly/>
			</td>
         </tr>
         <tr>
            <th>이메일</th>
            <td><input type="email" id="email" value="${member.email}" readonly/></td>
         </tr>
         <tr>
            <th>연락처</th>
            <td><input type="text" id="phone" value="${member.phone}" readonly/></td>
         </tr>

         <tr>      
            <th colspan="2">
               <button class="btn btn-outline-dark" onclick="location.href='userinfoupdate.go'">회원정보 수정</button>
               <button class="btn btn-outline-dark" onclick="location.href='./'">돌아가기</button>
               <button class="btn btn-outline-dark" onclick="location.href='userdelete.go'">회원탈퇴</button>
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