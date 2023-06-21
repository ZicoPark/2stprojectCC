<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
  
  <!-- 부트스트랩 JavaScript 파일 불러오기 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

<style>
	table, th, td{
		border : 1px solid black;
		border-collapse: collapse;
		padding : 5px 10px;
	}
</style>
</head>
<body>
	<form action="join.do" method="post">
		<table>
			<tr>
				<th>아이디</th>
				<td><input type="text" name="id"/></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="password"/></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="name"/></td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td><input type="text" id="birthday" name="birth_date"/></td>
			</tr>
			<tr>
				<th>입사일</th>
				<td><input type="text" id="hiredate" name="hire_date"/></td>
			</tr>
			<tr>
				<th>직급</th>
				<td>
				<select name="job_name" id="job_name">
            	 <option value="사원">사원</option>
		         <option value="대리">대리</option>
		         <option value="팀장">팀장</option>
      			</select>				
				</td>
			</tr>
			<tr>
				<th>부서</th>
				<td>
				<select name="dept_name" id="dept_name">
            	 <option value="총무팀">총무팀</option>
		         <option value="촬영팀">촬영팀</option>
		         <option value="편집팀">편집팀</option>
		         <option value="배포팀">배포팀</option>
      			</select>				
				</td>
			</tr>
			<tr>
				<th>E-MAIL</th>
				<td><input type="text" name="email"/></td>
			</tr>
			<tr>
				<th>연락처</th>
				<td><input type="text" name="phone"/></td>
			</tr>
			<tr>
				<th>사진</th>
				<td><input type="text" name="picture"/></td>
			</tr>
			
			<tr>
				<th colspan="2">
					<input type="submit" value="회원등록"/>
				</th>
			</tr>
		</table>
	</form>
</body>
<script>
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
	
	$(function() {
		  $("#birthday").datepicker({
		    dateFormat: "yy-mm-dd",
		    changeMonth: true,
		    changeYear: true,
		    yearRange: "-100:+0",
		    maxDate: new Date()
		  });
		});
	
	$(function() {
		  $("#hiredate").datepicker({
		    dateFormat: "yy-mm-dd",
		    changeMonth: true,
		    changeYear: true,
		    yearRange: "-100:+0",
		    maxDate: new Date()
		  });
		});
</script>
</html>