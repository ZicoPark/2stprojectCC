<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>프로젝트 상세보기</title>
<link rel="icon" href="/img/CC_favicon.png">
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
  <div class="content-wrapper" style="max-width: 1000px; margin: 0 auto;">
    <!-- Content Header (Page header) -->
    <section class="content-header"  style=" background-color: #20c997;">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 style="color: white; font-weight: bold;">프로젝트 상세</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">프로젝트 > 프로젝트 상세보기</li>
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

          <div class="card-tools">
          
          <%
			    int del_chk = (Integer) request.getAttribute("del_chk");
			%>
          
           <% if (del_chk == 0) { %>
		        <a href="projectInsert.go?id=${project_id}" class="btn btn-sm btn-primary"><i class="fas fa-edit"></i> 추가</a>
		        <a href="projectDel.do?id=${project_id}" class="btn btn-danger btn-sm"> 철회</a>
		    <% } else if (del_chk == 1) { %>
		   		 <a href="projectRes.do?id=${project_id}" class="btn btn-sm btn-success restore-btn"><i class="fas fa-undo"></i> 복구</a>
		    <% } %>
                          				
            <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
              <i class="fas fa-minus"></i>
            </button>
          </div>
        </div>

        <div class="card-body" >
          <div id="projectDetailContainer" ></div>
        </div>
        <!-- /.card-body -->
      </div>
      <!-- /.card -->

    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

<input type="hidden" id="loginId" value="${sessionScope.id }">

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

<script>
var loginId = $("#loginId").val();
console.log('id:'+loginId);

$(document).ready(function() {
	  console.log("함수 실행");

	  var projectId = "${project_id}";
	  detailAjax();

	  function detailAjax() {
	    console.log('detailAjax() 호출');
	    $.ajax({
	      url: "projectDetail.ajax?id=" + projectId, // 서버에서 데이터를 가져올 URL
	      method: "GET",
	      async : false,
	      dataType: "json",
	      success: function(data) {
	        var container = $("#projectDetailContainer");

	        $.each(data.commentList, function(index, detail) {
	          var commentId = detail.comment_id;

	          var html = '<div class="row" style="margin-bottom: 20px;">';
	          html += '<div class="col-12 order-2 order-md-1">';
	          html += '<div class="row" style="background-color: #f0f0f0; ">';
	          html += '<div class="col-12">';
	          html += '<span style="border: 1px solid green; border-radius: 5px; padding: 3px;">' + detail.step + '</span>';
	          html += '<span style="border: 1px solid red; border-radius: 5px; padding: 3px;">' + detail.status + '</span>';
	          html += '<div class="post">';
	          html += '<div class="user-block">';
	          
	          if(detail.member_profile_attachment_id == null){
	        	  html += '<img class="img-circle img-bordered-sm" src="/img/CC.png" alt="user image">'; 
	          }else{
	        	  html += '<img class="img-circle img-bordered-sm" src="photoView.do?path='+detail.member_profile_attachment_id+'" alt="user image">';
	          }
	          
	          html += '<span class="username">';
	          html += '<a href="#">' + detail.name + '</a>';
	          html += '</span>';
	          html += '<span class="description">' + detail.create_at + '</span>';
	          html += '</div>';
	          html += '<p>' + detail.content + '</p>';
	          if (detail.comment_attachment_id != null) {
	        	    if (detail.comment_ori_file_name.endsWith('.mp4') || detail.comment_ori_file_name.endsWith('.avi') || detail.comment_ori_file_name.endsWith('.mov')) {
	        	        // 비디오 파일인 경우
	        	        html += '<div class="mailbox-attachment-info">';
	        	        html += '<video controls width="320" height="240">';
	        	        html += '<source src="attachmentDownload.do?id=' + detail.comment_attachment_id + '" type="video/mp4">';
	        	        html += '브라우저가 비디오를 지원하지 않습니다.';
	        	        html += '</video>';
	        	        html += '<a class="mailbox-attachment-name"><i class="fas fa-paperclip"></i> &nbsp;' + detail.comment_ori_file_name + '</a>';
	        	        html += '<a href="attachmentDownload.do?id=' + detail.comment_attachment_id + '" class="btn btn-default btn-sm"><i class="fas fa-cloud-download-alt"></i></a>';
	        	        html += '</div>';
	        	    } else if (detail.comment_ori_file_name.endsWith('.jpg') || detail.comment_ori_file_name.endsWith('.png') || detail.comment_ori_file_name.endsWith('.gif')) {
	        	        // 사진(이미지) 파일인 경우
	        	        html += '<div class="mailbox-attachment-info">';
	        	        html += '<img src="attachmentDownload.do?id=' + detail.comment_attachment_id + '" alt="' + detail.comment_ori_file_name + '" class="img-thumbnail">';
	        	        html += '<a class="mailbox-attachment-name"><i class="fas fa-paperclip"></i> &nbsp;' + detail.comment_ori_file_name + '</a>';
	        	        html += '<a href="attachmentDownload.do?id=' + detail.comment_attachment_id + '" class="btn btn-default btn-sm"><i class="fas fa-cloud-download-alt"></i></a>';
	        	        html += '</div>';
	        	    }
	        	}
	        	html += '</div>';


	          var commentForm = '<div class="commentForm'+ detail.comment_id+'" style="background-color: #dcdcdc;">';
	          commentForm += '<input type="text" class="commentInput" placeholder="댓글 작성">';
	          commentForm += '<input type="hidden" value="' + detail.comment_id + '">';
	          commentForm += '<button class="commentButton btn btn-primary btn-sm view-btn" id="' + detail.comment_id + '"><i class="far fa-envelope"></i>작성</button>';
	          commentForm += '<div class="commentReply'+detail.comment_id+'"></div>';
	          commentForm += '</div>';
	          commentForm += '<hr>';

	          html += commentForm;
	          
	          
	          
	          html += '</div></div></div>';

	          container.prepend(html);
	          getComments(detail.comment_id);
	        });

	        // 댓글 목록을 표시하는 영역의 컨테이너 찾기
	        var commentListContainer = $(".commentList");

	        // 댓글 작성 후 댓글 목록을 가져오는 함수 호출
	        

	      },
	      error: function(xhr, status, error) {
	        console.log(error);
	      }
	    });
	  }

	  $(document).on('click', '.commentButton', function() {
	    var commentId = $(this).attr('id'); // 작성된 댓글 내용 가져오기
	    var replyContent = $(this).siblings('input[type="text"]').val();
	    var commentInput = $(this).prevAll('.commentInput').first();

	    console.log('commentId : ' + $(this).attr('id'));

	 	// 댓글 내용이 비어있는지 확인
	    if (replyContent.trim() === '') {
	        alert('댓글 내용을 입력해주세요.');
	        return;
	    }
	    
	    // 서버로 댓글 전송하는 Ajax 요청
	    $.ajax({
	      url: "postCommentWrite.ajax", // 댓글 작성 요청을 처리하는 서버 URL
	      method: "POST",
	      dataType: "json",
	      data: {
	        'id': commentId, // 해당 코멘트의 고유번호
	        'content': replyContent
	      },
	      success: function(data) {
	        console.log(data);
	        alert("댓글을 작성했습니다.");

	        getComments(commentId);
	        commentInput.val('');
	      },
	      error: function(xhr, status, error) {
	        console.log(error);
	      }
	    });
	  });

	  function getComments(comment_id) {
		console.log(comment_id);
	    $.ajax({
	      url: 'postCommentRead.ajax', // 서버에서 데이터를 가져올 URL
	      method: "POST",
	      dataType: "json",
	      async: false,
	      data: {
	        'comment_id': comment_id
	      },
	      success: function(data) {
	        console.log(data);
	        console.log(data.dto);

	        $('.commentReply'+comment_id).empty(); // 기존 댓글 목록을 비웁니다.

	        data.dto.forEach(function(item) {
	          var commentHtml = '<div>' + item.name+ '</div>';
	          commentHtml += '<div>' + item.create_at + '</div>';
	          commentHtml += '<div>' + item.content + '</div>';
	          if (item.member_id === loginId) {
	        	  commentHtml += '<button class="deleteButton btn btn-danger btn-sm" data-reply-id="' + item.id + '" data-comment-id="' + item.coment_id + '"><i class="far fa-trash-alt"></i> 삭제</button>';

	          }  
	          commentHtml += '<hr>';

	          $('.commentReply'+comment_id).append(commentHtml);
	        });
	        
	        $('.commentReply'+comment_id).find('.deleteButton').click(function() {
	            var reply_id = $(this).data('reply-id');  
	            var comment_id = $(this).data('comment-id');
	            console.log(reply_id);
	            console.log(comment_id);
	            deleteComment(reply_id, comment_id);
	          });   
	        
	      },
	      error: function(data) {
	        console.log(data);
	      }
	    });
	  }
	  
	  function deleteComment(reply_id, comment_id) {
		  console.log('comment_id : ' + comment_id);
		  console.log('reply_id : ' + reply_id);
		  $.ajax({
		    url: 'replyDel.ajax', // 삭제 요청을 보낼 URL
		    method: "POST",
		    dataType: "json",
		    data: {
		      'id': reply_id
		    },
		    success: function(data) {
		    	alert("댓글 삭제 요청이 성공적으로 완료되었습니다.");
		    	getComments(comment_id);
		    },
		    error: function(data) {
		    	alert("댓글 삭제 요청이 실패했습니다.");
		    }
		  });
		}
	  
	});



</script>
</body>
</html>
