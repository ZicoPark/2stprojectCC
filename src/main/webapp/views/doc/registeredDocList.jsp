<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Creator Company</title>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>

<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<link rel="stylesheet" href="/plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="/dist/css/adminlte.min.css">
<style>
</style>
</head>
<body>
	<jsp:include page="../index.jsp"/>
	<!-- Site wrapper -->
	<div class="wrapper">
		<div class="content-wrapper">
			<section class="content-header">
				<h1>등록문서함 목록</h1>
			</section>
			<!-- Main content -->
			<section class="content">
				<select name="searchDept" id="searchDept">
					<c:if test="${deptList.size() > 0 }">
						<c:forEach items="${deptList }" var="list">
							<option value="${list.id }">${list.name }</option>
						</c:forEach>
					</c:if>
				</select>
				<select name="searchOpt" id="searchOpt">
					<option value="searchSubject">제목</option>
					<option value="searchCreateMember">기안자</option>
				</select>
				<input type="text" name="searchText" id="searchText" value=""/>
				<input type="button" value="검색" onclick="searchDoc()"/>
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>순번</th>
							<th>문서종류</th>
							<th>제목</th>
							<th>생산부서</th>
							<th>기안자</th>
							<th>문서등록시각</th>
						</tr>
					</thead>
					<tbody id="list">
						<tr>
							<td colspan="6">표시할 문서가 없습니다.</td>
						</tr>
					</tbody>
					<tr>
						<td colspan="6" id="paging">	
							<!-- 	플러그인 사용	(twbsPagination)	-->
							<div class="container">									
								<nav aria-label="Page navigation" style="text-align:center">
									<ul class="pagination" id="pagination"></ul>
								</nav>					
							</div>
						</td>
					</tr>
				</table>
			</section>
		</div>
	</div>
</body>
<!-- Bootstrap 4 -->
<script src="/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="/dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="/dist/js/demo.js"></script>

<script src="/dist/js/jquery.twbsPagination.min.js" type="text/javascript"></script>
<script>
var showPage = 1;

var defaultDeptId = '${deptId}';
var defaultOpt = '';
var defaultText = '';

listCall(showPage, defaultDeptId, defaultOpt, defaultText);

function searchDoc(){
	
	var searchDeptId = document.getElementById('searchDept').value;
	var searchOpt = document.getElementById('searchOpt').value;
	var searchText = document.getElementById('searchText').value;
	
	$('#pagination').twbsPagination('destroy');
	listCall(showPage, searchDeptId, searchOpt, searchText);
	
}

function listCall(page, deptId, opt, text){

	$.ajax({
		
		type:'post',
		url:'registeredDocList.ajax',
		data:{
			page:page,
			deptId:deptId,
			opt:opt,
			text:text
		},
		dataType:'json',
		success:function(data){
			console.log(data);
			printList(data.docList);

			var visiblePages = data.pages;
			
			if(data.pages>5){
				visiblePages = 5;
			}
			//paging plugin
			$('#pagination').twbsPagination({
				startPage:data.currPage,		//시작페이지
				totalPages:data.pages,	//총 페이지 수
				visiblePages:visiblePages,		//보여줄 페이지 [1][2][3][4][5]
				onPageClick:function(event,page){//페이지 클릭 시 동작되는 콜백함수
					console.log(event,showPage);
					//중간정도 페이지에서 게시물 갯수를 변경하면 1페이지로 초기화되는 문제가 있다.
					//listCall 시에 초기값 1로 설정해 둔 showPage를 현재 페이지로 변경한다.
					
					if(page != showPage){
						showPage = page;
						listCall(page, deptId, opt, text);
					}
				}
			});
		},
		error:function(e){
			console.log(e);
		}
		
	});
}

function printList(list){
	
	var content = '';
	
	console.log('list 사이즈 : '+list.length);
	
	if(list.length==0){
		
		content += '<tr>';
		content += '<td colspan="6">표시할 문서가 없습니다.</td>';
		content += '</tr>';
		
		$('#list').empty();
		$('#list').append(content);
		
	}else{
		
		list.forEach(function(item, number){
			
			content += '<tr>';
			content += '<td>'+(list.length-number)+'</td>';
			content += '<td>'+item.doc_form_name+'</td>';
			content += '<td>'+'<a href="registeredDocDetail.go?id='+item.id+'">'+item.subject+'</a></td>';
			content += '<td>'+item.production_dept_name+'</td>';
			content += '<td>'+item.create_member_name+'</td>';
			content += '<td>'+item.approval_at+'</td>';
			content += '</tr>';
			
			$('#list').empty();
			$('#list').append(content);
			
		});
		
	}
	

	
}

var msg='${msg}';

if(msg != ''){
	alert(msg);
}
</script>
</html>