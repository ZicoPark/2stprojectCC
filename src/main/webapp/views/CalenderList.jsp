<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<style>
	#save{
		position: relative;
		top: -9px;
		left: 9px
	}
</style>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>AdminLTE 3 | Calendar</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../plugins/fontawesome-free/css/all.min.css">
  <!-- fullCalendar -->
  <link rel="stylesheet" href="../plugins/fullcalendar/main.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../dist/css/adminlte.min.css">
</head>
<body class="hold-transition sidebar-mini">
<jsp:include page = "index.jsp"></jsp:include>
<div class="wrapper">
	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper">
		<form action="CalenderListsave.go" name="event" method="post">
		<!-- Content Header (Page header) -->
		<section class="content-header">
			<div class="container-fluid">
				<div class="row mb-2">
					<div class="col-sm-6">
						<h1>Calendar</h1>
					</div>
					<div class="col-sm-6">
						<ol class="breadcrumb float-sm-right">
							<li class="breadcrumb-item"><a href="main.go">Home</a></li>
							<li class="breadcrumb-item active">Calendar</li>
						</ol>
					</div>
				</div>
			</div><!-- /.container-fluid -->
		</section>
	<!-- Main content -->
	<section class="content">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-3">
					<div class="sticky-top mb-3">
						<div class="card">
							<div class="card-header">
								<h4 class="card-title">이벤트 목록</h4>
							</div>
							<div class="card-body">
							<!-- the events -->
								<div id="external-events">
									<div class="external-event bg-success" draggable="true">점심 시간</div>
									<div class="external-event bg-warning" draggable="true">퇴근 시간</div>
									<div class="external-event bg-info" draggable="true">휴식 시간</div>
									<div class="external-event bg-primary" draggable="true">작업 시간</div>
									<div class="external-event bg-danger" draggable="true">수면 시간</div>
									<div class="checkbox">
										<label for="drop-remove">
											<input type="checkbox" id="drop-remove">
												드래그로 목록에서 삭제
										</label>
									</div>
								</div>
							</div>
						<!-- /.card-body -->
						</div>
					<!-- /.card -->
					<div class="card">
						<div class="card-header">
							<h3 class="card-title">이벤트 생성</h3>
						</div>
							<div class="card-body">
							<div class="btn-group" style="width: 100%; margin-bottom: 10px;">
								<ul class="fc-color-picker" id="color-chooser">
									<li><a class="text-primary" href="#"><i class="fas fa-square"></i></a></li>
									<li><a class="text-warning" href="#"><i class="fas fa-square"></i></a></li>
									<li><a class="text-success" href="#"><i class="fas fa-square"></i></a></li>
									<li><a class="text-danger" href="#"><i class="fas fa-square"></i></a></li>
									<li><a class="text-muted" href="#"><i class="fas fa-square"></i></a></li>
								</ul>
							</div>
								<!-- /btn-group -->
								<div class="input-group">
									<input id="new-event" type="text" class="form-control" placeholder="이벤트 이름">
									<div class="input-group-append">
										<button id="add-new-event" type="button" class="btn btn-primary">추가</button>
									</div>
								<!-- /btn-group -->
								</div>								
							<!-- /input-group -->
							</div>
						</div>
						<!-- <div class="card">
							<div class="card-header">
								<h4 class="card-title">이벤트 삭제</h4>
							</div>
							<div class="card-body">
								<div id="external-events">
									<button class="btn btn-primary">삭제</button>
								</div>
							</div>
						</div> -->             
					</div>
				</div>
					<!-- /.col -->
					<div class="col-md-9">
						<div class="card card-primary">
							<div class="card-body p-0">
			                <!-- THE CALENDAR -->
								<div id="calendar"></div>
							</div>
							<!-- /.card-body -->
						</div>
			            <!-- /.card -->
					</div>
					<!-- /.col -->
				</div>
			<!-- /.row -->
			</div><!-- /.container-fluid -->
    	</section>
		<!-- /.content -->
    	<button id="save"type="submit" class="btn btn-primary">저장</button>
	</form>
</div>
<!-- /.content-wrapper -->

  <footer class="main-footer">
    <div class="float-right d-none d-sm-block">
      <b>Version</b> 3.2.0
    </div>
    <strong>Copyright &copy; 2014-2021 <a href="https://adminlte.io">AdminLTE.io</a>.</strong> All rights reserved.
  </footer>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->

<!-- jQuery -->
<script src="../plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- jQuery UI -->
<script src="../plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- AdminLTE App -->
<script src="../dist/js/adminlte.min.js"></script>
<!-- fullCalendar 2.2.5 -->
<script src="../plugins/moment/moment.min.js"></script>
<script src="../plugins/fullcalendar/main.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../dist/js/demo.js"></script>
<!-- Page specific script -->
<script>	
  $(function () {

    /* 외부 이벤트 초기화
     -----------------------------------------------------------------*/
    function ini_events(ele) {
      ele.each(function () {

        // 이벤트 객체 생성 (https://fullcalendar.io/docs/event-object)
        // 시작 또는 종료일이 필요하지 않음	
        var eventObject = {
          title: $.trim($(this).text()) // 해당 요소의 텍스트를 이벤트 제목으로 사용
        }

        // 나중에 사용할 수 있도록 이벤트 개체를 DOM 요소에 저장
        $(this).data('eventObject', eventObject)

        // jQuery UI를 사용하여 이벤트를 드래그 가능하게 만들기
        $(this).draggable({
          zIndex        : 1070,
          revert        : true, // 이벤트가 원래 상태로 돌아가게 하기
          revertDuration: 0  //  드래그 후 원래위치
        })

      })
    }

    ini_events($('#external-events div.external-event'))

    /* 달력 초기화
     -----------------------------------------------------------------*/
    // 달력 이벤트용 날짜(더미데이터)
    var date = new Date()
    var d    = date.getDate(),
        m    = date.getMonth(),
        y    = date.getFullYear()

    var Calendar = FullCalendar.Calendar;
    var Draggable = FullCalendar.Draggable;

    var containerEl = document.getElementById('external-events');
    var checkbox = document.getElementById('drop-remove');
    var calendarEl = document.getElementById('calendar');

    // 외부 이벤트 초기화
    // -----------------------------------------------------------------

    new Draggable(containerEl, {
      itemSelector: '.external-event',
      eventData: function(eventEl) {
        return {
          title: eventEl.innerText,
          backgroundColor: window.getComputedStyle( eventEl ,null).getPropertyValue('background-color'),
          borderColor: window.getComputedStyle( eventEl ,null).getPropertyValue('background-color'),
          textColor: window.getComputedStyle( eventEl ,null).getPropertyValue('color'),
        };
      }
    });

    var calendar = new Calendar(calendarEl, {
      headerToolbar: {
        left  : 'prev,next today',
        center: 'title',
        right : 'dayGridMonth,timeGridWeek,timeGridDay'
      },
      themeSystem: 'bootstrap',
      // 랜덤 기본 이벤트
      events: [],
      editable  : true,
      droppable : true, // true일시 일정에 항목놓기 가능 !!!
      drop      : function(info) {
        // 삭제 후 제거 확인란이 선택되었는가?
        if (checkbox.checked) {
          // 그렇다면 드래그 가능한 이벤트 목록에서 요소를 제거하기
			info.draggedEl.parentNode.removeChild(info.draggedEl);
        	}
        },
      eventClick : function(info) {
          //delete event from calender
         info.event.remove();
      }
      
      
    });

    calendar.render();
    // $('#calendar').fullCalendar()

    /* 이벤트 추가 */
    var currColor = '#3c8dbc' //red를 기본값으로
    // 색상 선택 버튼
    $('#color-chooser > li > a').click(function (e) {
      e.preventDefault()
      // 색상 저장
      currColor = $(this).css('color')
      // 버튼에 색상 효과 추가
      $('#add-new-event').css({
        'background-color': currColor,
        'border-color'    : currColor
      })
    })
    $('#add-new-event').click(function (e) {
      e.preventDefault()
      // 값을 가져오고 null이 아닌지 확인
      var val = $('#new-event').val()
      if (val.length == 0) {
        return
      }

      // 이벤트 생성
      var event = $('<div />')
      event.css({
        'background-color': currColor,
        'border-color'    : currColor,
        'color'           : '#fff'
      }).addClass('external-event')
      event.text(val)
      $('#external-events').prepend(event)

      // 드래그 기능 추가
      ini_events(event)

      // 텍스트 입력에서 이벤트를 제거
      $('#new-event').val('')
    })
    
    
  })
  // 안쓰는거
          /* {
          title          : 'All Day Event',
          start          : new Date(y, m, 1),
          backgroundColor: '#f56954', //red
          borderColor    : '#f56954', //red
          allDay         : true
        },
        {
          title          : 'Long Event',
          start          : new Date(y, m, d - 5),
          end            : new Date(y, m, d - 2),
          backgroundColor: '#f39c12', //yellow
          borderColor    : '#f39c12' //yellow
        },
        {
          title          : 'Meeting',
          start          : new Date(y, m, d, 10, 30),
          allDay         : false,
          backgroundColor: '#0073b7', //Blue
          borderColor    : '#0073b7' //Blue
        },
        {
          title          : 'Lunch',
          start          : new Date(y, m, d, 12, 0),
          end            : new Date(y, m, d, 14, 0),
          allDay         : false,
          backgroundColor: '#00c0ef', //Info (aqua)
          borderColor    : '#00c0ef' //Info (aqua)
        },
        {
          title          : 'Birthday Party',
          start          : new Date(y, m, d + 1, 19, 0),
          end            : new Date(y, m, d + 1, 22, 30),
          allDay         : false,
          backgroundColor: '#00a65a', //Success (green)
          borderColor    : '#00a65a' //Success (green)
        },
        {
          title          : 'Click for Google',
          start          : new Date(y, m, 28),
          end            : new Date(y, m, 29),
          url            : 'https://www.google.com/',
          backgroundColor: '#3c8dbc', //Primary (light-blue)
          borderColor    : '#3c8dbc' //Primary (light-blue)
        } */
</script>
</body>
</html>
