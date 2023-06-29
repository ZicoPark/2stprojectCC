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
		문서번호 : <input type="text" name="id" value="${docDTO.id }" readonly="readonly"/>
		<br>
		제목 : <input type="text" name="subject" value="${docDTO.subject }"/>
		<br>
		기안자 : <input type="text" value="${docDTO.memberId }" readonly="readonly"/>
		<br>
		공개범위 : 
		<select name="publicRange">
			<option value="all" <c:if test="${docDTO.publicRange == 'all' }">selected</c:if>>전체</option>
			<option value="dept" <c:if test="${docDTO.publicRange == 'dept' }">selected</c:if>>부서별</option>
		</select>
		<br>
		문서종류 : 공사중

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
					<a href="attachmentDownload.do?oriFileName=${i.oriFileName }&newFileName=${i.newFileName }">${i.oriFileName }</a>
					<a href="attachmentDelete.do?id=${docDTO.id }&newFileName=${i.newFileName }">삭제</a>
				</div>
			</c:forEach>
		</c:if>
		<input type="button" onclick="pushDoc()" value="제출"/>
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
	$('textarea[name="afterContent"]').val(submitContent);
	$('input[name="status"]').val('1');
	$('form').submit();
	
}
</script>
</html>