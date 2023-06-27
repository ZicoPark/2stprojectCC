<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>AdminLTE 3 | Read Mail</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
</head>
<body class="hold-transition sidebar-mini">

<div class="wrapper">
  <!-- Navbar -->
  

  <table id="keywords" cellspacing="0" cellpadding="0">
  <h3>주소록</h3>
    <thead>
      <tr>
      	<th><input type="checkbox" id="all"/></th>
        <th><span>이름</span></th>
        <th><span>ID</span></th>
        <th><span>부서</span></th>
        <th><span>직급</span></th>
        
      </tr>
    </thead>
    <tbody>
    <c:forEach items="${list}" var="list">
      <tr>
        <td><input type="checkbox"/></td>
        
        <td>${list.name}</td>
        <td>${list.id}</td>
        <td>${list.dept_name}</td>
        <td>${list.job_name}</td>
      </tr>
     </c:forEach>
    </tbody>
  </table>
  
  <td><input type="button" value="확인"/></td>
					
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
 
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->
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

<script>

$('#all').click(function(e){
	   var $chk = $('input[type="checkbox"]');
	   	
	   if($(this).is(':checked')){
	      $chk.prop('checked',true);
	   }else{
	      $chk.prop('checked',false);
	   }
		console.log($chk);
	 

	   });

</script>
</body>
</html>