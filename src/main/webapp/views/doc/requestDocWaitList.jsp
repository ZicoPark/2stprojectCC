<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>결재대기함</title>
<link rel="icon" href="/img/CC_favicon.png">
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>

<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="../../dist/css/adminlte.min.css">
<style>
th{
	text-align: center;
}
</style>
</head>
<body>
	<jsp:include page="../index.jsp"/>
	<!-- Site wrapper -->
	<div class="wrapper">
		<div class="content-wrapper">
			<section class="content-header">
				<h1>결재대기함</h1>
			</section>
			<!-- Main content -->
			<section class="content">
				<table class="table table-bordered">
					<colgroup>
						<col width="5%"/>
						<col width="40%"/>
						<col width="9%"/>
						<col width="9%"/>
						<col width="9%"/>
						<col width="9%"/>
						<col width="10%"/>
						<col width="9%"/>
					</colgroup>
					<thead>
						<tr>
							<th>순번</th>
							<th>제목</th>
							<th>문서종류</th>
							<th>결재상태</th>
							<th>생산부서</th>
							<th>기안자</th>
							<th>결재요청시각</th>
							<th>읽음여부</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${list.size() == 0 }">
							<tr>
								<td colspan="8" style="text-align: center;">결재대기 중인 문서가 없습니다.</td>
							</tr>
						</c:if>
						<c:if test="${list.size() > 0 }">
							<c:forEach items="${list }" var="i" varStatus="varStatus">
								<tr>
									<td style="text-align: center;">${varStatus.count }</td>
									<td><a href="requestDocWaitDetail.go?type=normal&id=${i.id }">${i.subject }</a></td>
									<td style="text-align: center;">${i.doc_form_name }</td>
									<c:if test="${i.approval_kind_name eq '결재'}">
										<td style="text-align: center;"><span class="badge bg-red">${i.approval_kind_name }대기</span></td>
									</c:if>
									<c:if test="${i.approval_kind_name eq '검토'}">
										<td style="text-align: center;"><span class="badge bg-yellow">${i.approval_kind_name }대기</span></td>
									</c:if>
									<td style="text-align: center;">${i.production_dept_name }</td>
									<td style="text-align: center;">${i.create_member_name }</td>
									<td style="text-align: center;"><span class="badge bg-primary">${i.create_at }</span></td>
									<c:if test="${i.read_chk eq true}">
										<td style="text-align: center;"><span class="badge bg-primary">읽음</span></td>
									</c:if>
									<c:if test="${i.read_chk eq false}">
										<td style="text-align: center;"><span class="badge bg-gray">읽지않음</span></td>
									</c:if>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</section>
		</div>
	</div>
</body>
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>
<script>
</script>
</html>