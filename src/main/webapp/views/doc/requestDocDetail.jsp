<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
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
	<jsp:include page="../index.jsp"/>
	<!-- Site wrapper -->
	<div class="wrapper">
		<div class="content-wrapper">
			<section class="content-header">
				<h1>결재요청문서</h1>
			</section>
			<!-- Main content -->
			<section class="content">
				<input type="text" value="${doc.id }" hidden="true"/>
				제목 : <input type="text" value="${doc.subject }" readonly="readonly"/>
				<br>
				기안자 : <input type="text" value="${doc.create_member_name }" readonly="readonly"/>
				<br>
				결재요청시각 : ${doc.create_at }
				생산부서 : ${doc.production_dept_name }
				<br>
				공개범위 : 
				<c:if test="${doc.public_range eq 'all' }">
					전체공개
				</c:if>
				<c:if test="${doc.public_range eq 'dept' }">
					부서별공개
				</c:if>
				<br>
				결재단계 : ${doc. approval_kind_name}대기 중
				<br>
				처리자 : ${doc.approval_member_job_name } ${doc.approval_member_name }
				<br>
				읽음여부 : 
				<c:if test="${doc.read_chk eq true }">
					읽음
				</c:if>
				<c:if test="${doc.read_chk eq false }">
					안읽음
				</c:if>
				<br>
				문서종류 : <input type="text" value="${doc.doc_form_name }" readonly="readonly"/>
				<br>
				<input type="button" value="문서회수" onclick="withDraw()"/>
				<div id="div_editor">
					<!-- 에디터 안에 들어갈 자리 -->
				</div>
				<textarea hidden="true" id="content">${doc.content }</textarea>
				<c:if test="${attachmentList.size() == 0 }">
					<div>첨부파일 없음.</div>
				</c:if>
				<c:if test="${attachmentList.size() > 0 }">
					<c:forEach items="${attachmentList }" var="i">
						<div>
							<a href="attachmentDownload.do?oriFileName=${i.ori_file_name }&attachmentId=${i.id }">${i.ori_file_name }</a>
						</div>
					</c:forEach>
				</c:if>
				<input type="button" onclick="location.href='/requestDocList.go'" value="리스트"/>
			</section>
		</div>
	</div>
</body>
<script type="text/javascript" src="/richtexteditor/rte.js"></script>  
<script type="text/javascript" src='/richtexteditor/plugins/all_plugins.js'></script>
<script>
var config = {}; // 설정
config.editorResizeMode = "none"; // 에디터 크기조절 none

// 상세보기에서는 필요한 툴바만 노출할 예정(html 저장, 출력, pdf 저장, 코드보기만 남겨놓자)
config.toolbar="simple";
config.toolbar_simple="{print, html2pdf, code}";

var editor = new RichTextEditor("#div_editor", config);

var content = document.getElementById('content').value;
editor.setHTMLCode(content); // editor에 내용 넣기
editor.setReadOnly();

function withDraw(){
// 비동기방식으로 withDrawChk와 읽은시간을 가져온다.
//	var withDrawChk = '${withDrawChk}';
	var docId = '${doc.id }';
	$.ajax({
		type:'post',
		url:'docWithDraw.ajax',
		data:{
			docId:docId
		},
		dataType:'json',
		success:function(data){
			console.log(data);
		},
		error:function(e){
			console.log(e);
		}
	});
	
}
</script>
</html>