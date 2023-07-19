<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>서명 이미지 등록</title>
<link rel="icon" href="/img/CC_favicon.png">
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- icheck bootstrap -->
  <link rel="stylesheet" href="../../plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  
  <!-- 부트스트랩 JavaScript 파일 불러오기 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
<jsp:include page = "index.jsp"></jsp:include>
<div class="wrapper">
  <div class="content-wrapper">
    <section class="content-header">
    	<h1>서명 이미지 등록</h1>         
    </section>
    <!-- Main content -->
    <section class="content">
		<form method="post" action="signprofilechange.do" enctype="multipart/form-data">
      <table class="table table-bordered table-hover dataTable dtr-inline">
         <input type="hidden" name = "id" value="${sessionScope.id}"/>
        <tr>
            <div style="display: flex; align-items: center; justify-content: center; height: 90%; flex-direction: column;">
				  <c:choose>
				    <c:when test="${not empty member.photoName}">
				      <img src="photoView.do?path=${member.photoName}" style="max-width: 90%; max-height: 90%;" id="preview1">
				    </c:when>
				    <c:otherwise>
				      <img src="img/cc.png" style="max-width: 100%; max-height: 80%;" id="preview1">
				    </c:otherwise>
				  </c:choose>

				  <input type="file" name="signprofile" onchange="previewImage1(this)" id="fileInput" style="margin-top: 10px;">
			</div>
         </tr>

         <tr>      
            <th colspan="4" style="text-align: center;">
               <button class="btn btn-outline-dark" type="submit" id="update">완료</button>
            </th>
        </tr>
      </table>
    </form>
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

function displayFileNames(event) {
    var fileNamesDiv = document.getElementById('fileNames');

    var files = Array.from(event.target.files);
    files.forEach(function(file) {
        var fileNameDiv = document.createElement('div');
        var fileNameSpan = document.createElement('span');
        fileNameSpan.innerText = file.name;
n
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

// removeFile 값 컨트롤러로 보내기 위해서 value 값 가져오는 거! 
function removeFileEvent(icon) { // this 로 받았던 아이콘을 매개변수로 받는 함수고
    var fileNameDiv = $(icon).parent();  // 아이콘의 부모요소를 찾아내줌
    var fileNameInput = fileNameDiv.find('input[type="text"]'); // 그 중에 타입이 텍스트인 놈 찾아내줌
    var newFileName = fileNameInput.attr('value'); // value 값을 찾아주면 그게 newFileName 에 담김

    console.log(newFileName);
    fileNameDiv.remove(); // 부모요소 삭제해줌 div 삭제하면 그 안에 값들 삭제됨

    var deletedFilesInput = document.getElementById('deletedFiles'); //deletedFiles라는 id를 가진놈 가져옴 => 삭제된 파일 이름들을 저장해줌 
    var deletedFiles = deletedFilesInput.value; // value 값 가져와주고 => 삭제된 놈 이름 
    // 처리단계
    if (deletedFiles) { 
      deletedFiles += ',' + newFileName; 
    } else { // 값이 없으면 삭제될 파일 없음 -> newFileName 만 넣어줌
      deletedFiles = newFileName;
    }
    deletedFilesInput.value = deletedFiles; 
  }


	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
	
	
	function previewImage1(input) {
		  if (input.files && input.files[0]) {
		    var reader = new FileReader();
		    
		    reader.onload = function(e) {
		      $('#preview1').attr('src', e.target.result);
		    }
		    
		    reader.readAsDataURL(input.files[0]);
		  } else {
		    $('#preview1').attr('src', 'img/cc.png');
		  }
		}

</script>
</html>