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
	<h1>임시저장문서 상세보기</h1>
	<br>
	<br>
	문서번호 : <input type="text" name="id" value="${dto.id }" readonly="readonly"/>
	<br>
	제목 : <input type="text" name="subject" value="${dto.subject }" readonly="readonly"/>
	<br>
	기안자 : <input type="text" name="memberId" value="${dto.memberId }" readonly="readonly"/>
	<br>
	공개범위 : <input type="text" name="publicRange" value="${dto.publicRange }" readonly="readonly"/>
	<br>
	<div id="div_editor">
		<!-- 에디터 안에 들어갈 자리 -->
	</div>
	<textarea id="content" name="content" hidden="true">${dto.content }</textarea>
	<c:if test="${fileList.size() == 0 }">
		<div>첨부파일 없음.</div>
	</c:if>
	<c:if test="${fileList.size() > 0 }">
		<c:forEach items="${fileList }" var="i">
			<div>
				<a href="attachmentDownload.do?newFileName=${newFileName }">${i.oriFileName }</a>
				<a href="attachmentDelete.do?id${dto.id }&newFileName=${newFileName }">삭제</a>
			</div>
		</c:forEach>
	</c:if>

</body>
<script type="text/javascript" src="/richtexteditor/rte.js"></script>  
<script type="text/javascript" src='/richtexteditor/plugins/all_plugins.js'></script>
<script>
var config = {}; // 설정
config.editorResizeMode = "none"; // 에디터 크기조절 none

// 상세보기에서는 필요한 툴바만 노출할 예정(html 저장, 출력, pdf 저장, 코드보기만 남겨놓자)
config.toolbar="simple";
config.toolbar_simple="{save, print, html2pdf, code}";

var editor = new RichTextEditor("#div_editor", config);

var docForm = document.getElementById('content').value;
editor.setHTMLCode(docForm); // editor에 내용 넣기, docForm은 기본 양식
editor.setReadOnly();
</script>
</html>