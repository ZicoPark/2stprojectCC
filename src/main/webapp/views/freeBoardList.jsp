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
            <h1>사내게시판</h1>         
    </section>
    <!-- Main content -->
    <section class="content">
    
   		<div class="search-container">
	    <input type="text" id="searchInput" placeholder="제목 또는 작성자를 입력">
	    <button id="searchButton"><alt="Search">검색</button>
		</div>
    
		<table class = "mokrok">
			<thead> 
				<tr> 
					<th>번호</th>
					<th>제목</th>
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
	   var count = (showPage - 1) * 10 + 1; // 각 페이지별로 시작 번호 계산
	   list.forEach(function(item){
	      
	      // 배열 요소들 반복문 실행 -> 행 구성 + 데이터 추가 
	      content +='<tr>';
	      content +='<td>'+ count++ +'</td>'; // 생성 순서대로 번호 증가
	      content +='<td>'+item.subject +'</td>';
	      content +='<td>'+item.user_id +'</td>';
	      content +='<td id="userstate"> ' + item.create_at + '</td>';
	      content +='<td id="hit"> ' + item.hit + '</td>';
	      content +='</tr>';
	      
	   });
	   
	   // list 요소의 내용 지우고 추가 - 페이징 처리 
	   $('#list').empty();
	   $('#list').append(content);
	}








</script>
</html>