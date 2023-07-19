<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>회원 정보 수정</title>
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
    	<h1>마이 페이지 수정</h1>         
    </section>
    <!-- Main content -->
    <section class="content">
		<form method="post" action="userinfoupdate.do" enctype="multipart/form-data">
      <table class="table table-bordered table-hover dataTable dtr-inline">
         <tr> 
         	<th rowspan="10" style="width: 500px;">
				<div style="display: flex; align-items: center; justify-content: center; height: 100%; flex-direction: column;">
				  <c:choose>
				    <c:when test="${not empty member.photoName}">
				      <img src="photoView.do?path=${member.photoName}" style="max-width: 100%; max-height: 100%;" id="preview">
				    </c:when>
				    <c:otherwise>
				      <img src="img/cc.png" style="max-width: 100%; max-height: 100%;" id="preview">
				    </c:otherwise>
				  </c:choose>
				  <input type="hidden" name="deletedFiles" id="deletedFiles">
				  <input type="file" name="file" onchange="previewImage(this)" id="fileInput" style="margin-top: 10px;">
				</div>
			</th>
         </tr>
         <tr>
            <th>아이디</th>
            <td>
               <input type="hidden" name = "id" value="${member.id }"/>
               
               ${member.user_id}                
            </td>
         </tr>
         <tr>
            <th>비밀번호</th>
            <td>
               ********                             
            </td>
         </tr>
         <tr>
            <th>이름</th>
            <td>
               <input type="text" name="name" id="name" value="${member.name}" />               
            </td>            
         </tr>
         <tr>
            <th>생년월일</th>               
            <td>${member.birth_at}</td>
         </tr>
         <tr>
            <th>입사일</th>               
            <td>${member.hire_at}</td>
         </tr>     
         <tr>
            <th>직급</th>
            <td>
			<select name="job_level_id" id="job_level_id">
				<option value="8ade9167-1703-11ee-973f-0242ac110002">팀원</option>
				<option value="8bbf948d-1703-11ee-973f-0242ac110002">팀장</option>
				<option value="8c4e7542-1703-11ee-973f-0242ac110002">이사</option>
				<option value="8cdd8503-1703-11ee-973f-0242ac110002">사장</option>
			</select>
	   	   </td>
         </tr>
         <tr>
            <th>부서</th>
            <td>
				<select name="dept_id" id="dept_id">
		          	<option value="8e5f3282-1703-11ee-973f-0242ac110002">총무팀</option>
				  	<option value="8ee07433-1703-11ee-973f-0242ac110002">기획팀</option>
				  	<option value="8f963853-1703-11ee-973f-0242ac110002">촬영팀</option>
				  	<option value="9022f64a-1703-11ee-973f-0242ac110002">편집팀</option>
      	    	</select>
			</td>
         </tr>
         <tr>
            <th>이메일</th>
            <td><input type="email" name="email" id="email" value="${member.email}" /></td>
         </tr>
         <tr>
            <th>연락처</th>
            <td><input type="text" name="phone" id="phone" value="${member.phone}" /></td>
         </tr>
         <tr>      
            <th colspan="11" style="text-align: center;">
               <button class="btn btn-outline-dark" type="submit" id="update">완료</button>
            </th>
        </tr>
      </table>
    </form>
    </section>
  </div>
</div>

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
	
	function previewImage(input) {
		  if (input.files && input.files[0]) {
		    var reader = new FileReader();
		    
		    reader.onload = function(e) {
		      $('#preview').attr('src', e.target.result);
		    }
		    
		    reader.readAsDataURL(input.files[0]);
		  } else {
		    $('#preview').attr('src', 'img/cc.png');
		  }
		}
</script>
</html>