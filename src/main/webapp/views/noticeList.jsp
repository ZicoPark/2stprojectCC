<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>이전 알림</title>
<link rel="icon" href="/img/CC_favicon.png">
<!-- CSS only -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<!-- Tempusdominus Bootstrap 4 -->
<link rel="stylesheet"
	href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
<!-- overlayScrollbars-->
<link rel="stylesheet"
	href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
<!-- Ionicons -->
<link rel="stylesheet"
	href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">


<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="../../plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="../../dist/css/adminlte.min.css">
</head>
<style>
.type-notice {
	color: red;
}

.type-approval {
	color: blue;
}

.type-message {
	color: green;
}
</style>
<body>
	<jsp:include page="index.jsp"></jsp:include>
	<!-- Site wrapper -->
	<div class="wrapper">
		<div class="content-wrapper">
			<section class="content-header">
				<h1>이전 알림</h1>
			</section>
			<!-- Main content -->
			<section class="content">


				<div class="container">
					<div class="card card-primary card-tabs">
						<div class="card-header p-0 pt-1">
							<ul class="nav nav-tabs " id="custom-tabs-one-tab" role="tablist">
								<li class="nav-item flex-grow-1"><a class="nav-link active"
									id="custom-tabs-one-home-tab" data-toggle="pill"
									href="#custom-tabs-one-home" role="tab"
									aria-controls="custom-tabs-one-home" aria-selected="true"
									style="text-align: center" onclick="nonReadAlarm()"><strong>안
											읽은 알림</strong></a></li>
								<li class="nav-item flex-grow-1"><a class="nav-link"
									id="custom-tabs-one-profile-tab" data-toggle="pill"
									href="#custom-tabs-one-profile" role="tab"
									aria-controls="custom-tabs-one-profile" aria-selected="false"
									style="text-align: center" onclick="readAlarm()"><strong>읽은
											알림</strong></a></li>

							</ul>
						</div>
						<div class="card-body">
							<div class="tab-content" id="custom-tabs-one-tabContent">
								<div class="tab-pane fade show active" id="custom-tabs-one-home"
									role="tabpanel" aria-labelledby="custom-tabs-one-home-tab">
									<div class="card-body p-0">
										<table class="table table-striped">
											<thead>
												<tr>
													<th style="text-align: center">분류</th>
													<th style="text-align: center">알림 제목</th>
													<th style="text-align: center">발신인</th>
													<th style="text-align: center">날짜</th>
												</tr>
											</thead>
											<tbody id="nonRead">

											</tbody>
										</table>
									</div>
								</div>

								<div class="tab-pane fade" id="custom-tabs-one-profile"
									role="tabpanel" aria-labelledby="custom-tabs-one-profile-tab">
									<div class="card-body p-0">
										<table class="table table-striped">
											<thead>
												<tr>
													<th style="text-align: center">분류</th>
													<th style="text-align: center">알림 제목</th>
													<th style="text-align: center">발신인</th>
													<th style="text-align: center">날짜</th>
												</tr>
											</thead>
											<tbody id="read">

											</tbody>
										</table>
									</div>
								</div>

							</div>
						</div>
						<!-- /.card -->
					</div>


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


</body>
<script>
	nonReadAlarm(); // 시작했을때 기본으로 띄워줄 거

	function nonReadAlarm() {
		console.log('nonReadAlarm() 호출');
		$.ajax({
					url : 'nonReadAlarm.ajax',
					type : 'post',
					async : false,
					data : {
						loginId : '${sessionScope.id}'
					},
					dataType : 'json',
					success : function(data) {
						console.log('아작스 통신 성공');
						console.log(data);
						var content = '';
						if (data.length == 0) {
							content += '<tr><th colspan="5" style="text-align:center">안 읽은 알림이 없습니다.</th></tr>'
						} else {
							data
									.forEach(function(item) {
										content += '<tr><td style="text-align:center">';
										if (item.type == '공지사항') {
											console.log('공지사항 if문 진입');
											content += '<span class="type-notice">'
													+ item.type
													+ '</span></td><td style="text-align:center">';
											content += '<a href="noticeBoardDetail.do?type=alarm&id='
													+ item.identify_value
													+ '">'
													+ item.subject
													+ '</a>';
										} else if (item.type == '전자결재') {
											console.log('전자결재 if문 진입');
											content += '<span class="type-approval">'
													+ item.type
													+ '</span></td><td style="text-align:center">';
											content += '<a href="requestDocWaitDetail.go?type=alarm&id='
													+ item.identify_value
													+ '">'
													+ item.doc_subject
													+ '</a>';
										} else if (item.type == '쪽지') {
											console.log('쪽지 if문 진입');
											content += '<span class="type-message">'
													+ item.type
													+ '</span></td><td style="text-align:center">';
											content += '<a href="msRcDetail.do?type=alarm&id='
													+ item.identify_value
													+ '">'
													+ item.title
													+ '</a>';
										}
										content += '</td>';
										content += '<td style="text-align:center">'
												+ item.name
												+ '('
												+ item.user_id + ')</td>';
										content += '<td style="text-align:center">'
												+ item.create_at.substring(0,
														10) + '</td>';
										content += '</tr>';
									});
						}

						$('#nonRead').empty();
						$('#nonRead').append(content);
					},
					error : function(e) {
						console.log(e);
					}
				});
		console.log('아작스 다음');
	}

	function readAlarm() {
		console.log('ReadAlarm() 호출');
		$.ajax({
					url : 'readAlarm.ajax',
					type : 'post',
					async : false,
					data : {
						loginId : '${sessionScope.id}'
					},
					dataType : 'json',
					success : function(data) {
						console.log(data);
						console.log('createChatroom.ajax () 성공');
						var content = '';
						if (data.length == 0) {
							content += '<tr><th colspan="5" style="text-align:center">읽은 알림이 없습니다.</th></tr>'
						} else {
							data
									.forEach(function(item) {
										content += '<tr><td style="text-align:center">';
										if (item.type == '공지사항') {
											content += '<span class="type-notice">'
													+ item.type
													+ '</span></td><td style="text-align:center">';
											content += '<a href="noticeBoardDetail.do?type=alarm&id='
													+ item.identify_value
													+ '">'
													+ item.subject
													+ '</a>';
										} else if (item.type == '전자결재') {
											content += '<span class="type-approval">'
													+ item.type
													+ '</span></td><td style="text-align:center">';
											content += '<a href="requestDocWaitDetail.go?id='
													+ item.identify_value
													+ '">'
													+ item.doc_subject
													+ '</a>';
										} else if (item.type == '쪽지') {
											content += '<span class="type-message">'
													+ item.type
													+ '</span></td><td style="text-align:center">';
											content += '<a href="msRcDetail.do?id='
													+ item.identify_value
													+ '">'
													+ item.title
													+ '</a>';
										}
										content += '</td>';
										content += '<td style="text-align:center">'
												+ item.name
												+ '('
												+ item.user_id + ')</td>';
										content += '<td style="text-align:center">'
												+ item.create_at.substring(0,
														10) + '</td>';
										content += '</tr>';
									});
						}
						$('#read').empty();
						$('#read').append(content);
					},
					error : function(e) {
						console.log(e);
					}
				});
	}
</script>
</html>





