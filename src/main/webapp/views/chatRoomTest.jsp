<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<!-- Ionicons -->
<link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<!--  Google Font: Source Sans Pro -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome-->
<link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
<!-- Tempusdominus Bootstrap 4 -->
<link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
<!-- overlayScrollbars-->
<link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
<!-- Theme style-->
<link rel="stylesheet" href="dist/css/adminlte.min.css">

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
      overflow : auto;
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
<body class="hold-transition sidebar-mini layout-fixed">
   <div class="wrapper">
   
      <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
          <!-- Content Header (Page header) -->
          <div class="content-header">
               <div class="container-fluid">
                 <div class="row mb-2">
                      <div class="col-sm-6">
                        <h1 class="m-0">채팅</h1>
                      </div><!-- /.col -->
          
                      <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                             <li class="breadcrumb-item"><a href="#">Home</a></li>
                             <li class="breadcrumb-item active">Dashboard v1</li>
                        </ol>
                      </div><!-- /.col -->
                 </div><!-- /.row -->
               </div><!-- /.container-fluid -->
          </div>
          <!-- /.content-header -->
    
         <!-- Main content -->
          <section class="content">
            <div class="container-fluid">
                
                 
                <input type="text" id="name"/>
               <button onclick="send_name()">이름저장</button>
               <input type="text" id="content"/>
               <button onclick="sendMessage()">전송</button>
               <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#chatCreateModal" onclick="create()">채팅방 생성하기</button>
               <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#chatInviteModal" onclick="invite()">초대하기</button>
               <button onclick="chat_room_exit()">채팅방 나가기</button>
               
               <div id="chat_list">
                  <div id="chat_room"></div>
                  
                  
                  <div id="chat_history" data-bs-spy="scroll" data-bs-target=".direct-chat-msg" data-bs-smooth-scroll="true" class="scrollspy-example-2" tabindex="0">
         
                  </div>
                  
               </div> 
                 
            </div>
               <!-- /.container-fluid -->
         </section>
          <!-- /.content -->
          
          
          <div class="modal fade" id="chatCreateModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
             <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                 <div class="modal-content">
      
                  <div class="user-container modal-header">
                         <label class="modal-title" id="staticBackdropLabel-create" for="nickname">채팅방 생성</label>
                         <span type="text" id="nickname-create" ></span>
                         <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                     </div>
      
      
                     <div class="display-container modal-body" style="height: 1000px">
                         <div class="chatting-list-create">
                        
                     </div>
                     </div>
      
      
                     <div class="input-container modal-footer">
                     <span>
                         <input type="text" placeholder="채팅방 이름을 적어주세요" id="chat-room-name">
                         <button type="button" id="send-button-create" class="send-button">추가하기</button>
                     </span>
                     </div>
      
                 </div>
            </div>
         </div>
         
         <div class="modal fade" id="chatInviteModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
             <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                 <div class="modal-content">
      
                  <div class="user-container modal-header">
                         <label class="modal-title" id="staticBackdropLabel-invite" for="nickname">초대하기</label>
                         <span type="text" id="nickname-invite" ></span>
                         <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                     </div>
      
      
                     <div class="display-container modal-body" style="height: 1000px">
                         <div class="chatting-list-invite" data-bs-spy="scroll" data-bs-target="#navbar-example3" data-bs-smooth-scroll="true">
                        
                     </div>
                     </div>
      
      
                     <div class="input-container modal-footer">
                     <span>
                         <button type="button" id="send-button-invite" class="send-button">추가하기</button>
                     </span>
                     </div>
      
                 </div>
            </div>
         </div>
          
      </div>
      <!-- /.content-wrapper -->
     
      <!-- Control Sidebar -->
        <aside class="control-sidebar control-sidebar-dark">
       <!-- Control sidebar content goes here -->
        
        </aside>
        <!-- /.control-sidebar -->
   </div>


   
   <section style="background-color: #eee;">
  <div class="container py-5">

    <div class="row d-flex justify-content-center">
      <div class="col-md-8 col-lg-6 col-xl-4">

        <div class="card" id="chat1" style="border-radius: 15px;">
          <div
            class="card-header d-flex justify-content-between align-items-center p-3 bg-info text-white border-bottom-0"
            style="border-top-left-radius: 15px; border-top-right-radius: 15px;">
            <i class="fas fa-angle-left"></i>
            <p class="mb-0 fw-bold">Live chat</p>
            <i class="fas fa-times"></i>
          </div>
          <div class="card-body">

            <div class="d-flex flex-row justify-content-start mb-4">
              <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava1-bg.webp"
                alt="avatar 1" style="width: 45px; height: 100%;">
              <div class="p-3 ms-3" style="border-radius: 15px; background-color: rgba(57, 192, 237,.2);">
                <p class="small mb-0">Hello and thank you for visiting MDBootstrap. Please click the video
                  below.</p>
              </div>
            </div>

            <div class="d-flex flex-row justify-content-end mb-4">
              <div class="p-3 me-3 border" style="border-radius: 15px; background-color: #fbfbfb;">
                <p class="small mb-0">Thank you, I really like your product.</p>
              </div>
              <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava2-bg.webp"
                alt="avatar 1" style="width: 45px; height: 100%;">
            </div>

            <div class="d-flex flex-row justify-content-start mb-4">
              <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava1-bg.webp"
                alt="avatar 1" style="width: 45px; height: 100%;">
              <div class="ms-3" style="border-radius: 15px;">
                <div class="bg-image">
                  <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/screenshot1.webp"
                    style="border-radius: 15px;" alt="video">
                  <a href="#!">
                    <div class="mask"></div>
                  </a>
                </div>
              </div>
            </div>

            <div class="d-flex flex-row justify-content-start mb-4">
              <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava1-bg.webp"
                alt="avatar 1" style="width: 45px; height: 100%;">
              <div class="p-3 ms-3" style="border-radius: 15px; background-color: rgba(57, 192, 237,.2);">
                <p class="small mb-0">...</p>
              </div>
            </div>

            <div class="form-outline">
              <textarea class="form-control" id="textAreaExample" rows="4"></textarea>
              <label class="form-label" for="textAreaExample">Type your message</label>
            </div>

          </div>
        </div>

      </div>
    </div>

  </div>
</section>
   
   
   <!-- jQuery UI -->
   <script src="plugins/jquery-ui/jquery-ui.min.js"></script>

   <!-- Bootstrap 4 -->
   <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
   <!-- overlayScrollbars -->
   <script
      src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
   <!-- AdminLTE App -->
   <script src="dist/js/adminlte.min.js"></script>
   <!-- JavaScript Bundle with Popper -->
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>

<!--  
<script src="https://cdn.jsdelivr.net/sockjs/1.5.2/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/stomp.js/2.3.3/stomp.min.js"></script>
-->

<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

<script>
   
   var chat_room_id;
   var name='';
   var socket;
   var stompClient;
   
   
   
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
         },
         error:function(e){ console.log(e); }
      });
      
      
      socket= new SockJS('/ws-stomp');
      stompClient= Stomp.over(socket);
      // stompClient.debug = null
      // 콘솔에 찍히는 debug disable 시킨다
      stompClient.connect({}, function (frame) {
           console.log('Connected: ' + frame);
           // var connid = utils.random_string(8); 8자리 랜덤생성?
           console.log(socket._transport.url);
       });
   }
   
   function chatHistory(data) {
      data.forEach(function(item) {
         var content = '';
         console.log(item.is_notice);
         if(item.is_notice != true){
            if(name == item.send_id) {
               console.log('일치요' + item.send_id);
               content+='<div class="direct-chat-msg">';
               content+='<div class="direct-chat-infos clearfix">';
               content+='<span class="direct-chat-name float-left">'+item.send_id+'</span>';
               content+='<span class="direct-chat-timestamp float-right">'+item.send_time+'</span>';
            }else {
               console.log('불일치요' + item.send_id);
               content+='<div class="direct-chat-msg right">';
               content+='<div class="direct-chat-infos clearfix">';
               content+='<span class="direct-chat-name float-right">'+item.send_id+'</span>';
               content+='<span class="direct-chat-timestamp float-left">'+item.send_time+'</span>';
            }
            
            content+='</div>';
            content+='<img class="direct-chat-img" src="dist/img/user1-128x128.jpg" alt="message user image">';
            content+='<div class="direct-chat-text">'+item.content+'</div></div>';
         } else {
            content += '<div>'+item.content+'</div>';
         }
         

         $('#chat_history').append(content);
      });
   }
   
   function sendMessage(event) {
       var messageContent = $('#content').val();

       if (messageContent && stompClient) {
          console.log('if문 시작');
           var chatMessage = {
               chat_room_id: chat_room_id,
               send_id: name,
               content: $('#content').val(),
               is_notice : false
           };

           stompClient.send("/pub/chat/sendMessage", {}, JSON.stringify(chatMessage));
           $('#content').val('');
       }
       //event.preventDefault();
   }
   
   function send_name() {
      name= $('#name').val();
      console.log(name);
      
      chatListAjax();
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
            var content =  '<table><tr><th><input type="checkbox" name="member_all"></th><th>이름</th><th>부서</th></tr>';
            data.forEach(function(item) {
               if(item.member_id == name) {
                  content+='';
               }else {
                  content+='<tr><th><input type="checkbox" name="member_id" value="'+item.member_id+'" class="create_input"></th><th>'+item.member_id+'</th><th>'+item.dept_code+'</th></tr>';
               }
               
            });
            content += '</table>';
            
            $('.chatting-list-create').append(content);
            
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
            var content =  '<table><tr><th><input type="checkbox" name="member_all"></th><th>이름</th><th>부서</th></tr>';
            data.forEach(function(item) {
               if(item.member_id == name) {
                  content+='';
               }else {
                  content+='<tr><th><input type="checkbox" name="member_id" value="'+item.member_id+'" class="invite_input"></th><th>'+item.member_id+'</th><th>'+item.dept_code+'</th></tr>';
               }
               
            });
            content += '</table>';
            
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
   
   
   
   $('#send-button-create').click(function() {
      var member_id_array = [];
      if($('input:checkbox[name="member_id"]:checked').length == 0) {
         alert('한명이상 체크해주세요');
      }else {
         var chat_room_name = $('#chat-room-name').val();
         if(chat_room_name == '') {
            alert('채팅방 이름을 적어주세요');
         }else {
            $('input:checkbox[name="member_id"]').each(function() {
               if($(this).is(":checked")==true){
                   console.log($(this).val());
                   member_id_array.push($(this).val());
                }
            });
            member_id_array.push(name);
            
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
   
   $('#send-button-invite').click(function() {
      var member_id_array = [];
      if($('input:checkbox[name="member_id"]:checked').length == 0) {
         alert('한명이상 체크해주세요');
      }else {
         var chat_room_name = $('#chat-room-name').val();
         if(chat_room_name == '') {
            alert('채팅방 이름을 적어주세요');
         }else {
            $('input:checkbox[name="member_id"]').each(function() {
               if($(this).is(":checked")==true){
                   console.log($(this).val());
                   member_id_array.push($(this).val());
                }
            });
            member_id_array.push(name);
            
            $.ajax({
               url:'inviteChatroom.ajax',
               type:'post',
               async: false,
               data:{
                  'member_id_array': member_id_array
               },
               dataType:'text',
               success:function(data){
                  console.log(data);
                  console.log('inviteChatroom.ajax () 성공');
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
   
   
   
   function chatListAjax() {
      console.log('chatListAjax() 호출');
      console.log('name : ' + name);
      $.ajax({
         url:'chatList.ajax',
         type:'post',
         data:{'name': name},
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
   
   function chat_room_exit() {
      console.log(chat_room_id);
      if (stompClient) {
          console.log('if문 시작');
           var chatMessage = {
               chat_room_id: chat_room_id,
               send_id: name,
               content: name+'님이 퇴장하셨습니다.',
               is_notice : true
           };
         
           stompClient.send("/pub/chat/sendMessage", {}, JSON.stringify(chatMessage), function() {
              console.log('입장');
              $('#chat_history').html('');
           });
           
      }
   }
</script>
</html>