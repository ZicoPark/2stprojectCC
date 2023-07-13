<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Creator Company</title>
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
				<h1>결재한 문서</h1>
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
				<br>
				문서종류 : <input type="text" value="${doc.doc_form_name }" readonly="readonly"/>
				<br>
				<input type="button" value="재작성" onclick="rewriteDoc()"/>
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
				<input type="button" onclick="docStatusHistory()" value="결재상세보기"/>
				<input type="button" onclick="location.href='/objectionDocList.go'" value="리스트"/>
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

function rewriteDoc(){
	
	var subject = '${doc.subject}';
	// content는 위에 선언됨.
	var status = 2; // 임시저장문서로 만들거니까 status는 2로 고정한다.
	// member_id는 세션으로 받아오기
	var docFormId = '${doc.doc_form_id}';
	// deptId는 memberInfo에서 받아온다.
	// jobLevelName는 memberInfo에서 받아온다.
	var publicRange = '${doc.public_range}';
	
	var params = {subject, content, status, docFormId, publicRange};
	
	$.ajax({
		
		type:'post',
		url:'rewriteDoc.ajax',
		data:params,
		dataType:'json',
		success:function(data){
			
			if(data.updateRow != null && data.docId != null){
				location.href='tempDocUpdateForm.go?id='+data.docId;
			}
		},
		error:function(e){
			console.log(e);
		}
		
	});
	
}
</script>
</html>