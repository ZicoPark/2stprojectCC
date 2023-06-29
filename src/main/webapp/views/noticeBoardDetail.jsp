<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>AdminLTE 3 | Projects</title>

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
  <div class="content-wrapper">
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
		       <td>${detailno.create_id}</td>
		    </tr>
		    <tr>
		       <th>조회수</th>
		       <td>${detailno.hit}</td>
		    </tr>
		    <tr>
		       <th>작성일</th>
		       <td>${detailno.notice_date}</td>
		    </tr>
		    <tr>
		       <th>내용</th>
		       <td>${detailno.content}</td>
		    </tr>      
		   	<tr>
		       <th>첨부파일</th>
		       <td>	
					<a href="msdownload.do?path=${detailFile}" class="btn btn-default btn-sm float-right"></a>
				</td>
		    </tr>   
		    <tr>
		       <th colspan="2">
		          <input type="button" class="btn btn-block btn-outline-success btn-lg"  onclick="location.href='noticeList.go'" value="안읽음" />         
		           <input type="button" class="btn btn-block btn-outline-success btn-lg"  onclick="location.href='./noticeBoard.go'" value="돌아가기" />
		       </th>            
		   	</tr>         
    	</table>
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
</script>
</html>