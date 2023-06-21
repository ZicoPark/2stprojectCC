<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<style>
	table, th, td{
		border: 1px solid black;
		border-collapse: collapse;
		padding: 5px 10px;
	}
</style>
</head>
<body>
	관리자 사원 리스트 페이지
	<table>
		<tr>
			<th>번호</th>
			<th>이름</th>
			<th>아이디</th>
			<th>부서</th>
			<th>계정상태</th>
			<th>관리자여부</th>
			<th>상세보기</th>
		</tr>
		<c:forEach items="${list}" var="member" varStatus="loop">
    <tr>
        <td>${fn:length(list) - loop.index}</td>
        <td>${member.name}</td>
        <td>${member.id}</td>
        <td>${member.dept_name}</td>
        <td><span style="color: ${member.status ? 'blue' : 'red'}; display: inline-block; text-align: center; width: 100%;">${member.status ? 'Y' : 'N'}</span></td>
        <td><span style="color: ${member.admin_chk ? 'blue' : 'red'}; display: inline-block; text-align: center; width: 100%;">${member.admin_chk ? 'Y' : 'N'}</span></td>
        <td><button onclick="location.href='AdminMemberDetail.go'">상세보기</button></td>
    </tr>
</c:forEach>
	</table>
</body>
<script></script>
</html>