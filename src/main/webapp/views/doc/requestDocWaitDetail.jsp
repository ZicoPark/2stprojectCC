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
.modal {
	position: absolute;
	z-index: 2;
	top: 0;
	left: 0;
	
	width: 100%;
	height: 100%;
	
	display: none;
	
	background-color: rgba(0, 0, 0, 0.4);
}

.modal.show {
	display: block;
}

.modalBody {
	position: absolute;
	z-index: 1;
	top: 50%;
	left: 50%;
	
	width: 400px;
	height: 400px;
	
	padding: 40px;
	

	
	background-color: rgb(255, 255, 255);
	border-radius: 10px;
	box-shadow: 0 2px 3px 0 rgba(34, 36, 38, 0.15);
	
	transform: translateX(-50%) translateY(-50%);
}

textarea {
  resize: none;
}
</style>
</head>
<body>
	<jsp:include page="../index.jsp"/>
	<!-- Site wrapper -->
	<div class="wrapper">
		<div class="content-wrapper">
			<section class="content-header">
				<h1>결재대기문서</h1>
			</section>
			<!-- Main content -->
			<section class="content">
				<form action="requestDocApproval.do" method="post">
					<input type="text" name="docId" value="${doc.id }" hidden="true"/>
					제목 : <input type="text" value="${doc.subject }" readonly="readonly"/>
					<br>
					기안자 : <input type="text" value="${doc.create_member_name }" readonly="readonly"/>
					<br>
					결재요청시각 : ${doc.create_at }
					<br>
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
					결재단계 : ${doc.approval_kind_name }대기 중
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
					결재상태 : 
					<c:if test="${doc.approval eq '0' }">
						미결재
					</c:if>
					<c:if test="${doc.approval eq '1' }">
						결재
					</c:if>
					<c:if test="${doc.approval eq '2' }">
						반려
					</c:if>
					<br>
					문서종류 : <input type="text" value="${doc.doc_form_name }" readonly="readonly"/>
					<br>
					<div class="modal">
						<div class=modalBody>
							<h3>결재하기</h3>
							<br>
							결재여부 : 
							<br>
							<input type="radio" name="chooseApproval" value="1"/>결재&nbsp;&nbsp;
							<input type="radio" name="chooseApproval" value="2"/>반려
							<br>
							의견 : 
							<br>
							<textarea name="opinion"></textarea>
							<input type="submit" value="처리"/>
						</div>
					</div>
					<button type="button" class="modalOpenBtn">결재하기</button>
					<br>
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
					<input type="button" onclick="location.href='/requestDocWaitList.go'" value="리스트"/>
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

const body = document.querySelector('body');
const modal = document.querySelector('.modal');
const modalOpenBtn = document.querySelector('.modalOpenBtn');

modalOpenBtn.addEventListener('click', () => {
	modal.classList.toggle('show');

	if (modal.classList.contains('show')) {
		body.style.overflow = 'hidden';
	}
});

modal.addEventListener('click', (event) => {
	if (event.target === modal) {
		modal.classList.toggle('show');
	
		if (!modal.classList.contains('show')) {
			body.style.overflow = 'auto';
		}
	}
});
</script>
</html>