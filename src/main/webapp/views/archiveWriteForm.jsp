<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>자료실 작성</title>
<link rel="icon" href="/img/CC_favicon.png">
<link rel="stylesheet" href="/richtexteditor/rte_theme_default.css" />
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>

<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="../../dist/css/adminlte.min.css">
<style>
</style>
</head>
<body>
	<jsp:include page="./index.jsp"/>
	<!-- Site wrapper -->
	<div class="wrapper">
		<div class="content-wrapper">
			<section class="content-header">
				<h1>자료실 게시글 작성</h1>
			</section>
			<!-- Main content -->
			<section class="content">
				<form action="archiveWrite.do" method="post" enctype="multipart/form-data">


                  <button type="button" onclick="pushContent()" class="btn btn-primary float-right"><i class="far fa-envelope"></i> 작성</button>
	

					<br>
					<div class="row">
						<div class="col-6">
	                <input type="text" name="member_id" value="${loginId}" readonly="readonly" hidden="true" required/>
				
					<input type="radio" name="category" value="업무자료"/>업무자료
					<input type="radio" name="category" value="문서양식"/>문서양식
				
						</div>

						<div class="col-12">
							<br>
							<input class="form-control" id="subject" name="subject" maxlength="19" onkeyup="counter(event, '20')" placeholder="제목을 입력하세요">
		          
						</div>
					</div>

					<br>
					<div id="div_editor">
					
					</div>
					<textarea hidden="true" id="content" name="content"></textarea>

					<br>
					<div class="custom-file">
						<input type="file" multiple="multiple" id="attachment" name="attachment" class="custom-file-input"/>
						<label class="custom-file-label" for="attachment">
						첨부파일을 선택하세요.
						</label>
					</div>
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
var config = {}; // 설정
config.editorResizeMode = "none"; // 에디터 크기조절 none

var editor = new RichTextEditor("#div_editor", config);


function pushContent(){
	
	var submitContent = editor.getHTMLCode();
	$('textarea[name="content"]').val(submitContent);

	if($('#subject').val().length==0){
		alert('제목을 입력해주세요.');
	}else{
		$('form').submit();
	}
	
}

$(function () {
	bsCustomFileInput.init();
});
  

  
  function counter(event, limit){
	    var val = event.target.value.length;
	    var elem = $(event.target).siblings().find('span');
	    console.log(val);
	    console.log(limit);
	    console.log(elem);
	    if(val <= limit){
	      elem.html(val + " / " + limit);
	      if (val >= 17) {
	        elem.css('color', 'red');
	      } else {
	        elem.css('color', ''); // 기본 색상으로 변경 (CSS 스타일 제거)
	      }
	    }
	  }
	  
	  // 글자 수 실시간 업데이트
	  var titleInput = document.querySelector('input[name="title"]');
	  var countSpan = document.getElementById('reCount');
	  
	  titleInput.addEventListener('input', function() {
	    var count = this.value.length;
	    countSpan.innerText = count + ' / 20';
	    
	    if (count >= 20) {
	      countSpan.style.color = 'red';
	    } else {
	      countSpan.style.color = ''; // 기본 색상으로 변경 (CSS 스타일 제거)
	    }
	  });




</script>
</html>