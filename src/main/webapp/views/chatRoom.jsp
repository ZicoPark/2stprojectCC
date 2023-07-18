<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>채팅방</title>
  <link rel="icon" href="/img/CC_favicon.png">
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
    
    .chat-list {
        display: flex;
        align-items: stretch;
    }
    
	.chat-column1{
	    flex: 1;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        background-color: white;
        overflow-y: auto;
        height: 250px;
        
    }
    
	.chat-column2{
		flex: 1;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        background-color: white;
        overflow-y: auto;
        height: 250px;
        display: block;
    }
    
	.chat-column3{
        flex: 1;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        background-color: #f8f8f8;
        height: 550px;
        width: 600px;
        max-width: 60%;
    }

    #chat_history {
        height: 90%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        background-color: #fff;
        overflow-y: auto;
    }

    .direct-chat-msg {
        margin-bottom: 10px;
    }

    .direct-chat-name {
        font-weight: bold;
        color: #337ab7;
    }

    .direct-chat-timestamp {
        color: #777;
    }

    .direct-chat-img {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        margin-right: 10px;
    }

    .direct-chat-text {
        background-color: #f2f2f2;
        padding: 10px;
        border-radius: 5px;
    }

    .chat-input {
        display: flex;
        align-items: center;
        margin-top: 10px;
    }

    #content {
        flex: 1;
        height: 30px;
        padding: 5px;
        border: 1px solid #ccc;
        border-radius: 5px;
        margin-right: 10px;
    }

    .btn-primary {
        background-color: #337ab7;
        color: #fff;
        border: none;
        padding: 5px 10px;
        border-radius: 5px;
        cursor: pointer;
    }

    .btn-primary:hover {
        background-color: #286090;
    }
    
    .listList{
		flex: 1;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        background-color: #f8f8f8;
        overflow-y: auto;
        height: 550px;
        max-width: 30%;
    }
    
	.listList div {
        display: block;
    }
	#listCss:hover{
		cursor: pointer;
		text-decoration: underline;
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
    <div style="display: flex;">
        <!-- 채팅방 생성 -->
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#chatCreateModal" onclick="create()">채팅방 생성하기</button>
		&nbsp;
        <!-- 채팅방 초대 -->
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#chatInviteModal" onclick="invite()">초대하기</button>
		&nbsp;
        <!-- 채팅방 나가기 -->
        <button class="btn btn-info btn-sm" onclick="chatRoomExit()">채팅방 나가기</button>
    </div>
	<br/>

	<div id="chat_list">    
	    <div class="chat-list">
	    
	    	<div class="listList">
		        <div id="chat-column1" class="chat-column1">
		            <!-- 채팅방 목록 -->
		            <div style="color: #337ab7;"><b>채팅방 목록</b></div>
		            <div id="chat_room"></div>
		        </div>
		        <br/>
		        <div class="chat-column2">
		            <!-- 채팅방 인원 -->
		            <div style="color: #337ab7;"><b>채팅방 인원</b></div>
		            <div id="chat_member"></div>
		        </div>
			</div>
			&nbsp;
	        <div class="chat-column3">
	            <!-- 채팅방 내용 -->
	            <div id="chat_history">
	                <div class="direct-chat-msg" style="margin-right: 100px;">
	                    <div class="direct-chat-infos clearfix">
	                        <span class="direct-chat-name float-left">CEO</span>
	                        <span class="direct-chat-timestamp float-right">24 July 11:05 am</span>
	                    </div>
	                    <img class="direct-chat-img" src="dist/img/user3-128x128.jpg" alt="message user image">
	                    <div class="direct-chat-text">
	                        Creator Company에 오신 것을 환영합니다!
	                    </div>
	                </div>
	            </div>
	            
			    <div class="chat-input 4">
			        <!-- 채팅 입력 -->
			        <input type="text" id="content" onkeydown="handleKeyDown(event)">
			        <button class="btn btn-primary" onclick="sendMessage()">전송</button>
			    </div>            
	            
	        </div>
	    </div>
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
					<input type="text" placeholder="채팅방 이름을 적어주세요 !" id="chat-room-name" class="form-control" style="width: 60%;">
					<button type="button" id="send-button-create" class="send-button-create btn btn-primary" style="width: 30%;">채팅방 생성하기</button>
				</div>
			
			</div>
		</div>
	</div>


	<div class="modal fade" id="chatInviteModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
			<div class="modal-content">
					
				<div class="user-container modal-header">
					<label class="modal-title" id="staticBackdropLabel" for="nickname">초대하기</label>
					<span id="nickname" ></span>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				
				<div class="display-container modal-body" style="height: 1000px">
					<div class="chatting-list-invite">	
					</div>
				</div>
				
				<div class="input-container modal-footer">
					<span>
						<button type="button" id="send-button-invite" class="send-button-invite btn btn-primary">초대하기</button>
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
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
<script>
	var chat_room_id;
	var name='';
	var socket;
	var stompClient;
	var sessionId = "${sessionScope.id}";
	var chatNameChk = "${sessionScope.chatNameChk}";
	

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
		         $('.chatting-list-invite').html('');
				var content =  '<table class="table table-bordered"><tr><th><input type="checkbox" name="member_all"></th><th>이름</th><th>부서</th></tr>';
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
	
	var scrollPosition = 0;
	chatListAjax();
	
	setInterval(function() {
	    chatListAjax();
	}, 5000);

	function chatListAjax() {
	    scrollPosition = $('#chat-column1').scrollTop();
	    chatListAjax();	    
	    $('#chat-column1').scrollTop(scrollPosition);
	}
	
	
	
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
					var content = '<div id="listCss" onclick="chatOpen(\''+item.chat_room_id+'\')">'+item.name+'</div>';
					$('#chat_room').append(content);
				});
			},
			error:function(e){
				console.log('chatList.ajax 통신 실패');
				console.log(e);
			}
		});
	}
	
	function chatMember(id) {
		console.log('chatMember Ajax() 호출');
		$.ajax({
			url:'chatMember.ajax',
			type:'post',
			data:{'chat_room_id': id},
			dataType:'json',
			success:function(data){
				console.log('chatMember.ajax : ' + data);
				console.log('chatMember.ajax 통신 성공');
				$('#chat_member').html('');
				data.forEach(function(item) {
					var content = '<div>'+item.name+" ("+item.dept_name+')</div>';
					$('#chat_member').append(content);
				});
			},
			error:function(e){
				console.log('chatList.ajax 통신 실패');
				console.log(e);
			}
		});
	}
	
		
	function chatOpen(id) {
		chat_room_id = id;
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
				chatMember(chat_room_id);
				chatListAjax();
			},
			error:function(e){
				console.log(e); 
			}
		});
		
		// SockJS를 사용하여 WebSocket 연결
		socket= new SockJS('/ws-stomp');
		// Stomp.over(socket)은 생성된 WebSocket을 사용하여 Stomp 클라이언트(like 라이브러리)를 생성
		stompClient= Stomp.over(socket);
		// 디버그 출력을 비활성화
		// stompClient.debug = null
		
		// Stomp 클라이언트로 서버에 연결
		// StompClient.connect()를 호출하여 서버에 연결		
		// StompClient.subscribe()를 사용하여 특정 주제를 구독하여 서버로부터 메시지를 수신
		stompClient.connect({}, function (frame) {
	        console.log('Connected: ' + frame);
	        // var connid = utils.random_string(8); 8자리 랜덤생성?
	        console.log(socket._transport.url);
	     	// '/sub/chat/'+id' 주제를 구독하여 채팅 메시지를 수신
	        stompClient.subscribe('/sub/chat/'+chat_room_id, function (message) {
	            
	            // 채팅 내역 불러오기 AJAX 요청
	            $.ajax({
	        		url:'chatLoad.ajax',
	        		type:'post',
	        		data:chat_room_id,
	        		dataType:'json',
	        		contentType: 'application/json; charset=utf-8',
	        		success:function(data){
	        			console.log(data);
	        			$('#chat_history').html('');
	        			chatHistory(data);      			
	        		},
	        		error:function(e){
	        			console.log(e);
	        		}
	        	});
	        });
	    });
	}	
	
	function chatHistory(data) {
		chatMember(chat_room_id);
		chatListAjax();
		
		data.forEach(function(item) {
			var content = '';
			
			if("${sessionScope.id}" == item.send_id) {
				console.log('나' + item.send_id);
				content+='<div class="direct-chat-msg right" style="margin-left: 100px;">';
				content+='<div class="direct-chat-infos clearfix">';
				content+='<span class="direct-chat-name float-right">'+item.name+' ('+item.dept_name+')'+'</span>';
				content+='<span class="direct-chat-timestamp float-left">'+item.send_time+'</span>';
			}else {
				console.log('상대' + item.send_id);
				content+='<div class="direct-chat-msg" style="margin-right: 100px;">';
				content+='<div class="direct-chat-infos clearfix">';
				content+='<span class="direct-chat-name float-left">'+item.name+' ('+item.dept_name+')'+'</span>';
				content+='<span class="direct-chat-timestamp float-right">'+item.send_time+'</span>';
			}
			
			content+='</div>';
			
			if(item.profileImg == null || item.profileImg ==""){
				content+='<img class="direct-chat-img" src="dist/img/user1-128x128.jpg" alt="message user image">';
			}else{
				content+='<img class="direct-chat-img" src="/photoView.do?path='+item.profileImg+'" alt="message user image">';				
			}
			
			
			content+='<div class="direct-chat-text">'+item.content+'</div></div>';			

			$('#chat_history').append(content);
			
		});

		var chatHistory = document.getElementById("chat_history");
		chatHistory.scrollTop = chatHistory.scrollHeight;
		
	}
	
	
	
	
	function sendMessage(event) {
	    var messageContent = $('#content').val();

	    if (messageContent && stompClient) {
	    	console.log('sendMessage 시작');
	        var chatMessage = {
	            chat_room_id: chat_room_id,
	            send_id: "${sessionScope.id}",
	            content: $('#content').val()
	        };

	        stompClient.send("/pub/chat/sendMessage", {}, JSON.stringify(chatMessage));
	        $('#content').val('');
	    }
	    //event.preventDefault();
	}
	
	function handleKeyDown(event) {
		  if (event.keyCode === 13) { // 엔터 키를 눌렀을 때
		    event.preventDefault(); // 기본 동작 (폼 제출 등) 막기
		    sendMessage(); // sendMessage 함수 호출
		  }
	}
	
	
	function chatRoomExit() {
		console.log('chatRoomExit() 호출');
		console.log('chat_room_id : ' + chat_room_id);
		
		$.ajax({
			url:'chatRoomExit.ajax',
			type:'post',
			data:{
				'member_id': sessionId,
				'chat_room_id' : chat_room_id				
			},
			dataType:'json',
			success:function(data){
				console.log('chatRoomExit.ajax 통신 성공');
				$('#content').val(chatNameChk + "님이 퇴장하였습니다.");

				sendMessage("");
				location.href = "chatRoom.go";
			},
			error:function(e){
				console.log('chatRoomExit.ajax 통신 실패');
				console.log(e);
			}
		});
	}
	
	

	function invite() {
		console.log('invite() 호출');
		$.ajax({
			url:'memberList.ajax',
			type:'post',
			data:{chat_room_id},
			dataType:'json',
			success:function(data){
				console.log(data);
				$('.chatting-list-create').html('');
				$('.chatting-list-invite').html('');
				var content =  '<table class="table table-bordered"><tr><th><input type="checkbox" name="member_all"></th><th>이름</th><th>부서</th></tr>';
				data.forEach(function(item) { 
					if(item.id == "${sessionScope.id}") {
						content+='';
					}else {
						content+='<tr><th><input type="checkbox" name="id" value="'+item.id+'"></th><th>'+item.name+'</th><th>'+item.dept_name+'</th></tr>'
					}
				             
				});
				content += '</table>';
				          
				$('.chatting-list-invite').append(content);
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

   

	$('#send-button-invite').click(function() {
		var member_id_array = [];
		var member_name_array = [];
		
		if($('input:checkbox[name="id"]:checked').length == 0) {
			alert('한명 이상의 사원을 선택해주세요 !');
		}else {
			$('input:checkbox[name="id"]').each(function() {
				if($(this).is(":checked")==true){
					console.log("member_id_array : " + $(this).val());
					member_id_array.push($(this).val());
					var itemName = $(this).closest('tr').find('th:eq(1)').text();
	                member_name_array.push(itemName);
				}
			});
			member_id_array.push("${sessionScope.id}");
	          
			$.ajax({
				url:'inviteChatRoom.ajax',
				type:'post',
				async: false,
				data:{
					'member_id_array': member_id_array,
					'chat_room_id' : chat_room_id	
				},
				dataType:'text',
				success:function(data){
					console.log(data);
	                console.log('inviteChatroom.ajax () 성공');
	                $('#content').val("채팅방에 사원을 초대하였습니다 : " + member_name_array);
					sendMessage("");
				},
				error:function(e){
					console.log(e);
				}
			});
	          
			chatListAjax();
		}
	    
		console.log(member_id_array);
	});

	
	$('#send-button-invite').click(function() {
		 $('.chatting-list-create').html('');
         $('.chatting-list-invite').html('');
		$('#chatInviteModal').modal('hide');
	});
	
	$('#send-button-create').click(function() {
		 $('.chatting-list-create').html('');
        $('.chatting-list-invite').html('');
		$('#chatCreateModal').modal('hide');
	});
	
	
	
</script>
</html>
