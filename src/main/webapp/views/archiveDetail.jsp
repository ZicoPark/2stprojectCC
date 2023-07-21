<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>자료실 상세보기</title>

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
	<div class="wrapper">

		<div class="content-wrapper">
			<!-- Content Header (Page header) -->

			<section class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<h1>자료실</h1>
							<ol class="breadcrumb float-sm-right">
							</ol>

					</div>
				</div>
				<!-- /.container-fluid -->
			</section>

			<div class="wrapper" style="margin: 0 20px;">
				<!-- Main content -->
				<section class="content">
					<div class="container-fluid">
						<div class="row">

					<div class="col-md-9" style="margin: 0 auto;">
								<div class="card card-primary card-outline"
									style="border-top: 3px solid #20c997 !important; margin: 0 10px;">
		
								<div class="card-header">
									${detailms.category} <span
										class="mailbox-read-time float-right"> 작성자
										${detailms.name} ( ${detailms.user_id } )
										${detailms.dept_name} <br>
									</span>
								</div>
								<!-- /.card-header -->
								<div class="card-body p-0">
									<div class="mailbox-read-info">
										<h3 style="font-weight: bold; font-size: 30px; color: black;">${detailms.subject}</h3>

										<div class="mailbox-read-time">작성일 &nbsp
											${detailms.create_at} &nbsp &nbsp 조회수 &nbsp ${detailms.hit}</div>

									</div>

								</div>
								<!-- /.mailbox-controls -->
					

								<div class="mailbox-read-message"
									style="height: 410px; margin-top: 30px; margin-left: 30px;">
									<p>${detailms.content}</p>
								</div>
								<!-- /.mailbox-read-message -->
								<div class="card-footer">
									<ul
										class="mailbox-attachments d-flex align-items-stretch clearfix">
										<c:if test="${detailFile.size() == 0 }">
											<div></div>
										</c:if>
										<c:if test="${detailFile.size() > 0 }">
											<c:forEach items="${detailFile}" var="i">
										
													<a class="mailbox-attachment-name"><i
														class="fas fa-paperclip"></i> &nbsp ${i.ori_file_name}</a>
													&nbsp &nbsp <a href="msdownload.do?path=${i.id}"
														class="btn btn-default btn-sm float-right"><i
														class="fas fa-cloud-download-alt"></i></a>



											</c:forEach>
										</c:if>
									</ul>

									<div class="float-right">
										<c:if
											test="${loginid.admin_chk eq 1 or loginId eq detailms.member_id}">
											<button type="button"
												onclick="location.href='/archivedelete.do?id=${detailms.id}'"
												class="btn btn-default">
												<i class="far fa-trash-alt"></i>
											</button>
										</c:if>
										<c:if test="${loginId eq detailms.member_id}">
											<button type="button"
												onclick="location.href='/archiveUpdate.go?id=${detailms.id}&member_id=${detailms.member_id}'"
												class="btn btn-default">수정</button>
										</c:if>
										<button type="button"
											onclick="location.href='/archiveBoard.go'"
											class="btn btn-default">목록</button>
									</div>

								</div>
							</div>
							</div>
		
							<!-- /.card-body -->

							<!-- /.card-footer -->
						</div>
						<!-- /.card -->
					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</section>
		</div>
		<!-- /.container-fluid -->

	</div>

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