<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
<title>사내게시판 작성</title>
<link rel="icon" href="/img/CC_favicon.png">
<link rel="stylesheet" href="/richtexteditor/rte_theme_default.css" />
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>

<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="../../dist/css/adminlte.min.css">
</head>
<body>
<jsp:include page="index.jsp"></jsp:include>
	<div class="wrapper">
		<div class="content-wrapper">
    <section class="content-header">
    <h1>게시글 작성</h1>
	</section>
    <section class="content">
		<form action="freeWrite.do" method="post" enctype="multipart/form-data">
      	<button type="button" onclick="pushContent()" class="btn btn-primary float-right"><i class="far fa-envelope"></i> 작성</button>
        
       	<br>
		<div class="row">
			<div class="col-6">
              <input type="text" name="member_id" value="${loginId}" readonly="readonly" hidden="true" required/>
			</div>
	
				<div class="col-12">
					<br>
					<input class="form-control" name="subject" id="subject" value="" maxlength="19" onkeyup="counter(event, '20')" placeholder="제목을 입력하세요">
                 	<span id="reCount">0 / 20</span>
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

    // 제목 입력란에 이벤트 리스너 추가
    $('#subjectInput').on('input', function () {
      var count = this.value.length;
      var countSpan = $('#reCount');
      
      countSpan.text(count + ' / 20');
      
      if (count >= 20) {
        countSpan.css('color', 'red');
      } else {
        countSpan.css('color', ''); // 색상 초기화 (CSS 스타일 제거)
      }
    });


// 첨부파일 목록 보여주고 안 보여주고 
function displayFileNames(event) {
    var fileNamesDiv = document.getElementById('fileNames');

    var files = Array.from(event.target.files);
    files.forEach(function(file) {
        var fileNameDiv = document.createElement('div');
        var fileNameSpan = document.createElement('span');
        fileNameSpan.innerText = file.name;

        var cancelIcon = document.createElement('i');
        cancelIcon.className = 'fas fa-times cancel-icon';
        cancelIcon.addEventListener('click', function() {
            removeFile(this);
        });

        fileNameDiv.appendChild(fileNameSpan);
        fileNameDiv.appendChild(cancelIcon);
        fileNamesDiv.appendChild(fileNameDiv);
    });
}


function removeFileEvent(icon) {
    var fileNameDiv = $(icon).parent(); 
    var fileNameInput = fileNameDiv.find('input[type="text"]'); 
    var newFileName = fileNameInput.attr('value'); 

    fileNameDiv.remove();

	console.log(newFileName);
}



</script>

</body>
</html>
