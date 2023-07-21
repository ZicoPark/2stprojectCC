<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>직원 리스트</title>
<link rel="icon" href="/img/CC_favicon.png">
  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">

<style>
    /* Add custom CSS here */
    #board-search {
        text-align: left;
    }
</style>
</head>
<body>
<jsp:include page = "index.jsp"></jsp:include>
<!-- Site wrapper -->
<div class="wrapper">
  <div class="content-wrapper">
    <section class="content-header">
    	<h1>직원 리스트</h1>         
    </section>

    <section class="content">
    
    

    <div id="board-search">
        <div class="search-window">
               <div class="search-wrap">
                   <label for="search">아이디, 이름, 이메일　검색　</label>
                   <input id="searchInput" type="search" name="" placeholder="검색어를 입력해주세요." value="">
                   <button id="searchButton" class="btn btn-dark"><alt="Search"><i class="fa fa-search"></i></button>
       			</div>                
      		</div>                  
                  
	  </div>

    	
      <table class="table table-bordered table-hover dataTable dtr-inline">
         <thead> 
            <tr> 
               <th>아이디</th>
               <th>이름</th>
               <th>이메일</th>
               <th>부서</th>
               <th>직급</th>
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

<script type="text/javascript" src="../../dist/js/jquery.twbsPagination.min.js"></script>
</body>
<script>

	var showPage = 1;
	var searchText = 'default';
	var selectedDept = 'default';
	var selectedLevel = 'default';


	var departmentLookup = {
	    '8e5f3282-1703-11ee-973f-0242ac110002': '총무팀',
	    '8ee07433-1703-11ee-973f-0242ac110002': '기획팀',
	    '8f963853-1703-11ee-973f-0242ac110002': '촬영팀',
	    '9022f64a-1703-11ee-973f-0242ac110002': '편집팀'
	};

	var jobLevelLookup = {
		'8ade9167-1703-11ee-973f-0242ac110002' : '팀원',
	    '8bbf948d-1703-11ee-973f-0242ac110002' : '팀장',
	    '8c4e7542-1703-11ee-973f-0242ac110002' : '이사',
	    '8cdd8503-1703-11ee-973f-0242ac110002' : '사장'
	};


	
	
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
	      url:'departmentlist.ajax',
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
	      
		  var department = departmentLookup[item.dept_id] || '알 수 없는 부서';
	      var jobLevel = jobLevelLookup[item.job_level_id] || '알 수 없는 직급';
		   
		   
	      // 배열 요소들 반복문 실행 -> 행 구성 + 데이터 추가 
	      content +='<tr>';
	      
	      content += '<td>' + item.user_id + '</td>';
	      content += '<td>' + item.name + '</td>';
	      content += '<td>' + item.email + '</td>';
	      content += '<td>' + department  + '</td>';
	      content += '<td>' + jobLevel  + '</td>';
	      
	      content +='</tr>';
	      
	   });
	   
	   // list 요소의 내용 지우고 추가 - 페이징 처리 
	   $('#list').empty();
	   $('#list').append(content);
	}
</script>
</html>