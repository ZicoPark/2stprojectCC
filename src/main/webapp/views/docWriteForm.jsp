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
		<select id="doc_form" onchange="docForm(this)">
			<option value="default">--</option>
			<c:forEach items="${docFormList}" var="i">
				<option value="${i.code}">${i.name}</option>
			</c:forEach>
		</select>
		<c:forEach items="${docFormList}" var="i">
			<textarea id="${i.code}" hidden="true">${i.content}</textarea>
		</c:forEach>
		<br>
		<select name="approvalVariable">
			<option value="default">--</option>
			<c:forEach items="${approvalKindList}" var="i">
				<option value="${i.id}">${i.name}</option>
			</c:forEach>
		</select>
		<select name="approvalPerson1">
			<option value="default">--</option>
			<c:forEach items="${memberList}" var="i">
				<option value="${i.id}">${i.deptName} | ${i.name}</option>
			</c:forEach>
		</select>
		<input type="button" value="결재선 추가" onclick="addApproval(this)"/>
		<br>

		<div id="div_editor">
			<!-- 에디터 안에 들어갈 자리 -->
		</div>
	</form>
</body>
<script type="text/javascript" src="/richtexteditor/rte.js"></script>  
<script type="text/javascript" src='/richtexteditor/plugins/all_plugins.js'></script>
<script>
var config = {}; // 설정
config.editorResizeMode = "none"; // 에디터 크기조절 none

var editor = new RichTextEditor("#div_editor", config);

function docForm(elem){

//	console.log(elem.value);
	
	var docForm = document.getElementById(elem.value).value;
	
//	console.log(docForm);
	
	editor.setHTMLCode(docForm); // editor에 내용 넣기, docForm은 기본 양식
}

function addApproval(elem){
	
	console.log(elem);
	
}

</script>
</html>