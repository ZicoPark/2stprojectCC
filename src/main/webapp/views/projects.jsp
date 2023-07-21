<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>프로젝트 홈</title>
<link rel="icon" href="/img/CC_favicon.png">
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
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1>Projects</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="/projects.go">Home</a></li>
								<li class="breadcrumb-item active">Projects</li>
							</ol>
						</div>
					</div>
				</div>
				<!-- /.container-fluid -->
			</section>

			<!-- Main content -->
			<section class="content">

				<!-- Default box -->
				<div class="card">
					<div class="card-header"
						style="background-color: #20c997 !important;">
						<h3 class="card-title">진행중인 프로젝트</h3>

						<div class="card-tools">
							<button type="button" class="btn btn-tool"
								data-card-widget="collapse" title="Collapse">
								<i class="fas fa-minus"></i>
							</button>

							<a href="project-add.go" class="btn btn-sm btn-primary">추가</a>

						</div>
					</div>
					<div class="card-body p-0">
						<table class="table table-striped projects">
							<thead>
								<tr>
									<th style="width: 1%">#</th>
									<th style="width: 20%">프로젝트 제목</th>
									<th style="width: 30%">참여인원</th>
									<th>프로젝트 진행도</th>
									<th style="width: 8%" class="text-center">단계</th>
									<th style="width: 20%"></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${list}" var="project">
									<c:if test="${project.del_chk eq 0}">
										<tr>
											<td>#</td>
											<td><a> ${project.name} </a> <br /> <small>
													${project.create_at} </small></td>
											<td>
												<ul class="list-inline">
													<c:forEach items="${project.userIdPhoto}" var="userId"
														varStatus="loop">
														<li class="list-inline-item"><c:if
																test="${userId.profile_name eq null }">
																<img alt="Avatar" class="table-avatar"
																	src="/img/CC.png">
											        </c:if> <c:if test="${userId.profile_name ne null }">
																<img alt="Avatar" class="table-avatar"
																	src="photoView.do?path=${userId.profile_name }">
															</c:if> ${userId.name}</li>
													</c:forEach>
												</ul>
											</td>

											<td class="project_progress">
												<div class="progress progress-sm">
													<div class="progress-bar bg-green" role="progressbar"
														aria-valuemin="0" aria-valuemax="100"
														style="width: ${project.step == '기획' ? '20%' : project.step == '촬영' ? '40%' : project.step == '편집' ? '60%' : project.step == '검토' ? '80%' : '100%'}"></div>
												</div> <small> ${project.step == '기획' ? '20%' : project.step == '촬영' ? '40%' : project.step == '편집' ? '60%' : project.step == '검토' ? '80%' : '100%'}
													Complete </small>
											</td>
											<td class="project-state"><span
												class="badge badge-success">${project.step}</span></td>
											<td class="project-actions text-right"><a
												href="projectDetail.go?id=${project.id}&public_range=${project.public_range}&del_chk=${project.del_chk}"
												class="btn btn-primary btn-sm view-btn"> <i
													class="fas fa-folder"> </i> 상세보기
											</a> <c:if test="${sessionScope.id eq project.member_id}">
													<a class="btn btn-info btn-sm"
														href="projectUpdate.go?id=${project.id}"> <i
														class="fas fa-pencil-alt"></i> Edit
													</a>
												</c:if></td>
										</tr>
									</c:if>
								</c:forEach>

							</tbody>
						</table>
					</div>
					<!-- /.card-body -->
				</div>


				<div class="card">
					<div class="card-header"
						style="background-color: #20c997 !important;">
						<h3 class="card-title">철회된 프로젝트</h3>

						<div class="card-tools">
							<button type="button" class="btn btn-tool"
								data-card-widget="collapse" title="Collapse">
								<i class="fas fa-minus"></i>
							</button>

						</div>
					</div>
					<div class="card-body p-0">
						<table class="table table-striped projects">
							<thead>
								<tr>
									<th style="width: 1%">#</th>
									<th style="width: 20%">프로젝트 제목</th>
									<th style="width: 30%">참여인원</th>
									<th>프로젝트 진행도</th>
									<th style="width: 8%" class="text-center">단계</th>
									<th style="width: 20%"></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${list}" var="project">
									<c:if test="${project.del_chk eq 1}">
										<tr>
											<td>#</td>
											<td><a> ${project.name} </a> <br /> <small>
													${project.create_at} </small></td>
											<td>
												<ul class="list-inline">
													<c:forEach items="${project.userIdPhoto}" var="userId"
														varStatus="loop">
														<li class="list-inline-item"><c:if
																test="${userId.profile_name eq null }">
																<img alt="Avatar" class="table-avatar"
																	src="/img/CC.png">
															</c:if> <c:if test="${userId.profile_name ne null }">
																<img alt="Avatar" class="table-avatar"
																	src="photoView.do?path=${userId.profile_name }">
															</c:if> ${userId.name}</li>
													</c:forEach>
												</ul>
											</td>
											<td class="project_progress">
												<div class="progress progress-sm">
													<div class="progress-bar bg-green" role="progressbar"
														aria-valuemin="0" aria-valuemax="100"
														style="width: ${project.step == '기획' ? '20%' : project.step == '촬영' ? '40%' : project.step == '편집' ? '60%' : project.step == '검토' ? '80%' : '100%'}"></div>
												</div> <small> ${project.step == '기획' ? '20%' : project.step == '촬영' ? '40%' : project.step == '편집' ? '60%' : project.step == '검토' ? '80%' : '100%'}
													Complete </small>
											</td>
											<td class="project-state"><span
												class="badge badge-success">${project.step}</span></td>
											<td class="project-actions text-right"><a
												href="projectDetail.go?id=${project.id}&public_range=${project.public_range}&del_chk=${project.del_chk}"
												class="btn btn-primary btn-sm view-btn"> <i
													class="fas fa-folder"> </i> 상세보기
											</a> <c:if test="${sessionScope.id eq project.member_id}">
													<a class="btn btn-info btn-sm"
														href="projectUpdate.go?id=${project.id}"> <i
														class="fas fa-pencil-alt"></i> Edit
													</a>
												</c:if></td>
										</tr>
									</c:if>
								</c:forEach>

							</tbody>
						</table>
					</div>

					<!-- /.card-body -->
				</div>




				<!-- /.card -->

			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->
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

	<script>
	var msg = "${msgU}";

	if (msg != "") {
		alert(msg);
	}
	console.log(sessionStorage.getItem('msgU'));
	sessionStorage.removeItem('msgU');		


	
	</script>

</body>
</html>
