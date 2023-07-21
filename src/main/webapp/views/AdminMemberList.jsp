<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="kr.co.cc.admin.service.AdminService" %>
<%@ page import="kr.co.cc.admin.dto.AdminDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html lang="en">
<style>
    .row {
        float: right;
    }
    .container {
        float: right;
    }
	#btn{
		border-top-left-radius: 5px;
		border-top-right-radius: 5px;
		border-bottom-left-radius: 5px;
		border-bottom-right-radius: 5px;
	}
	#but button{
		border: 1px solid #20c997;
		background-color: rgba(0,0,0,0);
		color: #20c997;
	}
	#but button:hover{
		color: white;
		background-color: #20c997;
	}
</style>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>관리자 회원 리스트</title>
<link rel="icon" href="/img/CC_favicon.png">
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
		<h1>관리자 회원 리스트</h1>         
    </section>
    <!-- Main content -->
	<section class="content">
	    <div class="container">
			<div class="row">
				<form method="post" name="search" action="/MemberSearch.go">
					<table class="pull-right">
						<tr>
							<td>
								<select class="form-control" name="searchField">
									<option value="0">선택</option>
									<option value="name">이름</option>
									<option value="id">아이디</option>
									<option value="dept_name">부서</option>
								</select>
							</td>
							<td>
								<input type="text" class="form-control"
								placeholder="검색어 입력" name="searchText" maxlength="100">
							</td>
							<td>
								<button type="submit" class="btn btn-success">검색</button>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<br/>
		<br/>
			<table class="table table-bordered">
				<tr>
					<th>번호</th>
					<th>이름</th>
					<th>아이디</th>
					<th>부서</th>
					<th>계정상태</th>
					<th>관리자여부</th>
					<th>상세보기</th>
				</tr>
				<c:if test="${empty param.searchField}">
				<!-- 기존의 리스트 출력 -->
					<c:forEach items="${list}" var="member" varStatus="loop">
						<tr>
				    		<td>${fn:length(list) - loop.index}</td>
							<td>${member.name}</td>
							<td>${member.user_id}</td>
							<td>${member.dept_name}</td>
							<td><span style="color: ${member.status ? 'blue' : 'red'}; display: inline-block; text-align: center; width: 100%;">${member.status ? '재직' : '퇴사'}</span></td>
							<td><span style="color: ${member.admin_chk ? 'blue' : 'red'}; display: inline-block; text-align: center; width: 100%;">${member.admin_chk ? '관리자' : '사원'}</span></td>
							<td id="but">
						    	<button id="btn" onclick="location.href='AdminMemberDetail.go?id=${member.id}'">상세보기</button>
						    </td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${not empty param.searchField}">
				<%-- 검색 결과 출력 --%>
			    	<%
				    	AdminService adminService = new AdminService();
				    	ArrayList<AdminDTO> list = adminService.MemberSearch(request.getParameter("searchField"), request.getParameter("searchText"));
				
				    	if (list == null || list.size() == 0) {
				        	out.println("<script>");
				        	out.println("alert('검색결과가 없습니다.')");
				        	out.println("location.href='MemberList.go'");
				        	out.println("</script>");
				    	} else {
				        	// 검색 결과가 있을 때의 출력
				        	for (int i = 0; i < list.size(); i++) {
				    %>
				    		<tr>
						    	<td><%=list.size() - i %></td>
						        <td><%=list.get(i).getName()%></td>
						        <td><%=list.get(i).getUser_id()%></td>
						        <td><%=list.get(i).getDept_name()%></td>
						        <td><span style="color: <%=list.get(i).getStatus() ? "blue" : "red"%>; display: inline-block; text-align: center; width: 100%;"><%=list.get(i).getStatus() ? "재직": "퇴사"%></span></td>
						        <td><span style="color: <%=list.get(i).getAdmin_chk() ? "blue" : "red"%>; display: inline-block; text-align: center; width: 100%;"><%=list.get(i).getAdmin_chk() ? "관리자" : "사원"%></span></td>
						        <td id="but">
						            <button id="btn" onclick="location.href='AdminMemberDetail.go?id=<%=list.get(i).getUser_id()%>'">상세보기</button>
						        </td>
				    		</tr>
				    <%
				        }
				    }
				    %>
				</c:if>
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
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>
</body>
<script>

</script>
</html>