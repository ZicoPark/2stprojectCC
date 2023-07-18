<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>CreatorCompany</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Tempusdominus Bootstrap 4 -->
  <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- JQVMap -->
  <link rel="stylesheet" href="plugins/jqvmap/jqvmap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="dist/css/adminlte.min.css">
  <!-- overlayScrollbars -->
  <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
  <!-- Daterange picker -->
  <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
  <!-- summernote -->
  <link rel="stylesheet" href="plugins/summernote/summernote-bs4.min.css">
</head>
<body class="hold-transition sidebar-mini">
<jsp:include page = "index.jsp"></jsp:include>

<div class="wrapper">

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <!-- /.content-header -->
<section class="content">
 <div class="row">
<div class="col-md-3">

<div class="card card-primary card-outline" style="border-top : 3px solid #20c997!important">
<div class="card-body box-profile">
<div style="display: flex; align-items: center; justify-content: center; height: 100%;">
 <c:choose>
   <c:when test="${not empty member.photoName}">
     <img src="photoView.do?path=${member.photoName}" class="profile-user-img img-fluid img-circle" id="preview" style= "height: 130px; width: 130px;">
   </c:when>
   <c:otherwise>
     <img class="profile-user-img img-fluid img-circle" src="img/cc.png" id="preview" style= "height: 130px; width: 130px;">
   </c:otherwise>
 </c:choose>
</div>
<div class="text-center">
</div>
<h3 class="profile-username text-center">${main.m_name }</h3>
<p class="text-muted text-center">${main.d_name} /  ${main.jl_name}</p>
<ul class="list-group list-group-unbordered mb-3">
<li class="list-group-item">
    <b>출근시간</b>
<a class="float-right" style=" FONT-SIZE: 13PX; COLOR: GREEN;">
    ${timeList.time_go}
</a>

</li>
<li class="list-group-item">
    <b>퇴근시간</b>
    <a class="float-right" style=" FONT-SIZE: 13PX; COLOR: RED;">
        ${timeList.time_end}
    </a>
</li>



<li class="list-group-item">
<h4 id="clock"></h4>
</li>
</ul>
<button type="button" class="btn btn-success btn-sm" onclick="location.href='timeGo.do'">출근</button>&nbsp;&nbsp;
          <button type="button" class="btn btn-danger btn-sm" onclick="location.href='timeEnd.do'">퇴근</button>
</div>

</div>


<div class="card card-primary">
<div class="card-header" style=" background-color: #20c997!important;">
<h3 class="card-title">DashBoard</h3>
</div>

<div class="card-body">
<strong><i class="far fa-file-alt mr-1"></i><a href="/msReceiveList.go"> 받은 쪽지함 &nbsp ${ms}</a></strong>

<hr>
<strong><i class="fas fa-pencil-alt mr-1"></i><a href="#"> 결재 대기함 &nbsp ${doc}</a></strong>

<hr>
<strong><i class="fas fa-book mr-1"></i><a href="projects.go"> 진행중인 프로젝트 &nbsp ${pro}</a></strong>

<hr>

</div>

</div>

</div>






<div class="col-md-9">
 <div class="row">
  <div class="col-lg-6">
     <div class="col-md-12">
    <div class="card">
      <div class="card-header border-0" style=" background-color: #20c997!important;">
        <h3 class="card-title" style="font-size: 1.1rem; font-weight: 400; color: white">공지사항</h3>
        <div class="card-tools">
          <a href="/noticeBoard.go" class="btn btn-tool btn-sm">
            더보기
          </a>
        </div>
      </div>
      <div class="card-body table-responsive p-0">
        <table class="table table-striped table-valign-middle">
          <thead>
            <tr>
              <th>제목</th>
              <th>작성자</th>
              <th>등록일</th>
            </tr>
          </thead>
          <tbody>
	        <c:forEach items="${Nolist}" var="i">
	          <tr>
	            <td>${i.subject}</td>
	            <td>${i.name}</td>
	            <td>${i.create_at}</td>
	            <td><input type ="hidden" id = "${i.id}" /></td>
	          </tr>
	        </c:forEach>
          </tbody>
        </table>
      </div>
    </div>     
     </div>
    </div> 
   <div class="col-lg-6">   
   <div class="col-md-12"> 
    <div class="card">
      <div class="card-header border-0" style=" background-color: #20c997!important;">
        <h3 class="card-title" style="font-size: 1.1rem; font-weight: 400; color: white">언젠가 쓸거임</h3>
        <div class="card-tools">
          <a href="/noticeBoard.go" class="btn btn-tool btn-sm">
            더보기
          </a>
        </div>
      </div>
      <div class="card-body table-responsive p-0">
        <table class="table table-striped table-valign-middle">
          <thead>
            <tr>
              <th>제목</th>
              <th>작성자</th>
              <th>등록일</th>
            </tr>
          </thead>
          <tbody>
	        <c:forEach items="${Nolist}" var="i">
	          <tr>
	            <td>${i.subject}</td>
	            <td>${i.name}</td>
	            <td>${i.create_at}</td>
	            <td><input type ="hidden" id = "${i.id}" /></td>
	          </tr>
	        </c:forEach>
          </tbody>
        </table>
      </div>
    </div>
   </div>
  </div> 
 </div>  
  <div class="card">
<div class="card-header ui-sortable-handle" style="cursor: move; background-color: #20c997!important;">
<h3 class="card-title" style="font-size: 1.1rem; font-weight: 400; color: white">
<i class="ion ion-clipboard mr-1"></i>
개인 업무 관리
</h3>
<div class="card-tools">

</div>
</div>

<div class="card-body">
<ul class="todo-list ui-sortable" data-widget="todo-list">

<div class="card-body" style="overflow-y: auto; max-height: 300px;">
<ul class="todo-list ui-sortable" data-widget="todo-list">

<!-- 한 줄  -->

<c:forEach items="${PerList}" var="personal">
<li class="${personal.status ? '' : 'done'}" style="">

<span class="handle ui-sortable-handle">
<i class="fas fa-ellipsis-v"></i>
<i class="fas fa-ellipsis-v"></i>
</span>

<div class="icheck-primary d-inline ml-2">
  <input type="checkbox" value="${personal.id}" name="todo" id="todoCheck${personal.id}" ${personal.status ? '' : 'checked'}>
  <label for="todoCheck${personal.id}"></label>
</div>



<span class="text">${personal.title}</span>


<div class="tools">
<!-- 수정버튼 -->
<a href="personalUpdate.go?id=${personal.id}" style="color: inherit;">
  <i class="fas fa-edit"></i>
</a>

<i class="fas fa-trash-o"></i>
</div>
</li>

</c:forEach>
</ul>

</div>


</ul>
</div>

<div class="card-footer clearfix">
<button onclick="location.href='personalWrite.go'" class="btn btn-primary float-right"><i class="fas fa-plus"></i> Add item</button>
</div>
</div>
  
  
  
  </div>
</div>


 </section>         
           
</div>

           
           
           
  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->
</div>


<!-- jQuery -->
<script src="plugins/jquery/jquery.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button)
</script>
<!-- Bootstrap 4 -->
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- ChartJS -->
<script src="plugins/chart.js/Chart.min.js"></script>
<!-- Sparkline -->
<script src="plugins/sparklines/sparkline.js"></script>
<!-- JQVMap -->
<script src="plugins/jqvmap/jquery.vmap.min.js"></script>
<script src="plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
<!-- jQuery Knob Chart -->
<script src="plugins/jquery-knob/jquery.knob.min.js"></script>
<!-- daterangepicker -->
<script src="plugins/moment/moment.min.js"></script>
<script src="plugins/daterangepicker/daterangepicker.js"></script>
<!-- Tempusdominus Bootstrap 4 -->
<script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
<!-- Summernote -->
<script src="plugins/summernote/summernote-bs4.min.js"></script>
<!-- overlayScrollbars -->
<script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/adminlte.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="dist/js/demo.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="dist/js/pages/dashboard.js"></script>
</body>
<script>
var msg = "${msg}";
if(msg != ""){
	alert(msg);
}	

	// 시계 
	setInterval(function(){
	    var timer = new Date();
	    var h = timer.getHours();
	    var m = timer.getMinutes();
	    var s = timer.getSeconds();
	    document.getElementById('clock').innerHTML = h + ":" + m + ":" + s;},1000);
	    

	  // 개인업무 체크박스 클릭 했을 때
	  $("input[name='todo']").on("click", function() {
	    var isChk = $(this).is(":checked");
	    var liElement = $(this).closest("li");
	    var todoId = $(this).val();

	    if (isChk) {
	      $.ajax({
	        url: "/updateTodo.ajax",
	        method: "POST",
	        data: { todoId: todoId },
	        success: function(response) {
	        liElement.addClass("done");
	          console.log("개인업무 체크박스 ajax 성공")
	        },
	        error: function() {
	          console.log("오류 발생");
	        }
	      });
	    } else {
	      $.ajax({
	        url: "/updateTodo.ajax",
	        method: "POST",
	        data: { todoId: todoId },
	        success: function(response) {
	        	liElement.removeClass("done");
	          console.log("개인업무 체크박스 ajax 성공")
	        },
	        error: function() {
	          console.log("오류 발생");
	        }
	      });
	    }
	  });

    
    
    
    
    
    
    

</script>


</html>
