<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>AdminLTE 3 | Projects</title>

 <!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<!-- Tempusdominus Bootstrap 4 -->
<link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
<!-- overlayScrollbars-->
<link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
<!-- Ionicons -->
<link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">


  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
</head>
<style>
    .type-notice {
        color: red;
    }
    .type-approval {
        color: blue;
    }
    .type-message {
        color: green;
    }
</style>
<body>
<jsp:include page = "index.jsp"></jsp:include>
<!-- Site wrapper -->
<div class="wrapper">
  <div class="content-wrapper">
    <section class="content-header">
            <h1>이전 알림</h1>         
    </section>
    <!-- Main content -->
    <section class="content">

		
		<div class="container">
		  <div class="card card-primary card-tabs">
		    <div class="card-header p-0 pt-1">
		      <ul class="nav nav-tabs" id="custom-tabs-one-tab" role="tablist">
		        <li class="nav-item flex-grow-1">
		          <a class="nav-link active" id="custom-tabs-one-home-tab" data-toggle="pill" href="#custom-tabs-one-home" role="tab" aria-controls="custom-tabs-one-home" aria-selected="false" style="text-align:center"><strong>안 읽은 알림</strong></a>
		        </li>
		        <li class="nav-item flex-grow-1">
		          <a class="nav-link" id="custom-tabs-one-profile-tab" data-toggle="pill" href="#custom-tabs-one-profile" role="tab" aria-controls="custom-tabs-one-profile" aria-selected="true" style="text-align:center"><strong>읽은 알림</strong></a>
		        </li>
		      </ul>
		    </div>
		    <div class="card-body">
		      <div class="tab-content" id="custom-tabs-one-tabContent">
		        <div class="tab-pane fade" id="custom-tabs-one-home" role="tabpanel" aria-labelledby="custom-tabs-one-home-tab">
         
         
         
        <div class="card-body p-0">
    <table class="table table-striped">
        <thead>
            <tr>
                <th style="text-align:center">분류</th>
                <th style="text-align:center">알림 제목</th>
                <th style="text-align:center">발신인</th>
                <th style="text-align:center">날짜</th>
            </tr>
        </thead>
        <tbody>
            <c:if test="${list eq null}">
                <tr>
                    <th colspan="5" style="text-align:center">알림이 없습니다.</th>
                </tr>
            </c:if>
			<c:forEach items="${list}" var="noticeList">
			    <tr>
			        <td style="text-align:center">
			            <c:set var="typeClass" value="" />
			            <c:choose>
			                <c:when test="${noticeList.type eq '공지사항'}">
			                    <c:set var="typeClass" value="type-notice" />
			                </c:when>
			                <c:when test="${noticeList.type eq '전자결재'}">
			                    <c:set var="typeClass" value="type-approval" />
			                </c:when>
			                <c:when test="${noticeList.type eq '쪽지'}">
			                    <c:set var="typeClass" value="type-message" />
			                </c:when>
			            </c:choose>
			            <span class="${typeClass}">${noticeList.type}</span>
			        </td>
			        <td style="text-align:center">
			            <c:choose>
			                <c:when test="${noticeList.type eq '공지사항'}">
			                    <a href="noticeBoardDetail.do?id=${noticeList.identify_value}">${noticeList.subject}</a>
			                </c:when>
			                <c:when test="${noticeList.type eq '전자결재'}">
			                    <a href="requestDocWaitDetail.go?id=${noticeList.identify_value}">${noticeList.doc_subject}</a>
			                </c:when>
			                <c:when test="${noticeList.type eq '쪽지'}">
			                    <a href="msRcDetail.do?id=${noticeList.identify_value}">${noticeList.title}</a>
			                </c:when>
<%-- 			                <c:otherwise>
			                    <a href="alarmDetail.do?id=${noticeList.identify_value}">${noticeList.identify_value}</a>
			                </c:otherwise> --%>
			            </c:choose>
			        </td>
			        <td style="text-align:center">${noticeList.name}(${noticeList.user_id})</td>
			        <td style="text-align:center">${noticeList.create_at}</td>
			    </tr>
			</c:forEach>
        </tbody>
    </table>
</div>
  
  
         
         </div>
        <div class="tab-pane fade active show" id="custom-tabs-one-profile" role="tabpanel" aria-labelledby="custom-tabs-one-profile-tab">
        
 
              <div class="card-body p-0">
    <table class="table table-striped">
        <thead>
            <tr>
                <th style="text-align:center">분류</th>
                <th style="text-align:center">알림 제목</th>
                <th style="text-align:center">발신인</th>
                <th style="text-align:center">날짜</th>
            </tr>
        </thead>
       <tbody>
			<c:if test="${list eq null}">
			    <tr>
			        <th colspan="5" style="text-align:center">알림이 없습니다.</th>
			    </tr>
			</c:if>
			<c:forEach items="${list}" var="noticeList">
			    <tr>
			        <td style="text-align:center">
			            <c:set var="typeClass" value="" />
			            <c:choose>
			                <c:when test="${noticeList.type eq '공지사항'}">
			                    <c:set var="typeClass" value="type-notice" />
			                </c:when>
			                <c:when test="${noticeList.type eq '전자결재'}">
			                    <c:set var="typeClass" value="type-approval" />
			                </c:when>
			                <c:when test="${noticeList.type eq '쪽지'}">
			                    <c:set var="typeClass" value="type-message" />
			                </c:when>
			            </c:choose>
			            <span class="${typeClass}">${noticeList.type}</span>
			        </td>
			        <td style="text-align:center">
			            <c:choose>
			                <c:when test="${noticeList.type eq '공지사항'}">
			                    <a href="noticeBoardDetail.do?id=${noticeList.identify_value}">${noticeList.subject}</a>
			                </c:when>
			                <c:when test="${noticeList.type eq '전자결재'}">
			                    <a href="requestDocWaitDetail.go?id=${noticeList.identify_value}">${noticeList.doc_subject}</a>
			                </c:when>
			                <c:when test="${noticeList.type eq '쪽지'}">
			                    <a href="msRcDetail.do?id=${noticeList.identify_value}">${noticeList.title}</a>
			                </c:when>
<%-- 			                <c:otherwise>
			                    <a href="alarmDetail.do?id=${noticeList.identify_value}">${noticeList.identify_value}</a>
			                </c:otherwise> --%>
			            </c:choose>
			        </td>
			        <td style="text-align:center">${noticeList.name}(${noticeList.user_id})</td>
			        <td style="text-align:center">${noticeList.create_at}</td>
			    </tr>
			</c:forEach>
        </tbody>
    </table>
</div>
        
        
        
        </div>
      </div>
       <div class="card-footer clearfix">
<ul class="pagination pagination-sm m-0 float-right">
<li class="page-item"><a class="page-link" href="#">«</a></li>
<li class="page-item"><a class="page-link" href="#">1</a></li>
<li class="page-item"><a class="page-link" href="#">2</a></li>
<li class="page-item"><a class="page-link" href="#">3</a></li>
<li class="page-item"><a class="page-link" href="#">»</a></li>
</ul>
</div>
      
    </div>
  </div>
  

</div>






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









