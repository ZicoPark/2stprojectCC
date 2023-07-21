<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>프로젝트 추가</title>
<link rel="icon" href="/img/CC_favicon.png">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <!-- Tempusdominus Bootstrap 4 -->
  <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
</head>
<body class="hold-transition sidebar-mini">
<jsp:include page = "index.jsp"></jsp:include>
<!-- Site wrapper -->
<div class="wrapper">
  


  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>프로젝트 생성</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Project Add</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

<form action="project_add.do" method="post">
    <section class="content">
      <div class="row justify-content-center">
        <div class="col-md-6">
          <div class="card card-primary">
            <div class="card-header">
              <h3 class="card-title">입력란</h3>

              <div class="card-tools">
                <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                  <i class="fas fa-minus"></i>
                </button>
              </div>
            </div>
            <div class="card-body">
              <div class="form-group">
                <label for="inputName">프로젝트 제목</label>
                <input type="text" id="inputName" class="form-control" name = "name">
              </div>
              
              <div class="form-group">
				  <label for="inputMember">참가자</label>
				  <input type="text" id="inputMember" class="form-control" name="user_id" readonly="readonly">
				  <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#chatCreateModal" onclick="create()">참가자 초대하기</button>
				</div>
				
				
				<div class="modal fade" id="chatCreateModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
			<div class="modal-content">
			
				<div class="user-container modal-header">
					<label class="modal-title" id="staticBackdropLabel" for="nickname">참가자 초대하기</label>
					<span id="nickname" ></span>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
			
				<div class="display-container modal-body" style="height: 1000px">
					<div class="chatting-list-create">	
					</div>
				</div>	
				
				<div class="input-container modal-footer">
					<button type="button" id="send-button-create" class="send-button-create btn btn-primary" style="width: 30%;">참가자 초대하기</button>
				</div>
			
			</div>
		</div>
	</div>
				
				
				
				
				
              <div class="form-group">
                <label for="inputPublic_range">공개범위</label>
                <select id="inputPublic_range" class="form-control custom-select" name="public_range">
                  <option value="1">전체</option>
                  <option value="0">참여자만</option>
                </select>
              </div>
              
              <div class="form-group">
                <label for="inputPriod">시작일</label>
                <input type="date" class="form-control"  id="start_at" name="start_at" placeholder="시작일">
              </div>

              <div class="form-group">
                <label for="inputDeadLinePriod">마감일</label>
                <input type="date" class="form-control" id="end_at" name="end_at" placeholder="마감일">
              </div>
              
            </div>
            <!-- /.card-body -->
          </div>
          <!-- /.card -->
      <div class="row">
        <div class="col-12">
          <a href="projects.go" class="btn btn-secondary">취소</a>
          <input type="button" onclick="okay()" value="생성하기" class="btn btn-success float-right">
        </div>
      </div>
        </div>

      </div>
    </section>
    </form>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->


  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->

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


<script>
function okay() {
    console.log('저장');

    if ($('#inputName').val() == "") {
       alert("제목을 등록해주세요");
    }else if($('#inputMember').val() == ""){
    	alert("참가자를 등록해주세요");
    }else if($('#start_at').val() == ""){
    	alert("시작일을 등록해주세요");
    }else if ($('#end_at').val() == ""){
    	alert("마감일을 등록해주세요");
    }else {
       $('form').submit();
    }
 }

function create() {
	console.log('create() 호출');
	$.ajax({
		url:'pjMemberListAll.ajax',
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
					content+='<tr><th><input type="checkbox" name="id" value="'+item.user_id+'"></th><th>'+item.name+'</th><th>'+item.dept_name+'</th></tr>';
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
    var user_id_array = [];
    if ($('input:checkbox[name="id"]:checked').length == 0) {
        alert('한명 이상의 사원을 선택해주세요 !');
    } else {
        $('input:checkbox[name="id"]').each(function() {
            if ($(this).is(":checked") == true) {
                member_id_array.push($(this).val());
                $('#inputMember').val(member_id_array);
            }
        });
    }
    console.log(member_id_array);
});

$('#send-button-create').click(function() {

	$('#chatCreateModal').modal('hide');
});

</script>
</body>
</html>
