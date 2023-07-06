<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Creator Company</title>

<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<style>
</style>
</head>
<body>
	<jsp:include page="../index.jsp"/>
	<!-- Site wrapper -->
	<div class="wrapper">
		<div class="content-wrapper">
			<section class="content-header">
				<h1>임시저장함 목록</h1>
			</section>
			<!-- Main content -->
			<section class="content">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>문서번호</th>
							<th>제목</th>
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
							<c:forEach items="${list }" var="i" varStatus="varStatus">
								<tr>
									<td>${varStatus.count }</td>
									<td><a href="tempDocUpdateForm.go?id=${i.id }">${i.subject }</a></td>
									<td><a href="tempDocDelete.do?id=${i.id }">삭제</a></td>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</section>
		</div>
	</div>
</body>
<script>
</script>
</html>