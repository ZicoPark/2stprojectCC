<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>AdminLTE 3 | 메시지 작성</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- 테마 스타일 -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <!-- summernote -->
  <link rel="stylesheet" href="../../plugins/summernote/summernote-bs4.min.css">
</head>
<body class="hold-transition sidebar-mini">
<jsp:include page="index.jsp"></jsp:include>
<div class="wrapper">
  <!-- Navbar -->
  

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>사내게시판 작성</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">홈</a></li>
              <li class="breadcrumb-item active">사내게시판 작성</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>
<form action="freeWrite.do" method="post" enctype="multipart/form-data">
    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
 
          <div class="col-md-9">
            <div class="card card-primary card-outline">
              <div class="card-header">
                <h3 class="card-title">새 메시지 작성</h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <div class="form-group">
                <input type="text" name="member_id" value="${loginId}" readonly="readonly" hidden="true" required/>

			
                <div class="form-group">
                   <input class="form-control" id="subjectInput" name="subject" maxlength="19" onkeyup="counter(event, '20')" placeholder="제목을 입력하세요">
                   <span id="reCount">0 / 20</span>
                </div>
                <div class="form-group" name="content">
                    <textarea id="compose-textarea" class="form-control" style="height: 300px" name="content">
                      
                    </textarea>
                </div>
                

			    <i class="fas fa-paperclip"></i>
				<input type="file" name="attachment" multiple="multiple" id="formFileMultiple">
				
				<div id="fileNames">
				    <c:if test="${detailFile.size() > 0 }">
				        <c:forEach items="${detailFile}" var="i">
				            <div>
				            	<input type="text" name="removeFile" value="${i.id}" hidden="true"/>${i.oriFileName}
				                
				                <i class="fas fa-times cancel-icon" onclick="removeFileEvent(this)"></i>
				            </div>
				        </c:forEach>
				    </c:if>
				</div>



              <!-- /.card-body -->
              <div class="card-footer">
                <div class="float-right">

                  <button type="submit" class="btn btn-primary"><i class="far fa-envelope"></i> 전송</button>
                </div>
  
              <!-- /.card-footer -->
            </div>
            <!-- /.card -->
          </div>
          <!-- /.col -->
        </div>
        <!-- /.row -->
      </div><!-- /.container-fluid -->
      </div>
      </div>
      </div>
    </section>
    <!-- /.content -->
  </form>
  </div>
  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <div class="float-right d-none d-sm-block">
      <b>버전</b> 3.2.0
    </div>
    <strong>저작권 &copy; 2014-2021 <a href="https://adminlte.io">AdminLTE.io</a>.</strong> All rights reserved.
  </footer>

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
<!-- Summernote -->
<script src="../../plugins/summernote/summernote-bs4.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>
<!-- Page specific script -->
<script>
$(function () {
    // 텍스트 편집기 추가
    $('#compose-textarea').summernote()
    
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
