<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>사내게시판 상세보기</title>
<link rel="icon" href="/img/CC_favicon.png">
  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
</head>

<style>

/* 댓글 컨테이너 */
.comment {
  border: 1px solid #ccc0;
  padding: 10px;
  margin-bottom: 10px;

  width: 500px;
  margin: 20px;
}

/* 댓글 헤더 */
.comment-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.username {
  font-weight: bold;
}

.description {
  font-size: 12px;
  color: #888;
}

/* 댓글 내용 */
.comment-content {
  margin: 10px 0;
}

/* 댓글 액션 (수정, 삭제 링크) */
.comment-actions {
  display: flex;
  justify-content: flex-end; 
}

.comment-actions a {
  color: #333;
  text-decoration: none;
  padding: 5px 10px;
  border: 1px solid #ccc;
  border-radius: 3px;
  transition: background-color 0.3s ease;
  margin-left: 5px; 
}

.comment-actions a:hover {
  background-color: #f0f0f0;
}


    .comment-form {
        margin-bottom: 20px;
    }

    .comment-input {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 10px;
    }

    .comment-input textarea {
        flex: 1;
        margin-right: 10px;
    }

    .comment-submit-btn {
        padding: 8px 15px;
        background-color: #007bff;
        color: #fff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    
    
	.write {
/*     position: absolute; */
    bottom: 501px;
    left: 15px;
    height: 42px;
    padding-left: 8px;
    border: 1px solid #e6e6e6;
    background-color: #fef5f59c;
    width: 55%;
    border-radius: 5px;
}


.send {
    width: 40px;
    height: 40px;
    background-color: #3ab795;
    border-radius: 5px;
    border: none;
    position: absolute;
    left: 51%;
    color: #fff;
    cursor: pointer;
}

.fa {
    display: inline-block;
    font: normal normal normal 14px/1 FontAwesome;
    font-size: inherit;
    text-rendering: auto;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
}    
   
   
.write input {
    font-size: 14px;
    position: absolute;
    left: 45px;
    width: 45%;
    height: 40px;
    padding: 0 10px;
    color: #6b6b6b;
    border: 0;
    outline: none;
    background-color: #fef5f59c;
    font-family: 'Roboto', sans-serif;
    font-weight: 400;    
</style>

<body class="hold-transition sidebar-mini">
<jsp:include page = "index.jsp"></jsp:include>

<div class="wrapper">

  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
       <div class="col-md-9" style="margin: 0 auto;">
           <div class="card card-primary card-outline" style="border-top : 3px solid #20c997!important">
            <div class="card-header">
			문서번호 ${detailms.id}
			<span class="mailbox-read-time float-right"> 
               작성자 ${detailms.name} ( ${detailms.user_id } ) <br>
          	</span>
            </div>
            <!-- /.card-header -->
            <div class="card-body p-0">
              <div class="mailbox-read-info">
               	<h3 style="font-weight: bold;font-size: 30px;">${detailms.subject}</h3>
			
                  <div class="mailbox-read-time"> 
                  작성일  &nbsp ${detailms.create_at}
                  &nbsp &nbsp 조회수 &nbsp ${detailms.hit}
                  </div>
                 
              </div>
     
              </div>


              <div class="mailbox-read-message" style="height: 350px;">
                <p>${detailms.content}</p>
              </div>
              
              
            <div class="card-footer bg-white">
              <ul class="mailbox-attachments d-flex align-items-stretch clearfix">
			  	<c:if test="${detailFile.size() == 0 }">
					<div></div>
				</c:if>       
				<c:if test="${detailFile.size() > 0 }">
					<c:forEach items="${detailFile}" var="i">
                  <div class="mailbox-attachment-info">
                    <a class="mailbox-attachment-name"><i class="fas fa-paperclip"></i> &nbsp ${i.ori_file_name}</a>
					&nbsp &nbsp
                    <a href="msdownload.do?path=${i.id}" class="btn btn-default btn-sm float-right"><i class="fas fa-cloud-download-alt"></i></a>
                    
                  </div>

            	</c:forEach>
			</c:if>
              </ul>
            </div>
            
              
          <div class="card-footer">
           <div class="float-right">
             <c:if test="${loginid.admin_chk eq 1 or loginId eq detailms.member_id}">
               <button type="button" class="btn btn-default" onclick="confirmDelete(event, 'freeDelete.do?id=${detailms.id}')">
                    <i class="far fa-trash-alt"></i>
                </button>
               <button type="button" onclick="location.href='/freeUpdate.go?id=${detailms.id}&member_id=${detailms.member_id}'" class="btn btn-default"> 수정</button>
             </c:if>
             <button type="button" onclick="location.href='/freeBoard.go'" class="btn btn-default"> 목록</button>
           </div>
         </div>
              
              
              
            </div>
            <!-- /.card -->


         <!-- 댓글 -->
   
         <hr />
            
         
<div class="card-body">
  <div class="write" id="write">
    <form method="post" action="replyWrite.do" class="comment-form">
      <input type="hidden" name="member_id" value="${loginId}">
      <div class="comment-input">
        <div>
          <input type="text" id="message-box" name="content" placeholder="댓글을 남겨주세요" />
          <button type="submit" class="send" id="send">
            <i class="fa fa-paper-plane" aria-hidden="true"></i>
          </button>
        </div>
      </div>
      <input id="hi" type="hidden" name="free_board_id" value="${detailms.id}">
    </form>
  </div>
</div>

      <!-- 댓글 목록/ 댓글 수정 -->
            
      <table style="border: 1px solid #ccc; background-color: #f9f9f9; border-radius: 5px;">    
         

         <tbody id="list">
                  


      <tr>
           <th colspan="6" id="paging">  
             <div class="container">                  
               <nav aria-label="Page navigation">
                 <ul class="pagination justify-content-center" id="pagination"></ul>
               </nav>
             </div>
           </th>
         </tr>   
         
      </table>   

				</div>
         <!-- 댓글 끝 -->
            </div>
            <!-- /.card-footer -->
          </div>

        <!-- /.col -->

    </section>

   </div><!-- /.container-fluid -->
 </div>  
 
  

<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>

<script type="text/javascript" src="../../dist/js/jquery.twbsPagination.min.js"></script>
</body>

<script>

var showPage = 1;
var free_board_id = $('#hi').val();

listCall(showPage);

   
function listCall(page){
      $.ajax({
         type:'post',
         url:'replyList.ajax',
         data:{
            'page':page,
            'free_board_id': free_board_id
         },
         dataType:'json',           
         success:function(data){
            console.log(data);
            listPrint(data.list);
            
            // 페이징 처리를 위해 필요한 데이터
            // 1. 총 페이지의 수
            // 2. 현재 페이지
            console.log(data.list); // arraylist 로 값 들어옴
            
            // Paging Plugin (j-query의 기본기능을 가지고 만들었기 때문에  plugin)
            $('#pagination').twbsPagination({
            startPage:1, // 시작 페이지
            totalPages:data.pages,// 총 페이지 수 
            visiblePages:5,// 보여줄 페이지
            onPageClick:function(event,page){ // 페이지 클릭시 동작되는 (콜백)함수
               console.log(page,showPage);
               if(page != showPage){
                  showPage=page;
                  listCall(page);
             
               }
            }
            });
         }
      });
   }




function listPrint(list) {
     var content = '';
     var count = (showPage - 1) * 10 + list.length;
     var totalItems = list.length;
     var isAdmin = document.getElementById('adminchk'); // 서버에서 가져온 관리자 여부 값
     var sessionId = "${sessionScope.id}";
     console.log(sessionId, isAdmin);
     
     
     list.forEach(function(item) {
       content += '<div class="comment">';
       content += '<div class="comment-header">';
       content += '<span class="username">' + item.name + ' (' + item.user_id + ')</span>'; 
       content += '<span class="description">' + item.create_at + '</span>';
       content += '</div>';
       content += '<div class="comment-content">' + item.content + '</div>';
       content += '<div class="comment-actions">';
       if (sessionId === item.member_id) {
           content += '<a href="#" onclick="showEditCommentForm(this, \'' + item.id + '\', \'' + item.member_id + '\')">수정</a>';
           }
       if (isAdmin && isAdmin.value === '1' || sessionId === item.member_id) {
    	    content += '<a href="replyDelete.do?id=' + item.id + '&free_board_id=' + item.free_board_id + '">삭제</a>';
    	}




       
       content += '</div>';
       content += '</div>';
     });
     
     // list 요소의 내용 지우고 추가 - 페이징 처리
     $('#list').empty();
     $('#list').append(content);
   }




function showEditCommentForm(element, replyId, memberId) {
	  console.log("안녕");
	  if ('${sessionScope.id}' == memberId) {
	    var tdElement = $(element).parent(); // <td> 요소 선택
	    var trElement = $(tdElement).parent(); // <tr> 요소 선택

	    var currentContent = $(trElement).find('.comment-content').text(); // 현재 댓글 내용 가져오기
	    var textareaElement = $('<textarea rows="3" cols="55" class="form-control rounded-0"></textarea>').val(currentContent); // 새로운 textarea 요소 생성 및 현재 댓글 내용 삽입

	    // 기존 댓글 내용 숨기고 textarea 표시
	    $(trElement).find('.comment-content').hide().after(textareaElement);
	    $(element).hide();
	    $('.comment-actions a[href^="replyDelete.do?id=' + replyId + '"]').hide();
	    // 수정 완료 버튼 추가
	    var buttonElement = $('<button type="button" class="btn btn-info btn-flat">완료</button>').click(function() {
	      var modifiedContent = $(textareaElement).val(); // 수정된 댓글 내용 가져오기   
		  // 삭제 버튼 숨기기
		  
	      
	      if ('${sessionScope.id}' == memberId) {
	        $.ajax({
	          url: 'commentUpdate.ajax',
	          type: 'post',
	          data: {
	            'content': currentContent,
	            'id': replyId
	          },
	          dataType: 'json',
	          success: function(data) {
	            console.log(data);
	          },
	          error: function(e) {
	            console.log(e);
	          }
	        });
	      }

	      $(trElement).find('.comment-content').text(modifiedContent).show();
	      // textarea와 버튼 요소 제거
	      $(textareaElement).remove();
	      $(buttonElement).remove();
	      $(element).show();
	    });

	    $(trElement).append(buttonElement);
	    $('.comment-actions a[href^="replyDelete.do?id=' + replyId + '"]').show();
	  }


	}

  

function confirmDelete(event, url) {
    if (confirm("정말 삭제하시겠습니까?")) {
        window.location.href = url;
        alert("삭제 처리가 완료되었습니다.");
    } else {
        event.stopPropagation(); 
    }
}



</script>
</html>