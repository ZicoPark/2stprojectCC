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

h1, h2, h3, h4, h5, h6 {
    margin-top: 10;
}

#pwMsg, #msg{
	margin-left: 125px;
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
          <h6>아이디 : 　　　</h6>
          &nbsp; &nbsp; &nbsp; <input type="text" class="form-control" name="id" id="id" placeholder="사용할 id를 입력하세요">
          <div class="input-group-append">
          <div class="input-group-text"></div>
          </div>
          <button id="idChk" type="button">중복확인</button>
        </div>
        <span id="msg"></span>
        
        <div class="input-group mb-3">
        	<h6>비밀번호 : 　　</h6>
         	&nbsp; &nbsp; &nbsp; <input type="password" class="form-control" name="password" id="password" placeholder="비밀번호를 입력하세요">
         	<div class="input-group-append">
            	<div class="input-group-text"></div>
          	</div>
        </div>
        
        <div class="input-group mb-3">
        <h6>비밀번호 확인 : </h6>
         &nbsp; &nbsp; &nbsp; <input type="password" class="form-control" id="userPwChk" placeholder="비밀번호를 다시 확인합니다">
         <div class="input-group-append">
            <div class="input-group-text"></div>
          </div>
        </div>
        <span id="pwMsg"></span>
            
        <div class="input-group mb-3">
        <h6>이름 : 　　　　</h6>
          &nbsp; &nbsp; &nbsp; <input type="text" class="form-control" name="name" id="name" placeholder="이름을 입력해주세요">
          <div class="input-group-append">
            <div class="input-group-text"></div>
          </div>
        </div>
        
        <div class="input-group mb-3">
        <h6>생년월일 : 　　</h6>
          &nbsp; &nbsp; &nbsp; <input type="text" class="form-control" id="birthday" name="birth_date" placeholder="생일을 선택해주세요">
          <div class="input-group-append">
            <div class="input-group-text"></div>
          </div>
        </div>
        
        <div class="input-group mb-3">
        <h6>입사일 : 　　　</h6>
          &nbsp; &nbsp; &nbsp; <input type="text" class="form-control" id="hiredate" name="hire_date" placeholder="입사일을 선택해주세요">
          <div class="input-group-append">
            <div class="input-group-text"></div>
          </div>
        </div>
        
        <div class="input-group mb-3">
        <h6>직급 : 　　　　</h6>
          &nbsp; &nbsp; &nbsp; 
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
        <h6>부서 : 　　　　</h6>
          &nbsp; &nbsp; &nbsp; 
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
        <h6>이메일 : 　　　</h6>
          &nbsp; &nbsp; &nbsp; 
          <input type="email" class="form-control" name="email" id="email" placeholder="Email">
          <div class="input-group-append">
            <div class="input-group-text"></div>
          </div>
        </div>
              
        <div class="input-group mb-3">
        <h6>연락처 : 　　　</h6>
          &nbsp; &nbsp; &nbsp; 
          <input type="text" class="form-control" name="phone" id="phone" placeholder="'-'를 포함해서 연락처를 입력해주세요">
          <div class="input-group-append">
            <div class="input-group-text"></div>
          </div>
        </div>
        
        <div class="input-group mb-3">
        <h6>프로필 사진 :　</h6>
          &nbsp; &nbsp; &nbsp; 
          <form action="upload.do" method="post" enctype="multipart/form-data">
          	<input type="file" name="picture" id="picture">
          </form>
        </div>
        <div class="row">
          <div class="col-8">
          </div>
          <!-- /.col -->
          <div class="col-4">
          </div>
          <!-- /.col -->
        </div>
            <button type="button" id = "submit" onclick="register()" class="btn btn-primary btn-block">회원등록</button>
      </form>
	  </br>
      <a href="./" class="text-center">이미 회원가입이 되어 있습니다.</a>
    </div>
    <!-- /.form-box -->
  </div><!-- /.card -->
</div>
<!-- /.register-box -->

</body>
<script>

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
	
	
	
	/* null 값 방지*/
	var overlayChk = false;
	var nickNameChk = false;



	function register(){
	   if(overlayChk == true){
	      if($('#id').val()=='' || $('#id').val().includes("admin")){
	         alert('아이디을 입력해주세요!');
	         $('#id').focus();
	      }else if($('#password').val()==''){
	         alert('비밀번호를 입력해주세요!');
	         $('#password').focus();
	      }else if($('#userPwChk').val()==''){
	          alert('비밀번호확인을 입력해주세요!');
	          $('#userPwChk').focus();
	       }else if($('#name').val()==''){
	           alert('이름을 입력해주세요!');
	           $('#name').focus();
	        }else if($('#birthday').val()==''){
	            alert('생년월일을 선택해주세요!');
	            $('#birthday').focus();
	         }else if($('#hiredate').val()==''){
		            alert('입사일을 선택해주세요!');
		            $('#hiredate').focus();
		     }else if($('#job_name').val()==''){
		            alert('직급을 선택해주세요!');
		            $('#job_name').focus();
		     }else if($('#job_name').val()==''){
		            alert('직급을 선택해주세요!');
		            $('#job_name').focus();
		     }else if($('#dept_name').val()==''){
		            alert('부서를 선택해주세요!');
		            $('#dept_name').focus();
		     }else if($('#email').val()==''){
		            alert('이메일을 입력해주세요!');
		            $('#email').focus();
		     }else if($('#phone').val()==''){
		            alert('연락처를 입력해주세요!');
		            $('#phone').focus();
		     }else{
	            $('button').attr('type','submit');
	      }
	   }else{
		   if(overlayChk == false){ 
			   alert('아이디 중복 확인 해주세요!');
		   }else if(nickNameChk == false){
			   alert('닉네임 중복 확인 해주세요!');
		   }
	      
	   }
	}
	
	
	$('#idChk').on('click',function(e){
		   
		   var id = $('#id').val();
		   
		   $.ajax({
		      type:'post',
		      url:'idChk.ajax',
		      data:{id:id},
		      dataType:'json',
		      success:function(data){
		         if(data.idChk == 0){
		            console.log('사용 가능한 아이디');
		            $('#msg').css({'font-size':'8px', 'color':'darkgreen'});
		            $('#msg').html('사용 가능한 아이디 입니다.');
		            overlayChk = true;
		         }else{
		            console.log('이미 사용 중인 아이디');
		            $('#msg').css({'font-size':'8px', 'color':'red'});
		            $('#msg').html('이미 사용 중인 아이디 입니다.');
		         }
		      },
		      error:function(e){
		         console.log(e);
		      }
		   });
	});
	
	$('#userPwChk').on('keyup',function(e){
		if($('#password').val() == $(this).val()){
			$('#pwMsg').css({'font-size': '8px', 'color': 'darkgreen'});
			$('#pwMsg').html('비밀번호가 일치 합니다.');
			pweq = true;
		}else{
			$('#pwMsg').css({'font-size': '8px', 'color': 'red'});
			$('#pwMsg').html('비밀번호가 일치 하지 않습니다.');
		}	
	});
	
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
</script>
</html>