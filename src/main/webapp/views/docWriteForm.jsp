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
	<select name="doc_form" onclick="docFormCall(this)">
		<option value="">---</option>
	</select>
	<div id="div_editor1">
		<p>Initial Document Content</p>
	</div>
</body>
<script type="text/javascript" src="/richtexteditor/rte.js"></script>  
<script type="text/javascript" src='/richtexteditor/plugins/all_plugins.js'></script>
<script>
var editor1 = new RichTextEditor("#div_editor1");

function docFormCall(elem){
	
	console.log('docFormCall !');
	console.log(elem);
	
	$.ajax({
		
		type: 'get',
		url: 'docFormCall.ajax',
		data: {},
		dataType: 'json',
		success: function(data){
			console.log(data);
			docFormListDraw(data);
		},
		error: function(e){
			console.log(e);
		}
		
	});
	
}

function docFormListDraw(docFormList){
	
	console.log(docFormList);
}
</script>
</html>