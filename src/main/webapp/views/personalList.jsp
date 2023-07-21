<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>개인 업무 관리</title>
<link rel="icon" href="/img/CC_favicon.png">
<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="../../plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="../../dist/css/adminlte.min.css">
<style>
.dashed-border {
	border: 1px dashed #000;
}

.checked {
	border-color: black;
}
</style>
</head>
<body>
	<jsp:include page="index.jsp"></jsp:include>
	<!-- Site wrapper -->
	<div class="wrapper">
		<div class="content-wrapper">
			<section class="content-header">
				<h1>개인 업무 관리</h1>
			</section>
			<!-- Main content -->
			<section class="content">


				<div class="card">
					<div class="card-header ui-sortable-handle">
						<h3 class="card-title">
							<!--       To Do List -->
						</h3>
						<button onclick="location.href='personalWrite.go'"
							class="btn btn-primary float-right">
							<i class="fas fa-plus"></i>&nbsp 작성
						</button>
					</div>

					<table class="table table-striped projects">
						<thead>
							<tr>
								<th style="width: 1%"></th>
								<th style="width: 20%">생성일</th>
								<th style="width: 30%">업무 사항</th>
								<th>시작일</th>
								<th>마감일</th>
								<th style="width: 20%" class="text-center"></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="personal">
								<tr>
									<td>
										<!-- 											 <div class="icheck-primary d-inline ml-2 checkbox-line">
											    <input type="checkbox" value="" name="todo1" id="todoCheck1" onchange="toggleCheckbox(this)">
											    <label for="todoCheck1"></label> 

											</div> -->
									</td>
									<td><a>${personal.create_at}</a></td>
									<td>${personal.title}</td>
									<td>${personal.start_at}</td>
									<td>${personal.end_at}</td>
									<td class="project-actions text-right"><a
										href="personalUpdate.go?id=${personal.id}"
										class="btn btn-primary btn-sm view-btn"> <i
											class="fas fa-edit"> </i> 수정
									</a> <a class="btn btn-danger btn-sm"
										onclick="return confirm('정말로 삭제하시겠습니까?  삭제 후에는 복구가 불가능합니다.');"
										href="personalDel.do?id=${personal.id}"> <i
											class="fas fa-trash"> </i> 삭제
									</a></td>
								</tr>
							</c:forEach>

						</tbody>
					</table>

				</div>

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
	/* var msg ="${msg}"
	
	if(msg !=""){
		alert(msg);
	} */

	// 체크박스 클릭 시 실선 추가/제거 함수
	// 체크박스 클릭 시 실선 추가/제거 함수
	function toggleCheckbox(element) {
		var label = element.nextElementSibling; // 체크박스의 다음 형제 요소인 label 선택
		label.classList.toggle("checked"); // "checked" 클래스를 toggle하여 실선 추가/제거
		var row = element.closest("tr"); // 체크박스가 포함된 가장 가까운 tr 요소를 찾음
		row.classList.toggle("dashed-border"); // "dashed-border" 클래스를 toggle하여 실선 추가/제거
	}

	// 체크박스들에 대한 이벤트 처리
	var checkboxes = document.querySelectorAll("input[type='checkbox']");
	checkboxes.forEach(function(checkbox) {
		checkbox.addEventListener("click", function() {
			toggleCheckbox(this);
		});
	});
</script>
</html>
