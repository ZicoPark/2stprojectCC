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
	<h1>결재대기함 목록</h1>
	<br>
	<br>
	<table>
		<thead>
			<tr>
				<th>문서번호</th>
				<th>문서종류</th>
				<th>제목</th>
				<th>현재상태</th>
				<th>생산부서</th>
				<th>기안자</th>
				<th>요청시각</th>
				<th>읽음여부</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${list.size() == 0 }">
				<tr>
					<td colspan="7">결재대기 중인 문서가 없습니다.</td>
				</tr>
			</c:if>
			<c:if test="${list.size() > 0 }">
				<c:forEach items="${list }" var="i" varStatus="varStatus">
					<tr>
						<td>${varStatus.count }</td>
						<td>${i.doc_form_name }</td>
						<td><a href="requestDocDetail.go?id=${i.id }">${i.subject }</a></td>
						<td>${i.approval_kind_name }대기</td>
						<td>${i.production_dept_name }</td>
						<td>${i.create_member_name }</td>
						<td>${i.create_at }</td>
						<c:if test="${i.read_chk eq true}">
							<td>읽음</td>
						</c:if>
						<c:if test="${i.read_chk eq false}">
							<td>읽지 않음</td>
						</c:if>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</body>
<script>
</script>
</html>