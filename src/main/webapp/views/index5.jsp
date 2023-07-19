<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Creator Company</title>
<link rel="icon" href="/img/CC_favicon.png">
<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<!-- Ionicons -->
<link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<!--  Google Font: Source Sans Pro -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome-->
<link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
<!-- Tempusdominus Bootstrap 4 -->
<link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
<!-- overlayScrollbars-->
<link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
<!-- Theme style-->
<link rel="stylesheet" href="dist/css/adminlte.min.css">
  
  <style>
[class*=sidebar-dark-] .sidebar a {
    color: white;
}
[class*=sidebar-dark-] .sidebar a p {
    color: white;
}
  </style>
  
  
</head>
<body class="hold-transition sidebar-mini">
<!-- Site wrapper -->
<div class="wrapper">

  <!-- Navbar -->
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li>
      <li class="nav-item d-none d-sm-inline-block">
        <a href="../../index3.jsp" class="nav-link">Home</a>
      </li>
      <li class="nav-item d-none d-sm-inline-block">
        <a href="#" class="nav-link">Contact</a>
      </li>
    </ul>

    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto">
      <!-- Navbar Search -->
      <li class="nav-item">
        <a class="nav-link" data-widget="navbar-search" href="#" role="button">
          <i class="fas fa-search"></i>
        </a>
        <div class="navbar-search-block">
          <form class="form-inline">
            <div class="input-group input-group-sm">
              <input class="form-control form-control-navbar" type="search" placeholder="Search" aria-label="Search">
              <div class="input-group-append">
                <button class="btn btn-navbar" type="submit">
                  <i class="fas fa-search"></i>
                </button>
                <button class="btn btn-navbar" type="button" data-widget="navbar-search">
                  <i class="fas fa-times"></i>
                </button>
              </div>
            </div>
          </form>
        </div>
      </li>

      <!-- Messages Dropdown Menu -->
      <li class="nav-item dropdown">
        <a class="nav-link" data-toggle="dropdown" href="/chatRoom.go">
          <i class="far fa-comments"></i>
          <span class="badge badge-danger navbar-badge">숫자</span>
        </a>
        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
          <a href="#" class="dropdown-item">
            <!-- Message Start -->
            <div class="media">
              <img src="../../dist/img/user1-128x128.jpg" alt="User Avatar" class="img-size-50 mr-3 img-circle">
              <div class="media-body">
                <h3 class="dropdown-item-title">
                  Brad Diesel
                  <span class="float-right text-sm text-danger"><i class="fas fa-star"></i></span>
                </h3>
                <p class="text-sm">Call me whenever you can...</p>
                <p class="text-sm text-muted"><i class="far fa-clock mr-1"></i> 4 Hours Ago</p>
              </div>
            </div>
            <!-- Message End -->
          </a>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item">
            <!-- Message Start -->
            <div class="media">
              <img src="../../dist/img/user8-128x128.jpg" alt="User Avatar" class="img-size-50 img-circle mr-3">
              <div class="media-body">
                <h3 class="dropdown-item-title">
                  John Pierce
                  <span class="float-right text-sm text-muted"><i class="fas fa-star"></i></span>
                </h3>
                <p class="text-sm">I got your message bro</p>
                <p class="text-sm text-muted"><i class="far fa-clock mr-1"></i> 4 Hours Ago</p>
              </div>
            </div>
            <!-- Message End -->
          </a>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item">
            <!-- Message Start -->
            <div class="media">
              <img src="../../dist/img/user3-128x128.jpg" alt="User Avatar" class="img-size-50 img-circle mr-3">
              <div class="media-body">
                <h3 class="dropdown-item-title">
                  Nora Silvester
                  <span class="float-right text-sm text-warning"><i class="fas fa-star"></i></span>
                </h3>
                <p class="text-sm">The subject goes here</p>
                <p class="text-sm text-muted"><i class="far fa-clock mr-1"></i> 4 Hours Ago</p>
              </div>
            </div>
            <!-- Message End -->
          </a>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item dropdown-footer">See All Messages</a>
        </div>
      </li>
      
<!--       Notifications Dropdown Menu -->
<!--       <li class="nav-item dropdown show">
        <a class="nav-link" data-toggle="dropdown" href="">
          <i class="far fa-bell"></i>
          <span class="badge badge-warning navbar-badge">15</span>
        </a>
      <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right show" style="left: inherit; right: 0px;">
          <span class="dropdown-item dropdown-header">최신 알림</span>
          <div class="dropdown-divider"></div>
          
          
          <a href="#" class="dropdown-item">
            <i class="fas fa-envelope mr-2"></i> 4 new messages
            <span class="float-right text-muted text-sm">3 mins</span>
          </a>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item">
            <i class="fas fa-users mr-2"></i> 8 friend requests
            <span class="float-right text-muted text-sm">12 hours</span>
          </a>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item">
            <i class="fas fa-file mr-2"></i> 3 new reports
            <span class="float-right text-muted text-sm">2 days</span>
          </a>
              
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item dropdown-footer">알림 더보기</a>
        </div>
      </li> -->

<!-- 앙 알림띠 -->
<!-- Notifications Dropdown Menu -->
      <li class="nav-item dropdown">
        <a class="nav-link" data-toggle="dropdown" href="#">
          <i class="far fa-bell"></i>
          <span class="badge badge-warning navbar-badge">15</span>
        </a>
        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
          <span class="dropdown-item dropdown-header">15 Notifications</span>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item">
            <i class="fas fa-envelope mr-2"></i> 4 new messages
            <span class="float-right text-muted text-sm">3 mins</span>
          </a>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item">
            <i class="fas fa-users mr-2"></i> 8 friend requests
            <span class="float-right text-muted text-sm">12 hours</span>
          </a>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item">
            <i class="fas fa-file mr-2"></i> 3 new reports
            <span class="float-right text-muted text-sm">2 days</span>
          </a>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item dropdown-footer">See All Notifications</a>
        </div>
      </li>





      
      
      
      <!-- 알림 끝 -->


    </ul>
  </nav>
  <!-- /.navbar -->

  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4 bg-white">
    <!-- Brand Logo -->
    <a href="../../index3.jsp" class="brand-link">
      <img src="../../dist/img/KakaoTalk_20230613_164257782.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-10" style="opacity: .8">
      <span class="brand-text font-weight-light">CreatorCompany</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar bg-teal">
      <!-- Sidebar user (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
          <img src="../../dist/img/user2-160x160.jpg" class="img-circle elevation-2" alt="User Image">
        </div>
        <div class="info">
          <a href="/userinfo.go" class="d-block">${user.id}의 MyPage</a>
        </div>
      </div>

      <!-- SidebarSearch Form -->
      <div class="form-inline">
        <div class="input-group" data-widget="sidebar-search">
          <input class="form-control form-control-sidebar" type="search" placeholder="Search" aria-label="Search">
          <div class="input-group-append">
            <button class="btn btn-sidebar">
              <i class="fas fa-search fa-fw"></i>
            </button>
          </div>
        </div>
      </div>

      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
               
               
               
          <li class="nav-item">
            <a href="#" class="nav-link">
              <img src="../../dist/img/근태기록.png" class="nav-icon fas fa-tachometer-alt"/>
              <p>
                근태 관리
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="/workHistoryList.go" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>근태 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/workHolidayList.go" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>연차/휴가 관리</p>
                </a>
              </li>
            </ul>
          </li>
          
               <li class="nav-item">
            <a href="#" class="nav-link">
              <img src="../../dist/img/결재.png" class="nav-icon fas fa-tachometer-alt"/>
              <p>
                전자결재
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="/docWriteForm.go" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>새 문서 작성</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/tempDocList.go" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>임시저장함</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/requestDocList.go" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>결재요청함</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/requestDocWaitList.go" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>결재대기함</p>
                </a>
              </li>
            </ul>
          </li>
          
                    <li class="nav-item">
            <a href="/personal.go" class="nav-link">
              <img src="../../dist/img/개인 업무.png" class="nav-icon fas fa-tachometer-alt"/>
              <p>
                개인업무관리
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>

          </li>
          
  
          
                    <li class="nav-item">
            <a href="#" class="nav-link">
              <img src="../../dist/img/그룹 업무.png" class="nav-icon fas fa-tachometer-alt"/>
              <p>
                프로젝트 업무관리
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="projects.go" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>프로젝트</p>
                </a>
              </li>
            </ul>
          </li>
          
                    <li class="nav-item">
            <a href="#" class="nav-link">
              <img src="../../dist/img/쪽지.png" class="nav-icon fas fa-tachometer-alt"/>
              <p>
                쪽지
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="/msWrite.go" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>쪽지 작성</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/msSendList.go" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>보낸 쪽지함</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/msReceiveList.go" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>받은 쪽지함</p>
                </a>
              </li>
            </ul>
          </li>
          
          
                    <li class="nav-item">
            <a href="#" class="nav-link">
              <img src="../../dist/img/달력.png" class="nav-icon fas fa-tachometer-alt"/>
              <p>
                일정관리
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="/" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>부제목1</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/index2.go" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>부제목2</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="../../index3.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>부제목3</p>
                </a>
              </li>
            </ul>
          </li>
          
                    <li class="nav-item">
            <a href="#" class="nav-link">
              <img src="../../dist/img/부서리스트.png" class="nav-icon fas fa-tachometer-alt"/>
              <p>
                인사 관리
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="/userinfo.go" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>마이페이지</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/departmentlist.go" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>부서리스트</p>
                </a>
              </li>
            </ul>
          </li>
          
          
                    <li class="nav-item">
            <a href="#" class="nav-link">
              <img src="../../dist/img/게시판.png" class="nav-icon fas fa-tachometer-alt"/>
              <p>
                게시판
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="/archiveBoard.go" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>자료실</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/freeBoard.go" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>사내 게시판</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="../../index3.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>부제목3</p>
                </a>
              </li>
            </ul>
          </li>


                    <li class="nav-item">
            <a href="/noticeBoard.go" class="nav-link">
              <img src="../../dist/img/공지사항.png" class="nav-icon fas fa-tachometer-alt"/>
              <p>
                공지사항
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
          </li>
          
          
                    <li class="nav-item">
            <a href="#" class="nav-link">
               <img src="../../dist/img/통계.png" class="nav-icon fas fa-tachometer-alt"/>
              <p>
                통계

                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="/" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>자료실</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/freeBoardList" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>부서별게시판</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="../../index3.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>부제목3</p>
                </a>
              </li>
            </ul>
          </li>
          
  
                    <li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                관리자
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
            <li class="nav-item">
                <a href="/MemberList.go" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>사원 리스트</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/MemberONOFFList.go" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>사원 승인/삭제</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/workHistoryList_Ad.go" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>근태 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/workHolidayList_Ad.go" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>연차/휴가 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/workDailyList.go" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>일별 근태 현황</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/workWeekList.go" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>주별 근태 현황</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/workWornList.go" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>경고 리스트</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="#" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>재직상태 리스트</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/DeptCategory.go" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>부서 카테고리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/ArchiveCategory.go" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>자료실 카테고리</p>
                </a>
              </li>
            </ul>
          </li>
          
          
  		<li class="nav-item">
            <a href="/logout.do" class="nav-link">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                로그아웃
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
          </li>
          
          
          
          
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>
          <a href="/logout">로그아웃</a>


   <!-- 
   
   
   
   내용들어가는 부분 
   
   
   
    -->

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->


<!-- jQuery UI -->
<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>


</body>


<script>


/* 
속성( data-toggle)이 dropdown 일떄 쇼로 바꾸고  */


</script>


</html>