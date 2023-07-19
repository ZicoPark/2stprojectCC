<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="/img/CC_favicon.png">
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<style>
	table, th, td{
		border: 1px solid black;
		border-collapse: collapse;
		padding: 5px 10px;
	}
	a{
		text-decoration: none;
	}
</style>
</head>
<body>
<jsp:include page = "index.jsp"></jsp:include>
	관리자
	<table>
		<tr>
			<th colspan="2">사원 관리</th>
		</tr>
		<tr>
			<td><a href="MemberList.go">사원 리스트</a></td>
			<td><a href="MemberONOFFList.go">사원 승인/삭제</a></td>
		</tr>
	</table>
	<br>
	<table>
		<tr>
			<th colspan="4">근태 관리</th>
		</tr>
		<tr>
			<td><a href="WorkChangeRequest.go">근태 수정 요청</a></td>
			<td><a href="WorkDailyList.go">일별 근태 현황</a></td>
			<td><a href="WorkWeekList.go">주별 근태 현황</a></td>
			<td><a href="HolidayListAdmin">연차/휴가 현황</a></td>
		</tr>
	</table>
	<br>
	<table>
		<tr>
			<th colspan="4">기타 관리</th>
		</tr>
		<tr>
			<td><a href="DeptCategory">부서 카테고리</a></td>
			<td><a href="ArchiveCategory">자료실 카테고리</a></td>
			<!-- <td><a href="#">그룹웨어 카테고리</a></td>
			<td><a href="#">유튜브 링크 등록</a></td> -->
		</tr>
	</table>
	
</body>
<script></script>
</html>