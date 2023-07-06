<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Creator Company</title>

<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="../../plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="../../dist/css/adminlte.min.css">
</head>
<body class="hold-transition sidebar-mini">
	<jsp:include page="index.jsp"></jsp:include>
	<!-- Site wrapper -->
	<div class="wrapper">



		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1>프로젝트 업무 등록</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="#">Home</a></li>
								<li class="breadcrumb-item active">Project Add</li>
							</ol>
						</div>
					</div>
				</div>
				<!-- /.container-fluid -->
			</section>

			<form action="projectInsert.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="project_id" value="${project_id}" />
			<input type="hidden" name="user_id" value="${user_id}" />
			<input type="hidden" name="member_id" value="${member_id}" />
				<section class="content">
					<div class="row">
						<div class="col-md-6">
							<div class="card card-primary">
								<div class="card-header">
									<h3 class="card-title">입력란</h3>

									<div class="card-tools">
										<button type="button" class="btn btn-tool"
											data-card-widget="collapse" title="Collapse">
											<i class="fas fa-minus"></i>
										</button>
									</div>
								</div>
								<div class="card-body">
									<div class="form-group">
										<label for="inputName">작성자</label> <input type="text"
											id="inputName" class="form-control" name="member_id" value="${user_id}">
									</div>
									<div class="form-group">
										<label for="inputContent">내용</label>
										<textarea id="inputContent" class="form-control"
											name="content" rows="3"></textarea>
									</div>
									<div class="form-group">
										<i class="fas fa-paperclip"></i> 파일 첨부
			    							<input type="file" name="attachment" multiple="multiple">
									</div>


									<div class="row">
										<div class="col-sm-6">
											<label for="inputStep">단계</label> <select id="inputStep"
												class="form-control custom-select" name="step">
												<option selected disabled>선택해 주세요</option>
												<option value="촬영">촬영</option>
												<option value="편집">편집</option>
												<option value="검토">검토</option>
												<option value="배포">배포</option>
											</select>
										</div>
										<div class="col-sm-6">
											<label for="inputStatus">상태</label> <select id="inputStatus"
												class="form-control custom-select" name="status">
												<option selected disabled>선택해 주세요</option>
												<option value="준비중">준비중</option>
												<option value="진행중">진행중</option>
												<option value="완료">완료</option>
											</select>
										</div>
									</div>
								</div>



							</div>
							<!-- /.card-body -->
						</div>
						<!-- /.card -->
					</div>
		<div class="row">
			<div class="col-12">
				<a href="projects.go" class="btn btn-secondary">Cancel</a> 
				<input type="submit" value="업무등록" class="btn btn-success float-right">
			</div>
		</div>
		</div>
		</section>
		</form>
		<!-- /.content -->
	</div>
	<!-- /.content-wrapper -->

	<footer class="main-footer">
		<div class="float-right d-none d-sm-block">
			<b>Version</b> 3.2.0
		</div>
		<strong>Copyright &copy; 2014-2021 <a
			href="https://adminlte.io">AdminLTE.io</a>.
		</strong> All rights reserved.
	</footer>

	<!-- Control Sidebar -->
	<aside class="control-sidebar control-sidebar-dark">
		<!-- Control sidebar content goes here -->
	</aside>
	<!-- /.control-sidebar -->
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
</html>
