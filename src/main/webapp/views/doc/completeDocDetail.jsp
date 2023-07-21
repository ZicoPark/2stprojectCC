<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>결재완료문서 상세보기</title>
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
th{
	text-align: center;
	font-size: 12px;
}
</style>
</head>
<body>
	<jsp:include page="../index.jsp"/>
	<!-- Site wrapper -->
	<div class="wrapper">
		<div class="content-wrapper">
			<section class="content-header">
				<h1>결재완료문서 상세보기</h1>
			</section>
			<!-- Main content -->
			<section class="content">
				<input type="text" value="${doc.id }" hidden="true"/>
				<div class="row">
					<div class="col-12">
						<button type="button" class="btn btn-default" data-toggle="modal" data-target="#modal-xl">
						결재정보 보기
						</button>
						<button type="button" onclick="location.href='/completeDocList.go'" class="btn btn-secondary float-right">
							<i class="fas fa-reply">
							리스트
							</i>
						</button>		
					</div>
				</div>
				<br>
				<div class="row">
					<div class="col-6">
						<select	class="form-control float-left" style="margin-bottom: 10px;" disabled>
							<option value="default">${doc.doc_form_name }</option>
						</select>
					</div>
					<div class="col-6">
						<select name="publicRange" class="form-control float-left" style="margin-bottom: 10px;" disabled>
							<option value="default">
								<c:if test="${doc.public_range eq 'all' }">전체</c:if>
								<c:if test="${doc.public_range eq 'dept' }">부서별</c:if>
							</option>
						</select>
					</div>
				</div>
				<div class="row">
					<div class="col-12">
						<br>
						<input type="text" value="${doc.subject }" class="form-control form-control-lg" readonly="readonly"/>
					</div>
				</div>
				<br>
				<div class="modal fade" id="modal-xl">
					<div class="modal-dialog modal-xl">
						<div class="modal-content">
							<div class="modal-header">
								<h4 class="modal-title">결재정보</h4>
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<!-- Table row -->
								<div class="row">
									<div class="col-12">
										<br>
										<table class="table">
											<thead>
												<tr>
													<th style="width: 5%;">순번</th>
													<th style="width: 10%;">결재종류</th>
													<th style="width: 8%;">부서</th>
													<th style="width: 5%;">직급</th>
													<th style="width: 8%;">이름</th>
													<th style="width: 5%;">읽음여부</th>
													<th style="width: 10%;">읽은시각</th>
													<th style="width: 5%;">결재여부</th>
													<th style="width: 10%;">처리시각</th>
													<th style="width: 34%;">의견</th>
												</tr>
											</thead>
											<tbody>
												<c:if test="${docStatusList.size() == 0 }">
													<tr>
														<td colspan="10">결재정보를 불러오는데 실패했습니다.</td>
													</tr>
												</c:if>
												<c:if test="${docStatusList.size() > 0 }">
													<c:forEach items="${docStatusList }" var="i">
														<tr>
															<td style="text-align: center;">${i.order_rank+1 }</td>
															<c:if test="${i.approval_kind_name eq '결재'}">
																<td style="text-align: center;"><span class="badge bg-red">${i.approval_kind_name }</span></td>
															</c:if>
															<c:if test="${i.approval_kind_name eq '검토'}">
																<td style="text-align: center;"><span class="badge bg-yellow">${i.approval_kind_name }</span></td>
															</c:if>
															<td style="text-align: center; font-size: 12px;">${i.dept_name }</td>
															<td style="text-align: center; font-size: 12px;">${i.job_name }</td>
															<td style="text-align: center; font-size: 12px;">${i.approval_member_name }</td>
															<c:if test="${i.read_chk eq true}">
																<td style="text-align: center;"><span class="badge bg-primary">읽음</span></td>
															</c:if>
															<c:if test="${i.read_chk eq false}">
																<td style="text-align: center;"><span class="badge bg-gray">읽지않음</span></td>
															</c:if>
															<td style="text-align: center;"><span class="badge bg-primary">${i.read_at }</span></td>
															<c:if test="${i.approval eq '0'}">
																<td style="text-align: center;"><span class="badge bg-gray">대기</span></td>
															</c:if>
															<c:if test="${i.approval eq '1'}">
																<td style="text-align: center;"><span class="badge bg-green">정상결재</span></td>
															</c:if>
															<c:if test="${i.approval eq '2'}">
																<td style="text-align: center;"><span class="badge bg-red">반려</span></td>
															</c:if>
															<td style="text-align: center;"><span class="badge bg-primary">${i.approval_at }</span></td>
															<td style="text-align: left;"><span style="font-size: 10px;">${i.opinion }</span></td>
														</tr>
													</c:forEach>
												</c:if>
											</tbody>
										</table>
									</div>
									<!-- /.col -->
								</div>
								<!-- /.row -->
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
				<!-- /.modal -->
				<div id="div_editor">
					<!-- 에디터 안에 들어갈 자리 -->
				</div>
				<textarea hidden="true" id="content">${doc.content }</textarea>
				<!-- Table row -->
				<div class="row">
					<div class="col-12">
						<br>
						<table class="table">
							<thead>
								<tr>
									<th style="width: 5%;">순번</th>
									<th colspan="2">파일명</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${attachmentList.size() == 0 }">
									<tr>
										<td colspan="3">첨부파일 없음.</td>
									</tr>
								</c:if>
								<c:if test="${attachmentList.size() > 0 }">
									<c:forEach items="${attachmentList }" var="i" varStatus="varStatus">
									<tr>
										<td style="text-align: center;">${varStatus.count }</td>
										<td colspan="2">
											<a href="docAttachmentDownload.do?oriFileName=${i.ori_file_name }&attachmentId=${i.id }">${i.ori_file_name }</a>
										</td>
									</tr>
									</c:forEach>
								</c:if>
							</tbody>
						</table>
					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
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
</script>
</html>