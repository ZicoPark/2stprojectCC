<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/richtexteditor/rte_theme_default.css" />

<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<style>
</style>
</head>
<body>
	<h1>새 문서 작성</h1>
	<br>
	<br>
	<br>
	<select name="doc_form" id="doc_form" onchange="docForm(this)">
		<option value="default">--</option>
		<c:forEach items="${docFormList}" var="i">
			<option value="${i.code}">${i.name}</option>
		</c:forEach>
	</select>
	<c:forEach items="${docFormList}" var="i">
		<textarea id="${i.code}" hidden="true">${i.content}</textarea>
	</c:forEach>
	<div id="div_editor">
		<p>Creator Company</p>
	</div>
</body>
<script type="text/javascript" src="/richtexteditor/rte.js"></script>  
<script type="text/javascript" src='/richtexteditor/plugins/all_plugins.js'></script>
<script>
var config = {}; // 설정
config.editorResizeMode = "none"; // 에디터 크기조절 none

var editor = new RichTextEditor("#div_editor",config);

function docForm(elem){

	console.log(elem.value);
	
	var doc_form = document.getElementById(elem.value).value;
	
	console.log(doc_form);
	
	editor.setHTMLCode(doc_form); // editor에 내용 넣기, doc_form은 기본 양식
}
</script>
</html>