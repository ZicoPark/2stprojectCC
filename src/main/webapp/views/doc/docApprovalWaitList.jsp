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
	<h1>결재요청함 목록</h1>
	<br>
	<br>
	<table>
		<thead>
			<tr>
				<th>문서번호</th>
				<th>제목</th>
				<th>작성자</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${list.size() == 0 }">
				<tr>
					<td colspan="3">결재요청 중인 문서가 없습니다.</td>
				</tr>
			</c:if>
			<c:if test="${list.size() > 0 }">
				<c:forEach items="${list }" var="i">
					<tr>
						<td>${i.id }</td>
						<td><a href="tempDocUpdateForm.go?id=${i.id }">${i.subject }</a></td>
						<td>${i.memberId }</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</body>
<script>
</script>
</html>