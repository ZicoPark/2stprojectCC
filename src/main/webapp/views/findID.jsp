<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>아이디 찾기</title>
	<link rel="icon" href="/img/CC_favicon.png">
	<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
	
	<!-- Google Font: Source Sans Pro -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
	<!-- Font Awesome -->
	<link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
	<!-- icheck bootstrap -->
	<link rel="stylesheet" href="../../plugins/icheck-bootstrap/icheck-bootstrap.min.css">
	<!-- Theme style -->
	<link rel="stylesheet" href="../../dist/css/adminlte.min.css">

<style>

	body {
	  background-color: #f3f3f4;
	}
	
	.item {
		padding: 50px;
		font-weight: 900;
		width: 450px;
		background-color: white;
		text-align:center;
	}
	
	.submit-btn{
		color: #EEEFF1;
		font-size : 17px;
		background-color: #1bbc9b;
		margin-top : 15px;
		margin-bottom : 20px;
		padding : 10px;
		border : none;
		width : 100%;
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
		text-align: center;
		font-size : 13px;
	}
	
	.mb-1 a{
		font-size : 13px;
		color : #9b9b9b;
	}
	
	.mb-1 a:hover {
		color: #1bbc9b;
	}
	
</style>
</head>

<body class="hold-transition login-page">
	<div class="login-box">
	  <div class="login-logo">
	    <b>Creator</b>Company
	  </div>
	  <div class="card">
	    <div class="card-body login-card-body">
	      <p class="login-box-msg">가입시 등록한 메일 주소로 알려드립니다.</p>
	      <form method="post" id="sendForm">            
	        <div class="input-group mb-3">
	          <input type="text" class="form-control" placeholder="이름을 입력하세요" name="name">
	          <div class="input-group-append">
	            <div class="input-group-text">
					<span class="fas fa-user"></span>
	            </div>
	          </div>
	        </div>	        
	        <div class="input-group mb-3">
	          <input type="email" class="form-control" placeholder="이메일을 입력하세요" name="email">
	          <div class="input-group-append">
	            <div class="input-group-text">
	              <span class="fas fa-envelope"></span>
	            </div>
	          </div>
	        </div>        
	        <div class="row">
	          <div class="col-12">
	            <input id="sendBtn" type="button" class="submit-btn" onclick="sendMail()" value="아이디 찾기">
	          </div>
	        </div>
	      </form>
	      <p class="mb-1">
	        <a href="./">로그인　|　</a> <a href="./join.go" class="text-center">회원가입</a>
	      </p>
	    </div>
	  </div>
	</div>
</body>

<script type="text/javascript">
	function sendMail() {
		$("#sendBtn").attr("disabled", true);
		$.ajax({
			type: 'post',
			url: 'sendMail.ajax',
			data: $("#sendForm").serialize(),
			dataType: 'json',
			beforeSend: function(xhr) {
				$("#sendForm").validate({
					rules: {
						name: {required: true},
						email: {required: true},
					},
					messages: {
						name: {required: "이름을 입력해 주세요."},
						email: {required: "이메일을 입력해 주세요."},
					},
				});
				if(!$('#sendForm').valid()) {
					$("#sendBtn").attr("disabled", false);
					xhr.abort();
				}
			},
			success: function(res){
				if(res.code === "COMPLETE") {
					alert("메일로 아이디를 전송하였습니다. 확인해주세요");
				} else if (res.code === "NO_DATA") {
					alert("일치하는 정보가 없습니다");
				} else {
					alert("메일 전송 실패");
				}
				$("#sendBtn").attr("disabled", false);
			},
			error: function(e){
				console.log(e);
				$("#sendBtn").attr("disabled", false);
			}
		});
	}
	
	// jQuery를 사용하여 폼 유효성 검사를 처리하는데 사용되는 jQuery Validation 플러그인의 설정을 변경하는 부분
	// 유효성 검사를 즉시 실행하고, 오류가 발생하면 오류 메시지를 경고창으로 보여주고 해당 폼 요소에 포커스를 설정
	$.validator.setDefaults({
		onkeyup:false,
		onclick:false,
		onfocusout:false,
		showErrors:function(errorMap, errorList) {
			if(this.numberOfInvalids()){
				alert(errorList[0].message);
				$(errorList[0].element).focus();
			}
		}
	});
</script>
</html>