<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>CreatorCompany</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
</head>
<body class="hold-transition sidebar-mini">
<jsp:include page = "index.jsp"></jsp:include>
<!-- Site wrapper -->
<div class="wrapper">


  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>프로젝트 상세</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Project Detail</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">

      <!-- Default box -->
      <div class="card">
        <div class="card-header">
          <h3 class="card-title">Projects Detail</h3>

          <div class="card-tools">
           <a href="projectInsert.go?id=${project_id}" class="btn btn-sm btn-primary">추가</a>
           <a href="projectDel.do?id=${project_id}" class="btn btn-danger btn-sm">철회</a>
                          				
            <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
              <i class="fas fa-minus"></i>
            </button>
            <button type="button" class="btn btn-tool" data-card-widget="remove" title="Remove">
              <i class="fas fa-times"></i>
            </button>

          </div>
        </div>

        <div class="card-body">
          <div id="projectDetailContainer"></div>
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
$(document).ready(function() {
	  console.log("함수 실행");

	  var projectId = "${project_id}";

	  $.ajax({
	    url: "projectDetail.ajax?id=" + projectId, // 서버에서 데이터를 가져올 URL
	    method: "GET",
	    dataType: "json",
	    success: function(data) {
	      var container = $("#projectDetailContainer");
	      var commentListContainer = $(".commentListContainer"); // 댓글 목록을 표시하는 영역의 컨테이너

	      $.each(data.commentList, function(index, detail) {
	        var commentList = data.commentList; // detailfile 값 가져오기
	        var commentId = detail.comment_id;
	        console.log('commentList : ' + commentList);
	        console.log('commentId : ' + commentId);

	        var html = '<div class="row">';
	        html += '<div class="col-12 col-md-12 col-lg-8 order-2 order-md-1">';
	        html += '<div class="row">';
	        html += '<div class="col-12">';
	        html += '<span style="border: 1px solid green; border-radius: 5px; padding: 3px;">' + detail.step + '</span>';
	        html += '<span style="border: 1px solid red; border-radius: 5px; padding: 3px;">' + detail.status + '</span>';
	        html += '<div class="post">';
	        html += '<div class="user-block">';
	        html += '<img class="img-circle img-bordered-sm" src="../../dist/img/user1-128x128.jpg" alt="user image">';
	        html += '<span class="username">';
	        html += '<a href="#">' + detail.member_id + '</a>';
	        html += '</span>';
	        html += '<span class="description">' + detail.create_at + '</span>';
	        html += '</div>';
	        html += '<p>' + detail.content + '</p>';
	        if (detail.attachment_id != null) {
	          html += '<p><a href="attachmentDownload.do?id=' + detail.attachment_id + '">' + detail.ori_file_name + '</a></p>';
	        }

	        html += '</div>';

	        var commentForm = '<div class="commentForm">';
	        commentForm += '<input type="text" class="commentInput" placeholder="댓글 작성">';
	        commentForm += '<input type="hidden" value="' + detail.comment_id + '">';
	        commentForm += '<button class="commentButton">작성</button>';
	        commentForm += '</div>';

	        html += commentForm;
	        

	        html += '</div></div></div>';

	        container.prepend(html);
	        
	      });
	      container.on('click', '.commentButton', function() {
	        var commentId = $(this).siblings('input[type="hidden"]').val(); // 작성된 댓글 내용 가져오기
	        console.log('commentId : ' + commentId);

	        var replyContent = $(this).siblings('input[type="text"]').val();
	        console.log('replyContent : ' + replyContent);

	        var commentInput = $(this).prevAll('.commentInput').first();

	        console.log('id : ' + commentId);
	        // 서버로 댓글 전송하는 Ajax 요청
	        $.ajax({
	          url: "postComment.ajax", // 댓글 작성 요청을 처리하는 서버 URL
	          method: "POST",
	          dataType: "json",
	          data: {
	            id: commentId, // 해당 코멘트의 고유번호
	            content: replyContent
	          },
	          success: function(response) {
	            alert("댓글을 작성했습니다.");
	            // 서버에서 댓글 작성 결과를 받았을 때의 처리 로직
	            if (response.success) {
	              // 댓글 작성 성공한 경우
	              var newComment = {
	                id: response.id, // 서버에서 반환한 새로운 댓글의 고유번호
	                comment_id: commentId,
	                member_id: response.member_id, // 실제 데이터를 가져와야 함
	                content: response.content,
	                create_at: response.create_at
	              };

	              var newCommentHtml = createCommentHtml(newComment); // 새로운 댓글 HTML 생성 함수 (예시용으로 임의로 작성)
	              commentListContainer.prepend(newCommentHtml); // 새로운 댓글을 목록의 맨 위에 추가

	              commentInput.val(''); // 댓글 입력 필드 초기화
	            } else {
	              // 댓글 작성 실패한 경우
	              alert("댓글 작성에 실패했습니다.");
	            }
	          },
	          error: function(xhr, status, error) {
	            console.log(error);
	          }
	        });
	      });
	    },
	    error: function(xhr, status, error) {
	      console.log(error);
	    }
	  });
	});


	function createCommentHtml(comment) {
	  var html = '<div class="comment">';
	  html += '<span class="comment-id">' + comment.id + '</span>';
	  html += '<span class="comment-member">' + comment.member_id + '</span>';
	  html += '<span class="comment-content">' + comment.content + '</span>';
	  html += '<span class="comment-date">' + comment.create_at + '</span>';
	  html += '</div>';
	  return html;
	}



</script>
</body>
</html>
