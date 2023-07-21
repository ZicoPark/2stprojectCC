<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>공지사항 작성</title>
<link rel="icon" href="/img/CC_favicon.png">
<link rel="stylesheet" href="/richtexteditor/rte_theme_default.css" />
<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<link rel="stylesheet"
	href="../../plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="../../dist/css/adminlte.min.css">
<style>
</style>
</head>
<body>
	<jsp:include page="index.jsp"></jsp:include>
	<!-- Site wrapper -->
	<div class="wrapper">
		<div class="content-wrapper">
			<section class="content-header">
				<h1>공지사항 작성</h1>
			</section>
			<!-- Main content -->
			<section class="content" >
				<form action="noticeBoardWrite.do" method="post"
					enctype="multipart/form-data">

					<br>
					<div class="row">
						<div class="col-6">
							<input type="text" name="member_id" value="${loginId}"
								readonly="readonly" hidden="true" required />

						</div>

						<div class="col-12">
							<br> <input class="form-control" id="subject" name="subject" placeholder="제목을 입력하세요" >
						</div>
					</div>

					<br>
					<div id="div_editor">
						
					</div>
					<textarea hidden="true" id="content" name="content"></textarea>

					<br>
					<div class="custom-file">
						<td><input type="file" name="file" multiple="multiple" /></td>
					</div>


					<button type="button" onclick="pushContent()"
						class="btn btn-primary float-right">
						<i class="far fa-envelope"></i> 작성
					</button>

				</form>
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
<!-- bs-custom-file-input -->
<script src="../../plugins/bs-custom-file-input/bs-custom-file-input.min.js"></script>

<script type="text/javascript" src="/richtexteditor/rte.js"></script>  
<script type="text/javascript" src='/richtexteditor/plugins/all_plugins.js'></script>
<script>
	console.log(socket);
	var config = {}; // 설정
	config.editorResizeMode = "none"; // 에디터 크기조절 none

	var editor = new RichTextEditor("#div_editor", config);
	var overlayChk = true;
	
	function pushContent() {

		var submitContent = editor.getHTMLCode();
		$('textarea[name="content"]').val(submitContent);
			$('form').submit();


	}
	function nbWrite() {
		if (overlayChk == true) {
			if ($('#subject').val() == '') {
				alert('제목을 입력해주세요!');
				$('#subject').focus();
			} else if ($('#content').val() == '') {
				alert('내용을 입력해주세요!');
				$('#content').focus();
			} else {
				$('button').attr('type', 'submit');
			}
		}
	}


</script>
</html>






