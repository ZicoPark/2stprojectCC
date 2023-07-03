<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Creator Company</title>
<link rel="stylesheet" href="/richtexteditor/rte_theme_default.css" />

<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<style>
</style>
</head>
<body>
	<h1>임시저장문서 계속 작성하기</h1>
	<br>
	<br>
	<form action="docUpdate.do" method="post" enctype="multipart/form-data">
		<input type="text" name="id" value="${docDTO.id }" hidden="true"/>
		제목 : <input type="text" name="subject" value="${docDTO.subject }"/>
		<br>
		기안자 : <input type="text" value="${memberName }" readonly="readonly"/>
		<br>
		공개범위 : 
		<select name="publicRange">
			<option value="all" <c:if test="${docDTO.public_range == 'all' }">selected</c:if>>전체</option>
			<option value="dept" <c:if test="${docDTO.public_range == 'dept' }">selected</c:if>>부서별</option>
		</select>
		<br>
		문서종류 : ${docFormName }

		<br>
		<div id="approvalList">
		<input type="button" value="결재선 추가" onclick="addApproval()"/>
		<select name="approvalPriority">
			<option value="default">--</option>
			<c:forEach items="${approvalKindList}" var="i">
				<option value="${i.priority}">${i.name}</option>
			</c:forEach>
		</select>
		<select name="approvalMemberId">
			<option value="default">--</option>
			<c:forEach items="${memberList}" var="i">
				<option value="${i.id}">${i.dept_name} | ${i.name}</option>
			</c:forEach>
		</select>
		<br>
		</div>
		<div id="div_editor">
			<!-- 에디터 안에 들어갈 자리 -->
		</div>
		<textarea hidden="true" id="beforeContent">${docDTO.content }</textarea>
		<textarea hidden="true" id="afterContent" name="afterContent"></textarea>
		<input type="hidden" id="status" name="status"/>
		<input type="file" multiple="multiple" name="attachment"/>
		<c:if test="${attachmentList.size() == 0 }">
			<div>첨부파일 없음.</div>
		</c:if>
		<c:if test="${attachmentList.size() > 0 }">
			<c:forEach items="${attachmentList }" var="i">
				<div>
					<a href="attachmentDownload.do?oriFileName=${i.ori_file_name }&attachmentId=${i.id }">${i.ori_file_name }</a>
					<a href="attachmentDelete.do?docId=${docDTO.id }&attachmentId=${i.id }">삭제</a>
				</div>
			</c:forEach>
		</c:if>
		<input type="button" onclick="pushDoc()" value="제출"/>
		<input type="button" onclick="saveDoc()" value="임시저장"/>
	</form>
</body>
<script type="text/javascript" src="/richtexteditor/rte.js"></script>  
<script type="text/javascript" src='/richtexteditor/plugins/all_plugins.js'></script>
<script>
var config = {}; // 설정
config.editorResizeMode = "none"; // 에디터 크기조절 none

var editor = new RichTextEditor("#div_editor", config);

var beforeContent = document.getElementById('beforeContent').value;
editor.setHTMLCode(beforeContent); // editor에 내용 넣기, docForm은 기본 양식

// 결재선 추가할 때 쓸 변수 content, addApproval() 함수
var content = '';

content += '<input type="button" value="결재선 추가" onclick="addApproval()"/>';
content += '<select name="approvalPriority">';
content += '<option value="default">--</option>';
content += '<c:forEach items="${approvalKindList}" var="i">';
content += '<option value="${i.priority}">${i.name}</option>';
content += '</c:forEach>';
content += '</select>';

content += '<select name="approvalMemberId">';
content += '<option value="default">--</option>';
content += '<c:forEach items="${memberList}" var="i">';
content += '<option value="${i.id}">${i.dept_name} | ${i.name}</option>';
content += '</c:forEach>';
content += '</select>';
content += '<br>';

function addApproval(){
	
	$('#approvalList').append(content);
	
}

function pushDoc(){
	
	var submitContent = editor.getHTMLCode();
	$('textarea[name="afterContent"]').val(submitContent);
	$('input[name="status"]').val('1');
	$('form').submit();
	
}

function saveDoc(){
	
	var submitContent = editor.getHTMLCode();
	$('textarea[name="afterContent"]').val(submitContent);
	$('input[name="status"]').val('2');
	$('form').submit();
	
}
</script>
</html>