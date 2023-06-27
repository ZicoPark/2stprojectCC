<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Creator Company</title>

<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<style>
</style>
</head>
<body>
	<h1>임시문서 상세보기</h1>
	<br>
	<br>
	<table>
		<thead>
			<tr>
				<th>문서번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${list.size() == 0 }">
				<tr>
					<td colspan="4">임시저장 중인 문서가 없습니다.</td>
				</tr>
			</c:if>
			<c:if test="${list.size() > 0 }">
				<c:forEach items="${list }" var="i">
					<td>${i.id }</td>
					<td><a href="tempDocDetail.go?id=${i.id }">${i.subject }</a></td>
					<td>${i.memberId }</td>
					<td><a href="tempDocDelete.do?id=${i.id }">삭제</a></td>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</body>
<script>
</script>
</html>