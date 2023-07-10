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



<!--  Google Font: Source Sans Pro -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome-->
<link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
<!-- Theme style-->
<link rel="stylesheet" href="dist/css/adminlte.min.css">

</head>

<body class="hold-transition sidebar-mini">

<!-- Site wrapper -->
<div class="wrapper">

	<jsp:include page = "index.jsp"></jsp:include>
	
	
  <div class="content-wrapper">
    <section class="content-header">
            <h1>자료실</h1>         
    </section>
    <!-- Main content -->
    <section class="content">
      <table class="table table-bordered table-hover dataTable dtr-inline">
    
		<div class="input-group" style="width: 30%;">
	    <input type="search" class="form-control form-control-lg" id="searchInput" placeholder="제목 또는 작성자를 입력" style="font-size: 13px;">
	    <div class="input-group-append">
	    <button id="searchButton" class="btn btn-lg btn-default"><alt="Search"><i class="fa fa-search"></i></button>
	    </div>
		</div>
		<input type ="hidden" id="adminchk" value= "${loginid}" />${loginid}
		
			<thead> 
				<tr> 
					<th>번호</th>
					<th>제목</th>
					<th></th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				
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
		<button onclick="location.href='archiveWrite.go'">글쓰기</button>
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
	   $.ajax({
	      type:'post',
	      url:'archivelist.ajax',
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




//list 받아와서 보여줌
function listPrint(list){
	   	var content ='';
	  	var count = (showPage - 1) * 10 + list.length;
	   	var totalItems = list.length;
		var isAdmin = document.getElementById('adminchk')    // 서버에서 가져온 관리자 여부 값
		
	   	list.forEach(function(item){
	      // 배열 요소들 반복문 실행 -> 행 구성 + 데이터 추가 
	      content +='<tr>';

	      content += '<td>' + count-- + '</td>'; // 번호를 반대로 표시
	      content +='<td>'+item.category +'</td>';
	      content +='<td><a href="archivedetail.do?id=' + item.id + '">'+item.subject +'</a></td>';
	      content += '<td>' + item.name + ' ( ' + item.user_id + ' ) ' + '</td>';
	      content +='<td id="userstate">'+ item.create_at +'</td>';
	      
	      content +='<td id="hit"> ' + item.hit + '</td>';
	      content +='</tr>';
	      
	   });
	   
	   // list 요소의 내용 지우고 추가 - 페이징 처리 
	   $('#list').empty();
	   $('#list').append(content);
	}	


























</script>
</html>