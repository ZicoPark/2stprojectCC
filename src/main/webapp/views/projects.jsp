<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>CreatorCompany</title>

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
								<li class="breadcrumb-item"><a href="#">Home</a></li>
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
					<div class="card-header">
						<h3 class="card-title">Projects</h3>

						<div class="card-tools">
							<button type="button" class="btn btn-tool"
								data-card-widget="collapse" title="Collapse">
								<i class="fas fa-minus"></i>
							</button>
							<button type="button" class="btn btn-tool"
								data-card-widget="remove" title="Remove">
								<i class="fas fa-times"></i>
							</button>

							<a href="project-add.go" class="btn btn-sm btn-primary">추가</a>



						</div>
					</div>
					<div class="card-body p-0">
						<table class="table table-striped projects">
							<thead>
								<tr>
									<th style="width: 1%">#</th>
									<th style="width: 20%">Project Name</th>
									<th style="width: 30%">Team Members</th>
									<th>Project Progress</th>
									<th style="width: 8%" class="text-center">Status</th>
									<th style="width: 20%"></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${list}" var="project">
									<tr>
										<td>#</td>
										<td><a> ${project.name} </a> <br /> <small>
												${project.start_date} </small></td>
										<td>
											<ul class="list-inline">
												<c:forEach items="${project.contributors}" var="contributor">
													<li class="list-inline-item"><img alt="Avatar"
														class="table-avatar" src="../../dist/img/avatar.png">
														${contributor}</li>
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
											href="projectDetail.go?id=${project.project_id}"
											class="btn btn-primary btn-sm view-btn"> <i
												class="fas fa-folder"> </i> 상세보기
										</a>                            
										<a class="btn btn-info btn-sm" href="#">
                              				<i class="fas fa-pencil-alt"></i>
                             					 Edit
                         				</a>
                          				<a class="btn btn-danger btn-sm" href="#">
                              				<i class="fas fa-trash">
                              			</i>
                              					Delete
                          				</a> 
                          				</td>
									</tr>
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

</script>

</body>
</html>
