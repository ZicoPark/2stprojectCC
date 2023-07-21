<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>AdminLTE 3 | Projects</title>
<link rel="icon" href="/img/CC_favicon.png">
  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
</head>
<body>
<jsp:include page = "index.jsp"></jsp:include>
<!-- Site wrapper -->
<div class="wrapper">
<%--   <div class="content-wrapper">
    <section class="content-header">
            <h1>공지사항</h1>         
    </section>
    <!-- Main content -->
    <section class="content">   
       <table class="table table-bordered table-hover dataTable dtr-inline">

          <tr>
             <th>제목</th>
             <td>${detailno.subject}</td>
          </tr>
          <tr>
             <th>작성자</th>
             <td>${detailno.name}(${detailno.user_id})</td>
          </tr>
          <tr>
             <th>조회수</th>
             <td>${detailno.hit}</td>
          </tr>
          <tr>
             <th>작성일</th>
             <td>${detailno.create_at}</td>
          </tr>
          <tr>
             <th>내용</th>
             <td>${detailno.content}</td>
          </tr>      
          <tr>
             <th>첨부파일</th>
              <td>
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
         	</td>   
          </tr> 

          <tr>
             <th colspan="2"></th>
          </tr>

            <c:if test="${reader eq null}">
                <tr>
                    <th style="text-align:left">공지 확인 사원</th>
                    <td colspan="3" id="fornull" style="text-align:center">아직 읽은 사원이 없습니다.</td>
                </tr>
            </c:if>
            
            <c:if test="${reader.size()==0}">
                <tr>
                    <th style="text-align:center">공지 확인 사원</th>
                    <td colspan="3" id="forzero" style="text-align:center">아직 읽은 사원이 없습니다.</td>
                </tr>
            </c:if>
            
            <c:if test="${not empty reader}">
                <tr>
                    <th style="text-align:left">공지 확인 사원</th>
                    <td style="text-align:center">
                        <c:forEach items="${reader}" var="employee">
                            ${employee.name}<br>
                        </c:forEach>
                    </td>
                </tr>
            </c:if>
          
          
          <tr>
             <th colspan="2">    
                 <input type="button" class="btn btn-block btn-outline-success btn-lg"  onclick="location.href='./noticeBoard.go'" value="돌아가기" />
             </th>            
            </tr>
            <c:if test="${loginid.admin_chk eq 1}">
	            <tr>
		             <th colspan="2">    
					    <input type="button" class="btn btn-block btn-outline-success btn-lg" onclick="deleteNotice();" value="삭제" />
					</th>         
	            </tr>                   
             </c:if>
               
       </table>
    </section>
  </div> --%>
  



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
<%--             <div class="card-header">
              <h3 style="font-weight: bold;font-size: 30px;">${detailno.subject}</h3>
				<span class="mailbox-read-time float-right"> 
                  작성자&nbsp ${detailno.name}(${detailno.user_id})<br>
             	</span>
            </div> --%>
            <!-- /.card-header -->

              <div class="mailbox-read-info">
                  <div class="mailbox-read-time"> 
                 <h3 style="font-weight: bold;font-size: 30px;  color: black;">${detailno.subject}</h3>
				<span class="mailbox-read-time float-right"> 
                  작성자&nbsp ${detailno.name}(${detailno.user_id})<br>
             	</span>
                  작성일  &nbsp ${detailno.create_at}
                  &nbsp &nbsp 조회수 &nbsp ${detailno.hit}
                  </div>
                 
              </div>
     

              <!-- /.mailbox-controls -->
              <div class="mailbox-read-message" style="height: 300px;">
                <p>${detailno.content}</p>
              </div>
              <!-- /.mailbox-read-message -->
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
            <div class="card-footer">
              <div class="float-right">
			    <c:if test="${loginid.admin_chk eq 1}">
			     <button type="button" onclick="deleteNotice();" class="btn btn-default"><i class="far fa-trash-alt"></i></button>
			    </c:if>
                <button type="button" onclick="location.href='./noticeBoard.go'" class="btn btn-default"> 목록</button>
              </div>

            </div>
            </div>
            <!-- /.card-body -->
    

            <!-- /.card-footer -->
            <!-- /.card-footer -->
          </div>
          <!-- /.card -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
    </section>
      </div><!-- /.container-fluid -->
  
  
  
  
  
  
  
  
  
  
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
   //socket.send('알림');
   
   function deleteNotice() {
    //삭제 여부를 확인하는 confirm 창 표시
    var result = confirm("정말로 삭제하시겠습니까? 삭제 후에는 복구가 불가능합니다.");
    if (result) {
        // 사용자가 "확인"을 선택한 경우에만 삭제를 진행하는 alert 창 표시
        alert("삭제되었습니다."); // 원하는 메시지를 alert 창에 표시
        // 삭제를 진행하는 URL로 이동
        location.href = "./noticeBoardDel.do?id=${detailno.id}";
    }
}

</script>
</html>

   