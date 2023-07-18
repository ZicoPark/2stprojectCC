<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>AdminLTE 3 | Compose Message</title>
<link rel="icon" href="/img/CC_favicon.png">
  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <!-- summernote -->
  <link rel="stylesheet" href="../../plugins/summernote/summernote-bs4.min.css">
</head>
<body class="hold-transition sidebar-mini">
<jsp:include page = "index.jsp"></jsp:include>
<div class="wrapper">
  <!-- Navbar -->
  

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->

<form action="freeUpdate.do" method="post" enctype="multipart/form-data">
    <!-- Main content -->


                <input type="text" name="member_id" value="${sessionScope.id}" readonly="readonly" hidden="true" required/>
				<input type="text" name="id" value="${detailms.id}" readonly="readonly" hidden="true" required/>
				문서번호 ${detailms.id}
			
                <div>
                  <input class="form-control" name="subject" maxlength="19" onkeyup="counter(event, '20')" value=${detailms.subject }/>
                  <span id="reCount">0 / 20</span>
                </div>
                <div class="form-group" name="content">
                    <textarea id="compose-textarea" style="height: 300px" name="content">
                      ${detailms.content}
                    </textarea>
                </div>
                

				<label for="fileInput" class="file-input-label">
				    <i class="fas fa-paperclip"></i> 파일 첨부
				</label>
				<!--  파일 선택 버튼 숨겼음 !! 왜냐면 file 요소 떄문에 원래 있던 애들 사라짐 -->
				<input type="file" name="attachment" multiple="multiple" onchange="displayFileNames(event)" id="fileInput" style="display: none;">
				
				<div id="fileNames">
				    <c:if test="${detailfile.size() > 0 }">
				        <c:forEach items="${detailfile}" var="i">
				            <div>
				            	<input type="text" name="removeFile" value="${i.id}" hidden="true"/>${i.ori_file_name}
				                
				                <i class="fas fa-times cancel-icon" onclick="removeFileEvent(this)"></i>
				            </div>
				        </c:forEach>
				    </c:if>
				</div>
								
				<input type="text" name="deletedFiles" id="deletedFiles">

              <!-- /.card-body -->
              <div class="card-footer">
                <div class="float-right">

                  <button type="submit" class="btn btn-primary"><i class="far fa-envelope"></i> Send</button>
                </div>
  
              <!-- /.card-footer -->
            </div>
            <!-- /.card -->

  </form>
</div>
</div>
    <!-- /.content -->

 

<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<!-- Summernote -->
<script src="../../plugins/summernote/summernote-bs4.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>
<!-- Page specific script -->
<script>
  $(function () {
    //Add text editor
    $('#compose-textarea').summernote()
  })
  
  
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

</script>

</body>
</html>
