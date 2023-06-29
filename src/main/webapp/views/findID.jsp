<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>아이디 찾기</title>
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
            <input id="sendBtn" type="button" class="btn btn-primary btn-block" onclick="sendMail()" value="아이디 찾기">
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
	$("#sendBtn").attr("disabled", true);
	$.ajax({
		type: 'post',
		url: 'sendMail.ajax',
		data: $("#sendForm").serialize(),
		dataType: 'json',
		beforeSend: function(xhr) {
			$("#sendForm").validate({
				rules: {
					user_name: {required: true},
					user_email: {required: true},
				},
				messages: {
					user_name: {required: "이름을 입력해 주세요."},
					user_email: {required: "이메일을 입력해 주세요."},
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
$.validator.setDefaults({
	onkeyup:false,
	onclick:false,
	onfocusout:false,
	showErrors:function(errorMap, errorList) {
		if(this.numberOfInvalids()){ // show error
			alert(errorList[0].message);
			$(errorList[0].element).focus();
		}
	}
});

</script>
</html>