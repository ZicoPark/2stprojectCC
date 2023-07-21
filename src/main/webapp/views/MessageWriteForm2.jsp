<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>쪽지작성</title>
<link rel="icon" href="/img/CC_favicon.png">
  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
 
  <link rel="stylesheet" href="../../plugins/bootstrap4-duallistbox/bootstrap-duallistbox.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <!-- summernote -->
  <link rel="stylesheet" href="../../plugins/summernote/summernote-bs4.min.css">
  
  
  
  
  
 <style>
 
 
 .btn-primary {
    color: #fff;
    background-color: #20c997;
    border-color: #20c997;
    box-shadow: none;
}
  
.card-primary.card-outline {
    border-top: 3px solid #20c997;
    
    
  .table-wrapper {
    display: flex;
  }
  .table-wrapper table {
    flex-grow: 1;
  }


  .hidden-option {
  display: none;
}
  .dept-container {
    display: flex;
  }
  
    .dept-item {
    padding-right: 10px;
  }
  
    span.info {
    display: none;
  }
  

 
</style> 
</head>

<body class="hold-transition sidebar-mini">
<jsp:include page = "index.jsp"></jsp:include>
<div class="wrapper">
  <!-- Navbar -->
  

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">쪽지 작성</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>
<form action="msWrite.do" method="post" enctype="multipart/form-data">
    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
   <!-- row 밑에  -->
   <div class="col-md-3">
   <a href="/msWrite.go" class="btn btn-primary btn-block mb-3">쪽지 작성</a>
   <div class="card">
   <div class="card-header">
   <h3 class="card-title">보관함</h3>
   <div class="card-tools">
   <button type="button" class="btn btn-tool" data-card-widget="collapse">
   <i class="fas fa-minus"></i>
   </button>
   </div>
   </div>
   <div class="card-body p-0">
   <ul class="nav nav-pills flex-column">
   <li class="nav-item active">

   </li>
   <li class="nav-item">
   <a href="/msReceiveList.go" class="nav-link">
   <i class="fas fa-inbox"></i> 받은 쪽지
   </a>
   </li>
   <li class="nav-item">
   <a href="/msSendList.go" class="nav-link">
   <i class="far fa-file-alt"></i> 보낸 쪽지
   </a>
   </li>
   <li class="nav-item">
   <a href="/msRemoveList.go" class="nav-link">
   <i class="far fa-trash-alt"></i> 휴지통
   </a>
   </li>
   </ul>
   </div>
   
   </div>
   </div> 
   <!-- col-md-9 위에  --> 
          <div class="col-md-9">
            <div class="card card-primary card-outline">
              <div class="card-header">
                <h3 class="card-title">새 쪽지 작성</h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <div class="form-group">
                <input type="text" name="from_id" value="${loginId}" readonly="readonly" hidden="true" required/>
                <input type="text" class="form-control" name="to_id" hidden/>
            <div class="input-group">
              <input type="text" id="to_plz" name="to_plz" class="form-control" placeholder="받는 사람: " readonly/>
              <div class="input-group-append">
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#memberModal">주소록</button>
              </div>
              </div>
            </div>

                                           
            <!-- 모달 -->
            <div class="modal fade" id="memberModal" tabindex="-1" role="dialog" aria-labelledby="memberModalLabel" aria-hidden="true">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <!-- 모달 내용 -->
               <div class="modal-body">
                 <!-- 모달 내용 추가 -->
                 <div class="table-wrapper">
    
    
    
<%--           <div class="listList">
              <div class="chat-column1">
                  
                  <div style="color: #337ab7;"><b>부서 목록</b></div>
                     <c:forEach items="${dept}" var="i">
                     <div onclick="selectMember(this.getAttribute('value'))" value="${i.name}">${i.name}</div>

                   </c:forEach>
                  <div id="chat_room"></div>

              </div>
              <br/>
              <div class="chat-column2">
                  <!-- 부서 사원 -->
                  <div style="color: #337ab7;"><b>사원</b></div>
                  <div id="dept_member"></div>
              </div>
        
         </div> --%>





        <div class="card card-default">
          <div class="card-header">
            <h3 class="card-title">주소록</h3>

            <div class="card-tools">
              <button type="button" class="btn btn-tool" data-card-widget="collapse">
                <i class="fas fa-minus"></i>
              </button>
              <button type="button" class="btn btn-tool" data-card-widget="remove">
                <i class="fas fa-times"></i>
              </button>
            </div>
          </div>
          <!-- /.card-header -->
          <div class="card-body">
            <div class="row">
              <div class="col-12">
                <div class="form-group">
                  <label>                  
                  <div style="color: #337ab7;"><b>부서 목록</b></div>
                  <div class="dept-container">
                  <c:forEach items="${dept}" var="i">
                  <div class="dept-item" onclick="selectMember(this.getAttribute('value'))" value="${i.name}">${i.name}</div>
                </c:forEach>
                </div>
              </label>
                  <select class="duallistbox" multiple="multiple">
            
                  </select>
                </div>
                <!-- /.form-group -->
              </div>
              <!-- /.col -->
            </div>
            <!-- /.row -->
          </div>
          <!-- /.card-body -->
         <div class="card-footer d-flex justify-content-center">
           <button id="blindBtn" class="btn btn-primary" type="button" onclick="selectValues()" data-dismiss="modal">선택</button> &nbsp &nbsp
           <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
         </div>

        </div>

         <!-- 모달 푸터 -->
      <div class="modal-footer">

      </div>


          </div>
        </div>
      </div>   
   </div>
   </div>
         <div class="form-group">
          <input type="text" class="form-control" name="title" maxlength="19"  placeholder="제목을 입력하세요">
         </div>
         
            <div class="form-group" style="height: 400px;">
              <textarea id="compose-textarea" class="form-control" name="content" style="height: 300px; display: none;">   
              </textarea>
            </div>
                
         <div class="form-group">
           <div class="btn btn-default btn-file">
             <i class="fas fa-paperclip"></i> 파일 첨부
             <input type="file" name="file" multiple="multiple" onchange="displayFileNames(event)" id="fileInput">
           </div>
           <div id="fileNames"></div>
         </div>


              <!-- /.card-body -->
              <div class="card-footer">
                <div class="float-right">
           
                  <button type="submit" class="btn btn-primary"><i class="far fa-envelope"></i> Send</button>
                </div>
                <button type="reset" class="btn btn-default" onclick="goBack()"><i class="fas fa-times"></i> 닫기</button>

              </div>
              <!-- /.card-footer -->
            </div>
            <!-- /.card -->
          </div>
          <!-- /.col -->
        </div>
        <!-- /.row -->
      </div><!-- /.container-fluid -->
      </div>
      </div>
    </section>
    <!-- /.content -->
  </form>
  </div>
  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <div class="float-right d-none d-sm-block">
      <b>Version</b> 3.2.0
    </div>
    <strong>Copyright &copy; 2014-2021 <a href="https://adminlte.io">AdminLTE.io</a>.</strong> All rights reserved.
  </footer>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->

<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<!-- Summernote -->
<script src="../../plugins/summernote/summernote-bs4.min.js"></script>


<script src="../../plugins/bootstrap4-duallistbox/jquery.bootstrap-duallistbox.min.js"></script>

<!-- Page specific script -->
<script>

$('.duallistbox').bootstrapDualListbox();

/*
$(function () {
    
})
*/
var sessionId = "${sessionScope.id}";


  $(function () {
    //Add text editor
    $('#compose-textarea').summernote()
  })
  
  
  
$("select[name=_helper1]").change(function(){
  console.log($(this).val()); 
  console.log($("select[name=_helper1] option:selected").text());
});
  
  
  
// 부서 선택시 사원 설정
function selectMember(deptName) {
  console.log(deptName);
  console.log('MemberByDept.ajax 호출');
  $.ajax({
    url: "MemberByDept.ajax",
    type: "POST",
    async: false,
    data: {
      'dept': deptName
    },
    dataType: "json",
    success: function(data) {
      console.log('MemberByDept.ajax 통신 성공');

      $('.duallistbox option').css('display', 'none'); // 전체 옵션을 숨김 처리
      $('.duallistbox option[data-sortindex]').css('display', 'block'); // data-sortindex 속성을 가진 옵션들을 보이도록 설정

      data.forEach(function(item) {
        var content = '<option value="' + item.id + '">' + item.member_name + " (" + item.user_id + ')</option>';

        if (item.dept_name === deptName) {
          $('.duallistbox').append(content); // 선택한 부서에 해당하는 옵션만 보여줌
          
        }
      });

      console.log('도달');
      // 새로고침해서 새로 불러오기 ! 
      $('.duallistbox').bootstrapDualListbox('refresh', true);
    },
    error: function() {
      console.log("사원 불러오기에 실패했습니다.");
    }
  });
}

  
  
  function goBack() {
  history.back();
}
  
$(function(){
   var chkObj = $('.duallistbox option[data-sortindex]');
   var rowCnt = chkObj.length;
   console.log(rowCnt);
     
     $("input[name='allCheck']").click(function(){
       var chk_listArr = $("input[name='Rowcheck']"); 
       for (var i=0; i<chk_listArr.length; i++){
         chk_listArr[i].checked = this.checked;
       }
     });
     $("input[name='Rowcheck']").click(function(){
        console.log(chkObj)
       if($("input[name='Rowcheck']:checked").length == rowCnt){ 
         $("input[name='allCheck']")[0].checked = true;
       }
       else{
         $("input[name='allCheck']")[0].checked = false;
       }
     });
   });
  
  
  function selectValues(){
     
        var valueArr = []; // 빈 배열로 초기화
        var valueArr2 = [];
        
        
        var chklist = $('.duallistbox option[data-sortindex]'); // 선택된 애들 가져옴

        if (chklist.length === 0) {
          alert("선택된 사원이 없습니다.");
          return; // 함수 종료
        }
       else{
         var chk = confirm("사원 선택이 완료되었습니다.");   
         
          // 선택된 체크박스의 값을 valueArr 배열에 추가
          chklist.each(function () {
            valueArr.push($(this).val());
          });
          
          chklist.each(function() {
               var memberName = $(this).closest('option').text().trim();
               valueArr2.push(memberName);
             });

       
          
          console.log(valueArr);
          console.log(valueArr2);
          console.log(chklist);
         
          
           var recipientInput = $("input[name='to_id']");
           recipientInput.val(valueArr.join(', ')); 
          
           var toplzInput = $("input[name='to_plz']");
           toplzInput.val(valueArr2.join(', '));
        

         $.ajax({
             url :'chk.send',                    // 전송 URL
             type : 'POST',                // GET or POST 방식
             traditional : true,
             data : {
                valueArr : valueArr        // 보내고자 하는 data 변수 설정
             },
               success: function(jdata){
                   if(jdata = 1) {
                       alert("사원 선택 완료");
                       $.each(jdata, function(index, item) {
                           $('#to_plz').val(item.name);
                       });
                   
                   
                   }
                   else{
                       alert("처리 실패");
                   }
                
               }
         });
         

         $('#memberModal').modal('hide');   
      }
        
   } 

  
  
  
  function counter(input, limit) {
     var count = input.value.length;
     var counterText = count + ' / ' + limit;
     input.setCustomValidity(counterText);

     if (count >= limit) {
       input.style.color = 'red';
     } else {
       input.style.color = ''; // 기본 색상으로 변경 (CSS 스타일 제거)
     }
   }

     function displayFileNames(event) {
          var fileNamesDiv = document.getElementById('fileNames');
          fileNamesDiv.innerHTML = '';
          
          var files = Array.from(event.target.files);
          files.forEach(function(file) {
            var fileNameSpan = document.createElement('span');
            fileNameSpan.innerText = file.name;

            var cancelIcon = document.createElement('i');
            cancelIcon.className = 'fas fa-times cancel-icon';
            cancelIcon.addEventListener('click', function() {
              removeFile(file, fileNameSpan);
            });

            var fileNameContainer = document.createElement('div');
            fileNameContainer.className = 'file-name-container';
            fileNameContainer.appendChild(fileNameSpan);
            fileNameContainer.appendChild(cancelIcon);

            fileNamesDiv.appendChild(fileNameContainer);
          });
        }

        function removeFile(file, fileNameSpan) {
          var fileInput = document.getElementById('fileInput');
          fileInput.value = '';

          fileNameSpan.parentNode.remove();
        }


</script>

</body>
</html>