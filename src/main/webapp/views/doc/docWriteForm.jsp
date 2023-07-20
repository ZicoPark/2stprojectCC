<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>새 문서 작성</title>
<link rel="icon" href="/img/CC_favicon.png">
<link rel="stylesheet" href="/richtexteditor/rte_theme_default.css" />
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>

<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="../../dist/css/adminlte.min.css">
<style>
</style>
</head>
<body>
	<jsp:include page="../index.jsp"/>
	<!-- Site wrapper -->
	<div class="wrapper">
		<div class="content-wrapper">
			<section class="content-header">
				<h1>새 문서 작성</h1>
			</section>
			<!-- Main content -->
			<section class="content">
				<form action="docWrite.do" method="post" enctype="multipart/form-data">
					<div class="col-12">
						<button type="button" class="btn btn-default" data-toggle="modal" data-target="#modal-default">
						결재선 지정
						</button>
						<button type="button" onclick="saveDoc()" class="btn btn-primary float-right" style="margin-left: 5px;">
							<i class="fas fa-save">
							임시저장
							</i>
						</button>
						<button type="button" onclick="pushDoc()" class="btn btn-primary float-right">
							<i class="fas fa-inbox">
							결재신청
							</i>
						</button>
					</div>
					<br>
					<div class="row">
						<div class="col-6">
							<select id="docForm" name="docFormId" onchange="docFormListCall(this)" class="form-control float-left" style="margin-bottom: 10px;">
								<option value="default">양식 선택</option>
								<c:forEach items="${docFormList}" var="i">
									<option value="${i.id}">${i.name}</option>
								</c:forEach>
							</select>
							<c:forEach items="${docFormList}" var="i">
								<textarea id="${i.id}" hidden="true">${i.content}</textarea>
							</c:forEach>
						</div>
						<div class="col-6">
							<select name="publicRange" id="publicRange" class="form-control float-left" style="margin-bottom: 10px;">
								<option value="default">공개범위 선택</option>
								<option value="all">전체</option>
								<option value="dept">부서별</option>
							</select>
						</div>
						<div class="col-12">
							<br>
							<input type="text" name="subject" id="subject" value="" placeholder="제목을 입력하세요" maxlength="30" class="form-control form-control-lg" required="required"/>
						</div>
					</div>
					<div class="modal fade" id="modal-default">
						<div class="modal-dialog modal-lg">
							<div class="modal-content">
								<div class="modal-header">
									<h4 class="modal-title">결재선 지정</h4>
									<button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="deleteApprovalLine()">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body">
									<div id="approvalList">
										<div id="approvalDiv" class="row" style="margin-bottom: 3px;">
											<div>
												<a class="btn btn-default" onclick="addApproval(this)">
		                              				<i class="fas fa-plus"></i>
		                              				추가
		                          				</a>
											</div>
											<div class="col-4">
											<select name="approvalPriority" class="form-control float-left approvalPriority">
												<option value="default">--</option>
												<c:forEach items="${approvalKindList}" var="i">
													<option value="${i.priority}">${i.name}</option>
												</c:forEach>
											</select>
											</div>
											<div class="col-4">
												<select name="approvalMemberId" class="form-control float-left approvalMemberId">
													<option value="default">--</option>
													<c:forEach items="${memberList}" var="i">
														<option value="${i.id}">${i.dept_name} | ${i.job_level_name} ${i.name}</option>
													</c:forEach>
												</select>
											</div>
											<br>
										</div>
									</div>
								</div>
								<div class="modal-footer justify-content-between">
									<button type="button" class="btn btn-default" data-dismiss="modal" onclick="approvalTest()">확인</button>
								</div>
							</div>
							<!-- /.modal-content -->
						</div>
						<!-- /.modal-dialog -->
					</div>
					<!-- /.modal -->
					<br>
					<div id="div_editor">
						<!-- 에디터 안에 들어갈 자리 -->
					</div>
					<textarea hidden="true" id="content" name="content"></textarea>
					<input type="hidden" id="status" name="status"/>
					<br>
					<div class="custom-file">
						<input type="file" multiple="multiple" id="attachment" name="attachment" class="custom-file-input"/>
						<label class="custom-file-label" for="attachment">
						첨부파일을 선택하세요.
						</label>
					</div>
				</form>
			</section>
		</div>
	</div>
</body>
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>
<!-- bs-custom-file-input -->
<script src="../../plugins/bs-custom-file-input/bs-custom-file-input.min.js"></script>

<script type="text/javascript" src="/richtexteditor/rte.js"></script>  
<script type="text/javascript" src='/richtexteditor/plugins/all_plugins.js'></script>
<script>
var config = {}; // 설정
config.editorResizeMode = "none"; // 에디터 크기조절 none

var editor = new RichTextEditor("#div_editor", config);

function docFormListCall(elem){

	var docForm = document.getElementById(elem.value).value;
	editor.setHTMLCode(docForm); // editor에 내용 넣기, docForm은 기본 양식
	
}

// 결재선 추가할 때 쓸 변수 content, addApproval() 함수
var content = '';

content += '<div id="approvalDiv" class="row" style="margin-bottom: 3px;">';
content += '<div>';
content += '<a class="btn btn-default" onclick="addApproval(this)">';
content += '<i class="fas fa-plus"></i>';
content += '추가';
content += '</a>';
content += '</div>';
content += '<div class="col-4">';
content += '<select name="approvalPriority" class="form-control float-left approvalPriority">';
content += '<option value="default">--</option>';
content += '<c:forEach items="${approvalKindList}" var="i">';
content += '<option value="${i.priority}">${i.name}</option>';
content += '</c:forEach>';
content += '</select>';
content += '</div>';
content += '<div class="col-4">';
content += '<select name="approvalMemberId" class="form-control float-left approvalMemberId">';
content += '<option value="default">--</option>';
content += '<c:forEach items="${memberList}" var="i">';
content += '<option value="${i.id}">${i.dept_name} | ${i.job_level_name} ${i.name}</option>';
content += '</c:forEach>';
content += '</select>';
content += '</div>';
content += '<div>';
content += '<a class="btn btn-danger" onclick="deleteApproval(this)">';
content += '<i class="fas fa-minus"></i>';
content += '삭제';
content += '</a>';
content += '</div>';
content += '<br>';
content += '</div>';


function addApproval(elem){
	
	$(elem).parents('#approvalList').append(content);
	
}

function deleteApproval(elem){
	
	$(elem).parents('#approvalDiv').remove();
	
}

function pushDoc(){
	
	var submitContent = editor.getHTMLCode();
	$('textarea[name="content"]').val(submitContent);
	$('input[name="status"]').val('1');
	
	var approvalPriorityArr = [];
	var approvalMemberIdArr = [];
	
	for(var i=0;i<document.getElementsByClassName('approvalPriority').length;i++){
		approvalPriorityArr.push(document.getElementsByClassName('approvalPriority')[i].value);
	}
	for(var i=0;i<document.getElementsByClassName('approvalMemberId').length;i++){
		approvalMemberIdArr.push(document.getElementsByClassName('approvalMemberId')[i].value);
	}
	
	if($('#subject').val().length==0){
		alert('문서 제목을 입력하세요.');
	}else if(approvalPriorityArr.includes('default')){
		alert('결재선을 선택하세요.');
	}else if(approvalMemberIdArr.includes('default')){
		alert('결재선을 선택하세요.');
	}else if(document.getElementById('docForm').value == 'default'){
		alert('양식을 선택하세요.');
	}else if(document.getElementById('publicRange').value == 'default'){
		alert('공개범위를 선택하세요.');
	}else{
		$('form').submit();
	}
	
}

function saveDoc(){
	
	var submitContent = editor.getHTMLCode();
	$('textarea[name="content"]').val(submitContent);
	$('input[name="status"]').val('2');
	
	var approvalPriorityArr = [];
	var approvalMemberIdArr = [];
	
	for(var i=0;i<document.getElementsByClassName('approvalPriority').length;i++){
		approvalPriorityArr.push(document.getElementsByClassName('approvalPriority')[i].value);
	}
	for(var i=0;i<document.getElementsByClassName('approvalMemberId').length;i++){
		approvalMemberIdArr.push(document.getElementsByClassName('approvalMemberId')[i].value);
	}
	
	if($('#subject').val().length==0){
		alert('문서 제목을 입력하세요.');
	}else if(document.getElementById('docForm').value == 'default'){
		alert('양식을 선택하세요.');
	}else if(document.getElementById('publicRange').value == 'default'){
		alert('공개범위를 선택하세요.');
	}else{
		$('form').submit();
	}
	
}

$(function () {
	bsCustomFileInput.init();
});

function deleteApprovalLine(){
	
	var defaultContent = '';
	
	defaultContent += '<div id="approvalDiv" class="row" style="margin-bottom: 3px;">';
	defaultContent += '<div>';
	defaultContent += '<a class="btn btn-default" onclick="addApproval(this)">';
	defaultContent += '<i class="fas fa-plus"></i>';
	defaultContent += '추가';
	defaultContent += '</a>';
	defaultContent += '</div>';
	defaultContent += '<div class="col-4">';
	defaultContent += '<select name="approvalPriority" class="form-control float-left approvalPriority">';
	defaultContent += '<option value="default">--</option>';
	defaultContent += '<c:forEach items="${approvalKindList}" var="i">';
	defaultContent += '<option value="${i.priority}">${i.name}</option>';
	defaultContent += '</c:forEach>';
	defaultContent += '</select>';
	defaultContent += '</div>';
	defaultContent += '<div class="col-4">';
	defaultContent += '<select name="approvalMemberId" class="form-control float-left approvalMemberId">';
	defaultContent += '<option value="default">--</option>';
	defaultContent += '<c:forEach items="${memberList}" var="i">';
	defaultContent += '<option value="${i.id}">${i.dept_name} | ${i.job_level_name} ${i.name}</option>';
	defaultContent += '</c:forEach>';
	defaultContent += '</select>';
	defaultContent += '</div>';
	defaultContent += '<br>';
	defaultContent += '</div>';

	$('#approvalList').empty();
	$('#approvalList').append(defaultContent);
	
}

function approvalTest(){

	var approvalPriorityArr = [];
	var approvalMemberIdArr = [];
	
	for(var i=0;i<document.getElementsByClassName('approvalPriority').length;i++){
		approvalPriorityArr.push(document.getElementsByClassName('approvalPriority')[i].value);
	}
	for(var i=0;i<document.getElementsByClassName('approvalMemberId').length;i++){
		approvalMemberIdArr.push(document.getElementsByClassName('approvalMemberId')[i].value);
	}
	
	const findDuplicatesPriority = approvalPriorityArr => approvalPriorityArr.filter((item, index) => approvalPriorityArr.indexOf(item) !== index)
	const duplicatesPriorityArr = findDuplicatesPriority(approvalPriorityArr);

	const findDuplicatesMemberId = approvalMemberIdArr => approvalMemberIdArr.filter((item, index) => approvalMemberIdArr.indexOf(item) !== index)
	const duplicatesMemberIdArr = findDuplicatesMemberId(approvalMemberIdArr);

	var loginId = '${sessionScope.id}';
	
	if(approvalPriorityArr.includes('default') || approvalMemberIdArr.includes('default')){
		// 결재종류나 memberId에 default가 있어서는 안된다.
		alert('선택되지 않은 결재종류나 결재자가 있습니다.');
		deleteApprovalLine();
	}else if(approvalPriorityArr[approvalPriorityArr.length-1]==2){
		// 최종 결재자는 2=검토 이어서는 안된다.
		alert('최종 결재자는 전결 혹은 결재로 지정해야 합니다.');
		deleteApprovalLine();
	}else if(approvalPriorityArr.includes('3') && approvalPriorityArr.includes('4')){
		// 한 문서에 전결=3, 결재=4는 같이 있을 수 없다.
		alert('전결 혹은 결재는 한 명만 지정해야 합니다.');
		deleteApprovalLine();
	}else if(duplicatesPriorityArr.includes('3') || duplicatesPriorityArr.includes('4')){
		// 한 문서에 전결=3, 결재=4가 여러 개 있으면 안된다.
		alert('전결 혹은 결재는 여러 번 지정할 수 없습니다.');
		deleteApprovalLine();
	}else if(duplicatesMemberIdArr.length>0){
		// 한 문서에 memberId가 중복되어 여러 개 있으면 안된다.
		alert('동일한 결재자가 존재하면 안됩니다.');
		deleteApprovalLine();
	}else if(approvalMemberIdArr.includes(loginId)){
		// 자기 자신이 결재자로 들어가면 안된다.
		alert('자기 자신은 결재선에 들어갈 수 없습니다.');
	}
	
}
</script>
</html>