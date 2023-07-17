<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>비밀번호 찾기</title>
	
	<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
	
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
	
	.login-box-msg{
		font-size : 11px;
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
      <p class="login-box-msg">가입시 등록한 메일 주소로 임시 비밀번호를 알려드립니다.</p>

      <form method="post" name="sendForm">
        <div class="input-group mb-3">
          <input type="text" class="form-control" placeholder="아이디를 입력하세요" name="user_id">
          <div class="input-group-append">
            <div class="input-group-text">
				<span class="fas fa-user"></span>
            </div>
          </div>
        </div>
        
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
            <input id="sendBtn" type="button" class="submit-btn" onclick="sendMail()" value="임시 비밀번호 발급">
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
		// 폼 유효성 검사를 설정합니다.
		$("#sendForm").validate({
			rules: {
				user_id: {required: true},
				name: {required: true},
				email: {required: true, email: true},
			},
			messages: {
				user_id: {required: "아이디를 입력해 주세요."},
				name: {required: "이름을 입력해 주세요."},
				email: {
					required: "이메일을 입력해 주세요.",
					email: "올바른 이메일 주소를 입력해 주세요.",
				},
			},
			errorPlacement: function(error, element) {
				// 오류 메시지를 얼러트 창으로 보여주고 해당 폼 요소에 포커스를 설정합니다.
				if (element.val() === "") {
					alert(error.text());
					element.focus();
				}
			}
		});

		// 유효성 검사를 실행하고, 오류가 없으면 Ajax를 이용해 데이터 전송
		if ($("#sendForm").valid()) {
			$.ajax({
				type: 'post',
				url: 'sendPWMail.ajax',
				data: $("form[name=sendForm]").serialize(),
				dataType: 'json',
				success: function(res){
					if(res.code === "TRANSFER_COMPLETE") {
						alert("메일로 임시 비밀번호를 발송헀습니다. 확인해주세요");
					} else if (res.code === "NO_MATCHING_DATA") {
						alert("일치하는 정보 없음");
					} else {
						alert("메일 전송 실패");
					}
				},
				error: function(e){
					console.log(e);
				}
			});
		}
	}
</script>
</html>