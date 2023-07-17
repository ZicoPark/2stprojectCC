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
table {
  border-collapse: collapse;
  border-spacing: 0;
}
section.notice {
  padding: 20px 0;
}

.page-title {
  margin-bottom: 10px;
}
.page-title h3 {
  font-size: 28px;
  color: #333333;
  font-weight: 400;
  text-align: center;
}

#board-search .search-window {
  padding: 15px 0;
  background-color: #f4f6f9;
}
#board-search .search-window .search-wrap {
  position: relative;
/*   padding-right: 124px; */
  margin: 0 auto;
  width: 80%;
  max-width: 564px;
}
#board-search .search-window .search-wrap input {
  height: 40px;
  width: 100%;
  font-size: 14px;
  padding: 7px 14px;
  border: 1px solid #ccc;
}
#board-search .search-window .search-wrap input:focus {
  border-color: #333;
  outline: 0;
  border-width: 1px;
}
#board-search .search-window .search-wrap .btn {
  position: absolute;
  right: 0;
  top: 0;
  bottom: 0;
  width: 108px;
  padding: 0;
  font-size: 16px;
}

.board-table {
  font-size: 13px;
  width: 100%;
  border-top: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
}

.board-table a {
  color: #333;
  display: inline-block;
  line-height: 1.4;
  word-break: break-all;
  vertical-align: middle;
}
.board-table a:hover {
  text-decoration: underline;
}
.board-table th {
  text-align: center;
}

.board-table .th-num {
  width: 100px;
  text-align: center;
}

.board-table .th-date {
  width: 200px;
}

.board-table th, .board-table td {
  padding: 14px 0;
}

.board-table tbody td {
  border-top: 1px solid #e7e7e7;
  text-align: center;
}

.board-table tbody th {
  padding-left: 28px;
  padding-right: 14px;
  border-top: 1px solid #e7e7e7;
  text-align: left;
}

.board-table tbody th p{
  display: none;
}

.btn {
  display: inline-block;
  padding: 0 30px;
  font-size: 15px;
  font-weight: 400;
  background: transparent;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  -ms-touch-action: manipulation;
  touch-action: manipulation;
  cursor: pointer;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
  border: 1px solid transparent;
  text-transform: uppercase;
  -webkit-border-radius: 0;
  -moz-border-radius: 0;
  border-radius: 0;
  -webkit-transition: all 0.3s;
  -moz-transition: all 0.3s;
  -ms-transition: all 0.3s;
  -o-transition: all 0.3s;
  transition: all 0.3s;
}

.btn-dark {
  background: #fff0;
  color: #20c997;
}

.btn-dark:hover, .btn-dark:focus {
  background: #373737;
  border-color: #373737;
  color: #fff;
}



/* reset */

* {
  list-style: none;
  text-decoration: none;
  padding: 0;
  margin: 0;
  box-sizing: border-box;
}
.clearfix:after {
  content: '';
  display: block;
  clear: both;
}
.container {
  width: 1100px;
  margin: 10px;
}
.blind {
  position: absolute;
  overflow: hidden;
  clip: rect(0 0 0 0);
  margin: -1px;
  width: 1px;
  height: 1px;
}

.page-link {
  color: #000; 
  background-color: #fff;
  border: 1px solid #ccc; 
}

.page-item.active .page-link {
 z-index: 1;
 color: #555;
 font-weight:bold;
 background-color: #f1f1f1;
 border-color: #ccc;
 
}

.page-link:focus, .page-link:hover {
  color: #000;
  background-color: #fafafa; 
  border-color: #ccc;
}

</style>

<body>


<jsp:include page = "index.jsp"></jsp:include>

<!-- Site wrapper -->
<div class="wrapper" style = " background-color: ##ffffff;">




  <div class="content-wrapper"  style = "background-color: ##ffffff;">
	<section class="notice">
	  <div class="page-title">
	        <div class="container">
	            <h3>사내게시판</h3>
	        </div>
	    </div>
    <!-- Main content -->
    <section class="content">
    <!--  <table class="table table-bordered table-hover dataTable dtr-inline"> -->
     
     
     
    <!-- board seach area -->
    <div id="board-search">
        <div class="container">
            <div class="search-window">
               <div class="search-wrap">
                   <label for="search" class="blind">공지사항 내용 검색</label>
                   <input id="searchInput" type="search" name="" placeholder="검색어를 입력해주세요." value="">
                   <button id="searchButton" class="btn btn-dark"><alt="Search"><i class="fa fa-search"></i></button>
       			</div>                
      		</div>                  
	    </div>                    
	  </div>                      
                           		
<!-- 		<div class="input-group" style="width: 30%;">
	    <input type="search" class="form-control form-control-lg" id="searchInput" placeholder="제목 또는 작성자를 입력" style="font-size: 13px;"/>
	    <div class="input-group-append">
	    <button id="searchButton" class="btn btn-lg btn-default"><alt="Search"><i class="fa fa-search"></i></button>
	    </div>
	    </div> -->
  <button onclick="location.href='freeWrite.go'">글 작성</button>  
  <!-- board list area -->
    <div id="board-list">
        <div class="container">
            <table class="board-table">


			<thead> 
                <tr>
                    <th scope="col" class="th-num">번호</th>
                    <th scope="col" class="th-title">제목</th>
                    <th>작성자</th>
                    <th scope="col" class="th-date">등록일</th>
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

<script type="text/javascript" src="../../dist/js/jquery.twbsPagination.min.js"></script>
</body>
<script>

var showPage = 1;
var searchText = 'default';

listCall(showPage);

//검색어에 따른 출력 
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
	      url:'Freelist.ajax',
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

// list 받아와서 보여줌
function listPrint(list){
	   var content ='';
	   var count = (showPage - 1) * 10 + list.length;
	   var totalItems = list.length;
	   list.forEach(function(item){
	      
	      // 배열 요소들 반복문 실행 -> 행 구성 + 데이터 추가 
	      content +='<tr>';
	      content += '<td>' + count-- + '</td>'; // 번호를 반대로 표시
	      content +='<td><a href="freedetail.do?id=' + item.id + '">'+item.subject +'</a></td>';
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