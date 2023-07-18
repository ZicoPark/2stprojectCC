<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>회원가입</title>
<link rel="icon" href="/img/CC_favicon.png">	
	<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	
	<!-- Google Font: Source Sans Pro -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
	<!-- Font Awesome -->
	<link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
	<!-- icheck bootstrap -->
	<link rel="stylesheet" href="../../plugins/icheck-bootstrap/icheck-bootstrap.min.css">
	<!-- Theme style -->
	<link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  
	<!-- 부트스트랩 JavaScript 파일 불러오기 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 

<style>

	.register-box {
		width: 30%;
		height: 55%;
		margin: 0 auto;
		position: flex;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	
	h1, h2, h3, h4, h5, h6 {
	    margin-top: 10;
	}
	
	#pwMsg, #msg{
		margin-left: 125px;
	}
	
	#preview{
		margin-left : 110px;
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

</style>
</head>

<body class="hold-transition register-page">
	<div class="register-box">
	  <div class="card">
	    <div class="card-body register-card-body">
	      <form action="join.do" method="post" enctype="multipart/form-data">   
	        <div class="input-group mb-3">
	          <h6>아이디 : 　　　</h6>
	          &nbsp; &nbsp; &nbsp; <input type="text" class="form-control" name="user_id" id="user_id" placeholder="사용할 id를 입력하세요">
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
	          	&nbsp; &nbsp; &nbsp; <input type="text" class="form-control" id="birthday" name="birth_at" placeholder="생일을 선택해주세요">
	          	<div class="input-group-append">
	            	<div class="input-group-text"></div>
	          	</div>
	        </div>       
	        <div class="input-group mb-3">
	        	<h6>입사일 : 　　　</h6>
	          	&nbsp; &nbsp; &nbsp; <input type="text" class="form-control" id="hiredate" name="hire_at" placeholder="입사일을 선택해주세요">
	          	<div class="input-group-append">
	            	<div class="input-group-text"></div>
	          	</div>
	        </div>       
	        <div class="input-group mb-3">
	        	<h6>직급 : 　　　　</h6>
	          	&nbsp; &nbsp; &nbsp; 
	          	<select name="job_level_id" id="job_level_id" class="form-control">
		          	<option value="8ade9167-1703-11ee-973f-0242ac110002">팀원</option>
				  	<option value="8bbf948d-1703-11ee-973f-0242ac110002">팀장</option>
				  	<option value="8c4e7542-1703-11ee-973f-0242ac110002">이사</option>
				  	<option value="8cdd8503-1703-11ee-973f-0242ac110002">사장</option>
		      	</select>
	          <div class="input-group-append">
	            <div class="input-group-text"></div>
	          </div>
	        </div>      
	        <div class="input-group mb-3">
	        	<h6>부서 : 　　　　</h6>
	          	&nbsp; &nbsp; &nbsp; 
	          	<select name="dept_id" id="dept_id" class="form-control">
	          		<option value="8e5f3282-1703-11ee-973f-0242ac110002">총무팀</option>
			  		<option value="8ee07433-1703-11ee-973f-0242ac110002">기획팀</option>
			  		<option value="8f963853-1703-11ee-973f-0242ac110002">촬영팀</option>
			  		<option value="9022f64a-1703-11ee-973f-0242ac110002">편집팀</option>
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
			  	<h6>프로필 사진 :</h6>
			  	&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;
			  	<input type="file" name="file" onchange="previewImage(this);">
			  	<img id="preview" style="max-width: 150px; max-height: 150px;" src="img/cc.png">
			</div>
	        <button type="button" id = "submit" onclick="register()" class="submit-btn">회원등록</button>
	      </form>
	    </div>
	  </div>
	</div>
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
	      if($('#user_id').val()=='' || $('#user_id').val().includes("admin")){
	         alert('아이디을 입력해주세요!');
	         $('#user_id').focus();
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
		     }else if($('#job_level_id').val()==''){
		            alert('직급을 선택해주세요!');
		            $('#job_level_id').focus();
		     }else if($('#dept_id').val()==''){
		            alert('부서를 선택해주세요!');
		            $('#dept_id').focus();
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
		var user_id = $('#user_id').val();	   
		$.ajax({
		   type:'post',
		   url:'idChk.ajax',
		   data:{user_id:user_id},
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
	
	function previewImage(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();		  
			reader.onload = function(e) {
			$('#preview').attr('src', e.target.result);
			}		  
			reader.readAsDataURL(input.files[0]);
		} else {
			$('#preview').attr('src', 'img/cc.png');
		}
	}
</script>
</html>