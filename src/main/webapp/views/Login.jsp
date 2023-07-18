<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>로그인</title>
<link rel="icon" href="/img/CC_favicon.png">
  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- icheck bootstrap -->
  <link rel="stylesheet" href="../../plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">

<style>

	.submit-btn{
		color: #EEEFF1;
		font-size : 17px;
		background-color: #1bbc9b;
		margin-top : 15px;
		margin-bottom : 20px;
		padding : 10px;
		border : none;
		width : 95%;
		text-align: center;
		border-radius: 10px; 
		margin-left: auto;
		margin-right: auto;
		transition: transform 0.3s;
	  }
	  
	 .submit-btn:hover {
	   transform: scale(1.1);
	 }
	 
	.mb-1 {
		text-align: right;
		font-size : 13px;
	}
	
	.mb-1 a{
		font-size : 13px;
		color : #9b9b9b;
	}
	
	.mb-1 a:hover {
		color: #1bbc9b;
	}
	
	
	.mb-0{
		text-align : center;
	}
	
	.mb-0 a{
		color: #1bbc9b;
	}
	
</style>
</head>

<body class="hold-transition login-page">
	<img class="mb-4" src="img/CC.png" alt="" >
	<div class="login-box">
	  <div class="card">
	    <div class="card-body login-card-body">
	      <p class="login-box-msg">시작하려면 로그인 하세요</p>
	      <form action="login.do" method="post">
	        <div class="input-group mb-3">
	          <input type="text" class="form-control" placeholder="ID를 입력하세요" name = "user_id">
	          <div class="input-group-append">
	            <div class="input-group-text">
	            	<span class="fas fa-user"></span>
	            </div>
	          </div>
	        </div>
	        <div class="input-group mb-3">
	          <input type="password" class="form-control" placeholder="Password를 입력하세요" name="password">
	          <div class="input-group-append">
	            <div class="input-group-text">
	            	<span class="fas fa-lock"></span>
	            </div>
	          </div>
	        </div>        
	      <p class="mb-1">
	        <a href="/findID.go">ID　/　</a><a href="/findPW.go">PW　</a> 찾기
	      </p>        
	        <div class="row">
	            <button type="submit" value = "login" class="submit-btn">로그인</button>
	        </div>
	      </form>    
	      <p class="mb-0">
	        아이디가 아직 없으신가요?<a href="/join.go" class="text-center">　회원 가입</a>
	      </p>
	    </div>
	  </div>
	</div>
</body>

<script>
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
</script>
</html>
