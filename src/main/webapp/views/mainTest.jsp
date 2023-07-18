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

<style>

      @import url('https://fonts.googleapis.com/css?family=Questrial&display=swap');


        div .cal {
            background-color : white;
            height: auto;
            width: 400px;
            margin: 0px;
            padding: 20px;
            margin: 0 auto;
            border-radius:5px;
            box-shadow:0px 40px 30px -20px rgba(0,0,0,0.3);
        }
        

        td .day {
            width: 50px;
            height: 50px;
        } 

        .Calendar {
            text-align: center;
            margin: 21px;
        }

        .Calendar>thead>tr:first-child>td {
            font-family: 'Questrial', sans-serif;
            font-size: 1.1em;
            font-weight: bold;
        }

        .Calendar>thead>tr:last-child>td {
            font-family: 'Questrial', sans-serif;
            font-weight: 600;     
        }

        .Calendar>tbody>tr>td>p {
            font-family: 'Montserrat', sans-serif;
            height: 45px;
            width: 45px;
            border-radius: 45px;
            transition-duration: .2s;
            line-height: 45px;
            margin: 2.5px;
            display: block;
            text-align: center;
        }        

        .pastDay {
            color: lightgray;
        }

        .today {
            background-color: #F5D042;            
            color: #fff;
            font-weight: 600;
            cursor: pointer;
        }

        .futureDay {
            background-color: #FFFFFF;
            cursor: pointer;
        }
        .futureDay:hover{
            background:#eee;
        }

        .futureDay.choiceDay,
        .today.choiceDay {
            background: #0A174E;
            color: #fff;
            font-weight: 600;
            cursor: pointer;
        }

</style>


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


<div>
    <c:if test="${main.a_id == null || main.a_id == ''}">
        <img class="profile-user-img img-fluid img-circle" id="preview" style= "height: 130px; width: 130px;" src="img/cc.png"  alt="message user image">
    </c:if>
    <c:if test="${main.a_id != null && main.a_id != ''}">
        <img class="profile-user-img img-fluid img-circle" src="/photoView.do?path=${main.a_id}" alt="message user image" style= "height: 130px; width: 130px;">
    </c:if>
</div>
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
    <div class = "cal">
        <table class="Calendar">
            <thead>
                <tr>
                    <td class = "day" onClick="prevCalendar();" style="cursor:pointer;">&#60;</td>
                    <td class = "day" colspan="5">
                        <span id="calYear"></span>년
                        <span id="calMonth"></span>월
                    </td>
                    <td onClick="nextCalendar();" style="cursor:pointer;">&#62;</td>
                </tr>
                <tr>
                    <td class = "day">일</td>
                    <td class = "day">월</td>
                    <td class = "day">화</td>
                    <td class = "day">수</td>
                    <td class = "day">목</td>
                    <td class = "day">금</td>
                    <td class = "day">토</td>
                </tr>
            </thead>

            <tbody>
            </tbody>
        </table>
    </div>
    </div>
   </div>
  </div> 
 </div>  
 
 

  <div class="col-lg-6">
     <div class="col-md-12">
<div class="card">
<div class="card-header ui-sortable-handle" style="cursor: move; background-color: #20c997!important;">
<h3 class="card-title" style="font-size: 1.1rem; font-weight: 400; color: white">
<i class="ion ion-clipboard mr-1"></i>
유튜브 
</h3>
<div class="card-tools">

</div>
</div>

<div class="card-body">
<iframe width="1217" height="685" src="https://www.youtube.com/embed/WOQzrOuJm_A" title="고양이에게 미움받는 사람 특징" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

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

    
      window.onload = function () { buildCalendar(); }    // 웹 페이지가 로드되면 buildCalendar 실행

      let nowMonth = new Date();  // 현재 달을 페이지를 로드한 날의 달로 초기화
      let today = new Date();     // 페이지를 로드한 날짜를 저장
      today.setHours(0, 0, 0, 0);    // 비교 편의를 위해 today의 시간을 초기화

      // 달력 생성 : 해당 달에 맞춰 테이블을 만들고, 날짜를 채워 넣는다.
      function buildCalendar() {

          let firstDate = new Date(nowMonth.getFullYear(), nowMonth.getMonth(), 1);     // 이번달 1일
          let lastDate = new Date(nowMonth.getFullYear(), nowMonth.getMonth() + 1, 0);  // 이번달 마지막날

          let tbody_Calendar = document.querySelector(".Calendar > tbody");
          document.getElementById("calYear").innerText = nowMonth.getFullYear();             // 연도 숫자 갱신
          document.getElementById("calMonth").innerText = leftPad(nowMonth.getMonth() + 1);  // 월 숫자 갱신

          while (tbody_Calendar.rows.length > 0) {                        // 이전 출력결과가 남아있는 경우 초기화
              tbody_Calendar.deleteRow(tbody_Calendar.rows.length - 1);
          }

          let nowRow = tbody_Calendar.insertRow();        // 첫번째 행 추가           

          for (let j = 0; j < firstDate.getDay(); j++) {  // 이번달 1일의 요일만큼
              let nowColumn = nowRow.insertCell();        // 열 추가
          }

          for (let nowDay = firstDate; nowDay <= lastDate; nowDay.setDate(nowDay.getDate() + 1)) {   // day는 날짜를 저장하는 변수, 이번달 마지막날까지 증가시키며 반복  

              let nowColumn = nowRow.insertCell();        // 새 열을 추가하고


              let newDIV = document.createElement("p");
              newDIV.innerHTML = leftPad(nowDay.getDate());        // 추가한 열에 날짜 입력
              nowColumn.appendChild(newDIV);

              if (nowDay.getDay() == 6) {                 // 토요일인 경우
                  nowRow = tbody_Calendar.insertRow();    // 새로운 행 추가
              }

              if (nowDay < today) {                       // 지난날인 경우
                  newDIV.className = "pastDay";
              }
              else if (nowDay.getFullYear() == today.getFullYear() && nowDay.getMonth() == today.getMonth() && nowDay.getDate() == today.getDate()) { // 오늘인 경우           
                  newDIV.className = "today";
                  newDIV.onclick = function () { choiceDate(this); }
              }
              else {                                      // 미래인 경우
                  newDIV.className = "futureDay";
                  newDIV.onclick = function () { choiceDate(this); }
              }
          }
      }

      // 날짜 선택
      function choiceDate(newDIV) {
          if (document.getElementsByClassName("choiceDay")[0]) {                              // 기존에 선택한 날짜가 있으면
              document.getElementsByClassName("choiceDay")[0].classList.remove("choiceDay");  // 해당 날짜의 "choiceDay" class 제거
          }
          newDIV.classList.add("choiceDay");           // 선택된 날짜에 "choiceDay" class 추가
      }

      // 이전달 버튼 클릭
      function prevCalendar() {
          nowMonth = new Date(nowMonth.getFullYear(), nowMonth.getMonth() - 1, nowMonth.getDate());   // 현재 달을 1 감소
          buildCalendar();    // 달력 다시 생성
      }
      // 다음달 버튼 클릭
      function nextCalendar() {
          nowMonth = new Date(nowMonth.getFullYear(), nowMonth.getMonth() + 1, nowMonth.getDate());   // 현재 달을 1 증가
          buildCalendar();    // 달력 다시 생성
      }

      // input값이 한자리 숫자인 경우 앞에 '0' 붙혀주는 함수
      function leftPad(value) {
          if (value < 10) {
              value = "0" + value;
              return value;
          }
          return value;
      }    
    
    
    
    
    

</script>


</html>
