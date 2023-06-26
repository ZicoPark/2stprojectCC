<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원가입</title>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- icheck bootstrap -->
  <link rel="stylesheet" href="../../plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  
  <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
  
  <!-- 부트스트랩 JavaScript 파일 불러오기 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

<style>
.register-box {
    width: 30%;
    height: 80%;
}

</style>
</head>
<body class="hold-transition register-page">
<div class="register-box">
  <div class="register-logo">
    <b>Creator</b>Company
  </div>

  <div class="card">
    <div class="card-body register-card-body">

      <form action="join.do" method="post">
      
        <div class="input-group mb-3">
          <input type="text" class="form-control" name="id" placeholder="사용하고자 하는 id를 입력하세요">
          <div class="input-group-append">
            <div class="input-group-text"></div>
          </div>
        </div>
        
        <div class="input-group mb-3">
          <input type="password" class="form-control" name="password" placeholder="비밀번호를 입력하세요">
          <div class="input-group-append">
            <div class="input-group-text"></div>
          </div>
        </div>
        
        <div class="input-group mb-3">
          <input type="password" class="form-control" placeholder="비밀번호를 다시 확인합니다">
          <div class="input-group-append">
            <div class="input-group-text"></div>
          </div>
        </div>
            
        <div class="input-group mb-3">
          <input type="text" class="form-control" name="name" placeholder="이름을 입력해주세요">
          <div class="input-group-append">
            <div class="input-group-text"></div>
          </div>
        </div>
        
        <div class="input-group mb-3">
          <input type="text" class="form-control" id="birthday" name="birth_date" placeholder="생일을 선택해주세요">
          <div class="input-group-append">
            <div class="input-group-text"></div>
          </div>
        </div>
        
        <div class="input-group mb-3">
          <input type="text" class="form-control" id="hiredate" name="hire_date" placeholder="입사일을 선택해주세요">
          <div class="input-group-append">
            <div class="input-group-text"></div>
          </div>
        </div>
        
        <div class="input-group mb-3">
          <select name="job_name" id="job_name" class="form-control">
          	<option value="사원">사원</option>
		  	<option value="대리">대리</option>
		  	<option value="팀장">팀장</option>
      	  </select>
          <div class="input-group-append">
            <div class="input-group-text"></div>
          </div>
        </div>
        
        <div class="input-group mb-3">
          <select name="dept_name" id="dept_name" class="form-control">
          	<option value="총무팀">총무팀</option>
		  	<option value="촬영팀">촬영팀</option>
		  	<option value="편집팀">편집팀</option>
		  	<option value="배포팀">배포팀</option>
      	  </select>
          <div class="input-group-append">
            <div class="input-group-text"></div>
          </div>
        </div>
        
        <div class="input-group mb-3">
          <input type="email" class="form-control" name="email" placeholder="Email">
          <div class="input-group-append">
            <div class="input-group-text"></div>
          </div>
        </div>
              
        <div class="input-group mb-3">
          <input type="text" class="form-control" name="phone" placeholder="'-'를 포함해서 연락처를 입력해주세요">
          <div class="input-group-append">
            <div class="input-group-text"></div>
          </div>
        </div>
        
        <div class="input-group mb-3">
          <input type="text" class="form-control" name="picture" placeholder="프로필 사진으로 쓸 사진을 등록해주세요">
          <div class="input-group-append">
            <div class="input-group-text"></div>
          </div>
        </div>
        <div class="row">
          <div class="col-8">
          </div>
          <!-- /.col -->
          <div class="col-4">
            <button type="submit" class="btn btn-primary btn-block">회원등록</button>
          </div>
          <!-- /.col -->
        </div>
      </form>

      <a href="./" class="text-center">이미 회원가입이 되어 있습니다.</a>
    </div>
    <!-- /.form-box -->
  </div><!-- /.card -->
</div>
<!-- /.register-box -->

</body>
<script>
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
	
	$(function() {
		  $("#birthday").datepicker({
		    dateFormat: "yy-mm-dd",
		    changeMonth: true,
		    changeYear: true,
		    yearRange: "-100:+0",
		    maxDate: new Date()
		  });
		});
	
	$(function() {
		  $("#hiredate").datepicker({
		    dateFormat: "yy-mm-dd",
		    changeMonth: true,
		    changeYear: true,
		    yearRange: "-100:+0",
		    maxDate: new Date()
		  });
		});
</script>
</html>