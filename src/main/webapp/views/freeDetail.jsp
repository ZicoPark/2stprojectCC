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

<div class="wrapper">

  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Compose</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Compose</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
 
        <div class="col-md-9">
          <div class="card card-primary card-outline">
            <div class="card-header">
              <h3 class="card-title">${detailms.subject}</h3>

              <div class="card-tools">
                <a href="#" class="btn btn-tool" title="Previous"><i class="fas fa-chevron-left"></i></a>
                <a href="#" class="btn btn-tool" title="Next"><i class="fas fa-chevron-right"></i></a>
              </div>
            </div>
            <!-- /.card-header -->
            <div class="card-body p-0">
              <div class="mailbox-read-info">
                문서번호 ${detailms.id} <br>
                <h6>
                  <span class="mailbox-read-time float-right"> 
                  작성자 ${detailms.name} < ${detailms.dept_id} > <br>
                  작성일  &nbsp ${detailms.create_at}
                  &nbsp &nbsp 조회수 &nbsp ${detailms.hit}
                  </span></h6>
              </div>
     
              </div>
              <!-- /.mailbox-controls -->
              <div class="mailbox-read-message">
                <p>${detailms.content}</p>
              </div>
              <!-- /.mailbox-read-message -->
            </div>
            <!-- /.card-body -->
    

            <div class="card-footer bg-white">
              <ul class="mailbox-attachments d-flex align-items-stretch clearfix">
              <c:if test="${detailFile.size() == 0 }">
               <div>첨부파일 없음.</div>
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
            <!-- /.card-footer -->
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

         <!-- 댓글 -->
   
         <hr />
            
<!--             <li>
                    <div>
                        <p>첫번째 댓글 작성자</p>
                        <p>첫번째 댓글</p>
                    </div>
                </li>
                <li>
                    <div>
                        <p>두번째 댓글 작성자</p>
                        <p>두번째 댓글</p>
                    </div>
                </li>
                <li>
                    <div>
                        <p>세번째 댓글 작성자</p>
                        <p>세번째 댓글</p>
                    </div>
                </li>-->


         <div>
         
             <form method="post" action="replyWrite.do">
             
                 <p>
                     <label>댓글 작성자</label> <input type="text" name="member_id" value="${loginId}">
                 </p>
                 <p>
                     <textarea rows="5" cols="50" name="content"></textarea>
                 </p>
                 <p>
                    <input id = "hi" type="hidden" name="free_board_id" value="${detailms.id}">
                     <button type="submit">댓글 작성</button>
                 </p>
             </form>
             
         </div>
         
      <!-- 댓글 목록/ 댓글 수정 -->
            
      <table>    
         
         
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


         <!-- 댓글 끝 -->
            </div>
            <!-- /.card-footer -->
          </div>
          <!-- /.card -->
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
	  
	  list.forEach(function(item) {
	    content += '<div class="comment">';
	    content += '<div class="comment-header">';
	    content += '<span class="username">' + item.name + ' (' + item.user_id + ')</span>';
	    content += '<span class="description">' + item.create_at + '</span>';
	    content += '</div>';
	    content += '<div class="comment-content">' + item.content + '</div>';
	    content += '<div class="comment-actions">';
	    content += '<a href="#" onclick="showEditCommentForm(this, \'' + item.id + '\', \'' + item.member_id + '\')">수정</a>';
	    content += '<a href="replyDelete.do?id=' + item.id + '&free_board_id=' + item.free_board_id + '">삭제</a>';
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

       // 수정 완료 버튼 추가
       var buttonElement = $('<button type="button" class="btn btn-info btn-flat">완료</button>').click(function() {
         var modifiedContent = $(textareaElement).val(); // 수정된 댓글 내용 가져오기   
   
        if('${sessionScope.id}' == memberId) {
         $.ajax({
            url:'commentUpdate.ajax',
            type:'post',
            data:{
               'content': currentContent,
               'id' : replyId
            },
            dataType:'json',
            success:function(data){
               console.log(data);
               
               
            },
            error:function(e){
               console.log(e);
            }
         });
         
      }
       
        $(trElement).find('.comment-content').text(modifiedContent).show()
         // textarea와 버튼 요소 제거
         $(textareaElement).remove();
         $(buttonElement).remove();
         $(element).show();
       });

       $(trElement).append(buttonElement);
       
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