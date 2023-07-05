<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>채팅방</title>
  <!-- CSS only -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <!-- Tempusdominus Bootstrap 4 -->
  <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
  <style>
	#chat_list {
		height : 700px;
	}
	
	#chat_room {
		border : 1px solid blue;
		width : 300px;
		height : 100%;
		float : left;
	}
	
	#chat_history {
		border : 2px solid red;
		width : 700px;
		height : 100%;
		float : left;
	}
	
	.main-sidebar {
		background-color: #e9ddc6;
	}
	.mt-2 .nav .nav-item .nav-link p {
		color : black;
	}
	.logo {
		width : 231px;
		height : 68px;
	}

	#footer {
		margin-left: 0px;
	}
	table {
		width: 300px;
	}
	table, th {
		border-collapse: collapse;
		border : 1px solid black;
	}
</style>
</head>
<body>
<jsp:include page = "index.jsp"></jsp:include>
<!-- Site wrapper -->
<div class="wrapper">
  <div class="content-wrapper">
    <section class="content-header">
            <h1>채팅방</h1>         
    </section>
    <br/>
    <!-- Main content -->
    <section class="content">
    
    <!-- 채팅방 생성 -->
    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#chatCreateModal" onclick="create()">채팅방 생성하기</button>
    
    <!-- 채팅방 초대 -->
    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#chatInviteModal" onclick="invite()">초대하기</button>
    
    <!-- 채팅방 나가기 -->
    <button onclick="chat_room_exit()">채팅방 나가기</button>
    
    
    
    <div id="chat_list">
    
    	<!-- 채팅방 리스트 -->
	    <div id="chat_room"></div>
	    
	    <!-- 채팅방 내용 -->
	    <div id="chat_history">
			<div class="direct-chat-msg right">
				<div class="direct-chat-infos clearfix">
					<span class="direct-chat-name float-right">Sarah Bullock</span>
					<span class="direct-chat-timestamp float-left">23 Jan 2:05 pm</span>
				</div>
				
				<img class="direct-chat-img" src="dist/img/user3-128x128.jpg" alt="message user image">
				<div class="direct-chat-text">
						 Creator Company에 오신 것을 환영합니다 !
				</div>
			</div>
		</div>	
	
		<!-- 채팅 입력 -->
		<input type="text" id="content">
		<button onclick="sendMessage()">전송</button>
		
	</div>
    </section>
  </div>
</div>

	<div class="modal fade" id="chatCreateModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
			<div class="modal-content">
			
				<div class="user-container modal-header">
					<label class="modal-title" id="staticBackdropLabel" for="nickname">채팅방 생성하기</label>
					<span id="nickname" ></span>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
			
				<div class="display-container modal-body" style="height: 1000px">
					<div class="chatting-list-create">	
					</div>
				</div>	
				
				<div class="input-container modal-footer">
					<span>
						<input type="text" placeholder="채팅방 이름을 적어주세요" id="chat-room-name">
						<button type="button" id="send-button-create" class="send-button-create">채팅방 생성하기</button>
					</span>
				</div>
			
			</div>
		</div>
	</div>


	<div class="modal fade" id="chatInviteModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
			<div class="modal-content">
					
				<div class="user-container modal-header">
					<label class="modal-title" id="staticBackdropLabel" for="nickname">대화명</label>
					<span id="nickname" ></span>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				
				<div class="display-container modal-body" style="height: 1000px">
					<div class="chatting-list-invite">	
					</div>
				</div>
				
				<div class="input-container modal-footer">
					<span>
						<input type="text" placeholder="채팅방 이름을 적어주세요" id="chat-room-name">
						<button type="button" id="send-button-invite" class="send-button-invite">추가하기</button>
					</span>
				</div>
			
			</div>
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
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
<script>

	var chat_room_id;
	var name='';
	var socket;
	var stompClient;

	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
	
	function create() {
		console.log('create() 호출');
		$.ajax({
			url:'memberListAll.ajax',
			type:'post',
			data:{},
			dataType:'json',
			success:function(data){
				console.log(data);
				$('.chatting-list-create').html('');
				var content =  '<table><tr><th><input type="checkbox" name="member_all"></th><th>이름</th><th>부서</th></tr>';
				data.forEach(function(item) {
					if(item.id == "${sessionScope.id}") {
						content+='';
					}else {
						content+='<tr><th><input type="checkbox" name="id" value="'+item.id+'"></th><th>'+item.name+'</th><th>'+item.dept_name+'</th></tr>';
					}					
				});
				content += '</table>';
				
				$('.chatting-list-create').empty();
				$('.chatting-list-create').append(content);
				
				$('input:checkbox[name="member_all"]').change(function() {
					console.log('member_all 체인지 이벤트');
					if($('input:checkbox[name="member_all"]').is(':checked')) {
						console.log('체크');
						$('input:checkbox[name="id"]').prop('checked', true);
					}else {
						console.log('체크해제');
						$('input:checkbox[name="id"]').prop('checked', false);
					}
				});
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	
	
	$('#send-button-create').click(function() {
		var member_id_array = [];
		if($('input:checkbox[name="id"]:checked').length == 0) {
			alert('한명 이상의 사원을 선택해주세요 !');
		}else {
			var chat_room_name = $('#chat-room-name').val();
			if(chat_room_name == '') {
				alert('채팅방 이름을 적어주세요 !');
			}else {
				console.log("chat_room_name : " + chat_room_name);
				$('input:checkbox[name="id"]').each(function() {
					if($(this).is(":checked")==true){
				    	console.log("member_id_array : " + $(this).val());
				    	member_id_array.push($(this).val());
				    }
				});
				member_id_array.push("${sessionScope.id}");	
				
				$.ajax({
					url:'createChatroom.ajax',
					type:'post',
					async: false,
					data:{
						'member_id_array': member_id_array,
						'chat_room_name' : chat_room_name
					},
					dataType:'text',
					success:function(data){
						console.log(data);
						console.log('createChatroom.ajax () 성공');
					},
					error:function(e){
						console.log(e);
					}
				});				
				chatListAjax();
			}
		}	
		console.log(member_id_array);
	});		
	
	chatListAjax()
	function chatListAjax() {
		console.log('chatListAjax() 호출');
		$.ajax({
			url:'chatList.ajax',
			type:'post',
			data:{'member_id': "${sessionScope.id}"},
			dataType:'json',
			success:function(data){
				console.log('chatList.ajax : ' + data);
				console.log('chatList.ajax 통신 성공');
				$('#chat_room').html('');
				data.forEach(function(item) {
					var content = '<div onclick="chatOpen(\''+item.chat_room_id+'\')">'+item.name+'</div>';
					$('#chat_room').append(content);
				});
			},
			error:function(e){
				console.log('chatList.ajax 통신 실패');
				console.log(e);
			}
		});
	}
	
	
	
	
	
	
	
	
	
	
	function chatOpen(chat_room_id) {
		console.log(chat_room_id);
		$('#chat_history').html('');
		$.ajax({
			url:'chatHistory.ajax',
			type:'post',
			data:{
				'chat_room_id' : chat_room_id
			},
			dataType:'json',
			success:function(data){
				chatHistory(data);
			},
			error:function(e){
				console.log(e); 
			}
		});
		
		<!--
		socket= new SockJS('/ws-stomp');
		stompClient= Stomp.over(socket);
		// stompClient.debug = null
		// 콘솔에 찍히는 debug disable 시킨다
		stompClient.connect({}, function (frame) {
	        console.log('Connected: ' + frame);
	        // var connid = utils.random_string(8); 8자리 랜덤생성?
	        console.log(socket._transport.url);
	        // 구독 설정
	        stompClient.subscribe('/sub/chat/'+id, function (message) {
	            console.log('Received message: ' + JSON.parse(message.body));
	            var body = JSON.parse(message.body);
	            var content='<div>'+body.send_id+' : '+body.content+'</div>';
	            //$('#chat_history').append(content);
	            $.ajax({
	        		url:'chatStored.ajax',
	        		type:'post',
	        		data:id,
	        		dataType:'json',
	        		contentType: 'application/json; charset=utf-8',
	        		/**/
	        		success:function(data){
	        			console.log(data);
	        			$('#chat_history').html('');
	        			
	        			chatHistory(data);
	        			
	        		},
	        		error:function(e){
	        			console.log(e);
	        		}
	        	});
	            // 메시지 처리 로직 추가
	        });
	    });
	}
	 -->
	
	
	
	
	
	
	
	
	
	
	
	function invite() {
		console.log('invite() 호출');
		$.ajax({
			url:'memberList.ajax',
			type:'post',
			data:{chat_room_id},
			dataType:'json',
			success:function(data){
				console.log(data);
				$('.chatting-list').html('');
				var content =  '<table><tr><th><input type="checkbox" name="member_all"></th><th>이름</th><th>부서</th></tr>';
				data.forEach(function(item) {
					if(item.id == "${sessionScope.id}") {
						content+='';
					}else {
						content+='<tr><th><input type="checkbox" name="id-invite" value="'+item.id+'"></th><th>'+item.name+'</th><th>'+item.dept_name+'</th></tr>';
					}
					
				});
				content += '</table>';
				$('.chatting-list-invite').empty();
				$('.chatting-list-invite').append(content);
				
				$('input:checkbox[name="member_all"]').change(function() {
					console.log('member_all 체인지 이벤트');
					if($('input:checkbox[name="member_all"]').is(':checked')) {
						console.log('체크');
						$('input:checkbox[name="member_id"]').prop('checked', true);
					}else {
						console.log('체크해제');
						$('input:checkbox[name="member_id"]').prop('checked', false);
					}
				});
			},
			error:function(e){
				console.log(e);
			}
		});
		
	}
	

</script>
</html>
