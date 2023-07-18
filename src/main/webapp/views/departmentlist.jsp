<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
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
<!-- Site wrapper -->
<div class="wrapper">
  <div class="content-wrapper">
    <section class="content-header">
    	<h1>직원 리스트</h1>         
    </section>
    <!-- Main content -->
    <section class="content">
    	<form action= "departmentlist.go">
    		<select name = "opt">
    			<option value="user_id">아이디</option>
    			<option value="name">이름</option>
    			<option value="email">이메일</option>
    			<option value="dept_id">부서</option>
    			<option value="job_level_id">직급</option>
    		</select>
    		<input type = "text" name = "keyword" value="" placeholder="검색어를 입력하세요"/>
    		<input type="submit" value="검색" />
    	</form>
    	
      <table class="table table-bordered table-hover dataTable dtr-inline">
         <thead> 
            <tr> 
               <th>아이디</th>
               <th>이름</th>
               <th>이메일</th>
               <th>부서</th>
               <th>직급</th>
            </tr>
         </thead>
         <tbody>
            <c:if test="${departmentlist eq null}">
               <tr>
                  <th colspan="6">등록된 글이 없습니다.</th>
               </tr>
            </c:if>
            <c:forEach items="${departmentlist}" var="member">
               <tr> 
                  <td>${member.user_id}</td>
                  <td>${member.name}</td>
                  <td>${member.email}</td>
                  <td>
					  <c:choose>
					    <c:when test="${member.dept_id eq '8e5f3282-1703-11ee-973f-0242ac110002'}">총무팀</c:when>
					    <c:when test="${member.dept_id eq '8ee07433-1703-11ee-973f-0242ac110002'}">기획팀</c:when>
					    <c:when test="${member.dept_id eq '8f963853-1703-11ee-973f-0242ac110002'}">촬영팀</c:when>
					    <c:when test="${member.dept_id eq '9022f64a-1703-11ee-973f-0242ac110002'}">편집팀</c:when>
					  </c:choose>
				  </td>
                  <td>
					  <c:choose>
					    <c:when test="${member.job_level_id eq '8ade9167-1703-11ee-973f-0242ac110002'}">팀원</c:when>
					    <c:when test="${member.job_level_id eq '8bbf948d-1703-11ee-973f-0242ac110002'}">팀장</c:when>
					    <c:when test="${member.job_level_id eq '8c4e7542-1703-11ee-973f-0242ac110002'}">이사</c:when>
					    <c:when test="${member.job_level_id eq '8cdd8503-1703-11ee-973f-0242ac110002'}">사장</c:when>
					  </c:choose>
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

</script>
</html>