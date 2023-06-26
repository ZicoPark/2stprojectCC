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
  <style>
      table, th, td{
         border: 1px solid black;
         border-collapse: collapse;
         padding: 5px 10px;
      }
      #login{
         margin-bottom: 20px;
      }
      button{
         margin: 5px;
      }
      table{
         width: 500px;
      }
</style>
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
      <form action="noticeBoardWrite.do" method="post" enctype="multipart/form-data"> <!-- multiUpload.do -->
         <table class="table table-bordered table-hover dataTable dtr-inline">
            <tr>
               <th>제목</th>
               <td><input type="text" name="subject" /></td>
            </tr>
            <tr>
               <th>내용</th>
               <td><textarea name="content"></textarea> </td>
            </tr>
            <tr>
            	<th>첨부파일</th>
            	<td>
					<input type="file" name="uploadFile"  multiple="multiple"/>	
				</td>
            </tr>
            <tr>
               <th colspan="2">
                  <input type="button" onclick="location.href='./noticeBoard.go'" value="돌아가기" />
                  <button>작성하기</button>
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
</script>
</html>
   