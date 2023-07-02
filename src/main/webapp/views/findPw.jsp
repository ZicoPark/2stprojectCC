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

      <form method="post" name="sendForm">
        <div class="input-group mb-3">
          <input type="text" class="form-control" placeholder="아이디를 입력하세요" name="user_id">
          <div class="input-group-append">
            <div class="input-group-text">

            </div>
          </div>
        </div>
        
        <div class="input-group mb-3">
          <input type="text" class="form-control" placeholder="이름을 입력하세요" name="name">
          <div class="input-group-append">
            <div class="input-group-text">

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
            <button type="submit" class="btn btn-primary btn-block" onclick="sendMail()">임시 비밀번호 발급</button>
          </div>
          <!-- /.col -->
        </div>
      </form>

      <p class="mt-3 mb-1">
        <a href="./">로그인</a>
      </p>
      <p class="mb-0">
        <a href="./join.go" class="text-center">회원가입</a>
      </p>
    </div>
    <!-- /.login-card-body -->
  </div>
</div>

</body>
<script type="text/javascript">
function sendMail() {
	$.ajax({
		type: 'post',
		url: 'sendPWMail.ajax',
		data: $("form[name=sendForm]").serialize(),
		dataType: 'json',
		success: function(res){
			if(res.code === "TRANSFER_COMPLETE") {
				alert("메일 전송함");
				console.log("성공");

			} else if (res.code === "NO_MATCHING_DATA") {
				alert("일치하는 정보 없음");
				console.log("일치정보없음");
			} else {
				alert("메일 전송 실패");
				console.log("메일전송실패");
			}
		},
		error: function(e){
			console.log(e);
		}
	});
}

var msg = "${msg}";
if(msg != ""){
	alert(msg);
}

</script>
</html>