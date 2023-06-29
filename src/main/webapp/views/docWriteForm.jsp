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
	<h1>새 문서 작성</h1>
	<br>
	<br>
	<form action="docWrite.do" method="post" enctype="multipart/form-data">
		<select id="docForm" name="docFormId" onchange="docFormCall(this)">
			<option value="default">--</option>
			<c:forEach items="${docFormList}" var="i">
				<option value="${i.code}">${i.name}</option>
			</c:forEach>
		</select>
		<c:forEach items="${docFormList}" var="i">
			<textarea id="${i.code}" hidden="true">${i.content}</textarea>
		</c:forEach>
		<br>
		<input type="text" name="subject" value="" placeholder="제목을 입력하세요"/>
		<br>
		<select name="publicRange">
			<option value="all">전체</option>
			<option value="dept">부서별</option>
		</select>
		<br>
		<div id="approvalList">
		<input type="button" value="결재선 추가" onclick="addApproval()"/>
		<select name="approvalVariable">
			<option value="default">--</option>
			<c:forEach items="${approvalKindList}" var="i">
				<option value="${i.id}">${i.name}</option>
			</c:forEach>
		</select>
		<select name="approvalPerson">
			<option value="default">--</option>
			<c:forEach items="${memberList}" var="i">
				<option value="${i.id}">${i.deptName} | ${i.name}</option>
			</c:forEach>
		</select>
		<br>
		</div>
		<div id="div_editor">
			<!-- 에디터 안에 들어갈 자리 -->
		</div>
		<textarea hidden="true" id="content" name="content"></textarea>
		<input type="hidden" id="status" name="status"/>
		<input type="file" multiple="multiple" name="attachment"/>
		
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

function docFormCall(elem){

	var docForm = document.getElementById(elem.value).value;
	editor.setHTMLCode(docForm); // editor에 내용 넣기, docForm은 기본 양식
	
}

// 결재선 추가할 때 쓸 변수 content, addApproval() 함수
var content = '';

content += '<input type="button" value="결재선 추가" onclick="addApproval()"/>';
content += '<select name="approvalVariable">';
content += '<option value="default">--</option>';
content += '<c:forEach items="${approvalKindList}" var="i">';
content += '<option value="${i.id}">${i.name}</option>';
content += '</c:forEach>';
content += '</select>';

content += '<select name="approvalPerson">';
content += '<option value="default">--</option>';
content += '<c:forEach items="${memberList}" var="i">';
content += '<option value="${i.id}">${i.deptName} | ${i.name}</option>';
content += '</c:forEach>';
content += '</select>';
content += '<br>';

function addApproval(){
	
	$('#approvalList').append(content);
	
}

function pushDoc(){
	
	var submitContent = editor.getHTMLCode();
	$('textarea[name="content"]').val(submitContent);
	$('input[name="status"]').val('1');
	$('form').submit();
	
}

function saveDoc(){
	
	var submitContent = editor.getHTMLCode();
	$('textarea[name="content"]').val(submitContent);
	$('input[name="status"]').val('2');
	$('form').submit();
	
}

</script>
</html>