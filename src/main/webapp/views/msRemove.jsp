<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>휴지통</title>
<link rel="icon" href="/img/CC_favicon.png">
  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- icheck bootstrap -->
  <link rel="stylesheet" href="../../plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
</head>
<style>
.btn-primary {
    color: #fff;
    background-color: #20c997;
    border-color: #20c997;
    box-shadow: none;
}
  
.card-primary.card-outline {
    border-top: 3px solid #20c997;
}  

   .date {
    color: rgb(52 58 64 / 91%);
    font-size: 14px;
	text-align: right;

</style>
<body class="hold-transition sidebar-mini">
<jsp:include page = "index.jsp"></jsp:include>
<div class="wrapper">

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">휴지통</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="row">
	<!-- row 밑에  -->
	<div class="col-md-3">
	<a href="/msWrite.go" class="btn btn-primary btn-block mb-3">쪽지 작성</a>
	<div class="card">
	<div class="card-header">
	<h3 class="card-title">쪽지</h3>
	<div class="card-tools">
	<button type="button" class="btn btn-tool" data-card-widget="collapse">
	<i class="fas fa-minus"></i>
	</button>
	</div>
	</div>
	<div class="card-body p-0">
	<ul class="nav nav-pills flex-column">
	<li class="nav-item active">

	</li>
	<li class="nav-item">
	<a href="/msReceiveList.go" class="nav-link">
	<i class="fas fa-inbox"></i> 받은 쪽지
	</a>
	</li>
	<li class="nav-item">
	<a href="/msSendList.go" class="nav-link">
	<i class="far fa-file-alt"></i> 보낸 쪽지
	</a>
	</li>
	<li class="nav-item">
	<a href="/msRemoveList.go" class="nav-link">
	<i class="far fa-trash-alt"></i> 휴지통
	</a>
	</li>
	</ul>
	</div>
	
	</div>
	</div> 
	<!-- col-md-9 위에  -->  
        <div class="col-md-9">
          <div class="card card-primary card-outline">
            <div class="card-header">
  
      <div class="card-tools">
        <div class="input-group input-group-sm">              
			    <input type="text" id="searchInput" class="form-control" placeholder="제목 또는 작성자를 입력">
			    <div class="input-group-append">
			    <div class="btn btn-primary">
			    <i class="fas fa-search" id="searchButton"></i>
			    </div>
			</div>
	    </div>
	   </div> 
		<input type ="text" id="adminchk" value= "${loginid}" hidden />${loginid}
              <!-- /.card-tools -->
            </div>
            <!-- /.card-header -->
            <div class="card-body p-0">



                <!-- /.float-right -->
              </div>
              <div class="table-responsive mailbox-messages">
                <table class="table table-hover table-striped">
                                    
				
				<tbody id="list">

			</tbody>
			
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
                <!-- /.table -->
              </div>
              <!-- /.mail-box-messages -->
            </div>
            <!-- /.card-body -->

                <!-- /.float-right -->
              </div>
            </div>
          </div>
          <!-- /.card -->
    </section>
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
    <!-- /.content -->
  <!-- /.content-wrapper -->
  <footer class="main-footer">
 
  </footer>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->

<!-- ./wrapper -->

<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>
<!-- Page specific script -->

<script type="text/javascript" src="../../dist/js/jquery.twbsPagination.min.js"></script>

</body>

<script>

var showPage = 1;
var searchText = 'default';

listCall(showPage);
$('#searchButton').click(function(){
	   //검색어 확인 
	   searchText = $('#searchInput').val();
	   listCall(showPage);
	   searchText = 'default';
	   $('#pagination').twbsPagination('destroy');
	});
	
function listCall(page){
	
	console.log("휴지통 ajax 요청");
	
	   $.ajax({
	      type:'post',
	      url:'msRemovelist.ajax',
	      data:{
	         'page':page,
	         'search':searchText
	      },
	      dataType:'json',           
	      success:function(data){
	         console.log(data);
	         listPrint(data.list);
	         
	         // 페이징 처리를 위해 필요한 데이터
	         // 1. 총 페이지의 수
	         // 2. 현재 페이지
	         console.log(data.list); // arraylist 로 값 들어옴
	         var currentPage = 1;
	         // Paging Plugin (j-query의 기본기능을 가지고 만들었기 때문에  plugin)
	         $('#pagination').twbsPagination({
	         startPage:currentPage, // 시작 페이지
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

//list 받아와서 보여줌
function listPrint(list){
	   	var content ='';
	  	var count = (showPage - 1) * 10 + list.length;
	   	var totalItems = list.length;
		var isAdmin = document.getElementById('adminchk')    // 서버에서 가져온 관리자 여부 값
		
		if (list.length === 0) {
			  content += '<tr><td colspan="6">쪽지가 존재하지 않습니다.</td></tr>';
			} else {
			  list.forEach(function(item) {
			    var sendAt = new Date(item.send_at);
			    var currentDate = new Date();
	
			    var formattedDate;

			    // 배열 요소들 반복문 실행 -> 행 구성 + 데이터 추가
			    content += '<tr>';
			    content += '<td><input type="hidden" value="' + item.id + '"></td>';
			    content += '<td>' + item.name + '</td>';
			    content += '<td><a href="msSendDetail.do?id=' + item.id + '">' + item.title + '</a></td>';
			    
			    if (
					      sendAt.getDate() === currentDate.getDate() &&
					      sendAt.getMonth() === currentDate.getMonth() &&
					      sendAt.getFullYear() === currentDate.getFullYear()
					    ) {
					      formattedDate = sendAt.toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit' });
					    } else {
					      formattedDate = sendAt.toLocaleDateString('ko-KR', { year: '2-digit', month: '2-digit', day: '2-digit' });
					    }
					    content += '<td class="date">' + formattedDate + '</td>';
					    content += '</tr>';
					  });
					}

	   
	   // list 요소의 내용 지우고 추가 - 페이징 처리 
	   $('#list').empty();
	   $('#list').append(content);
	}	
  






   
  

</script>

</html>
