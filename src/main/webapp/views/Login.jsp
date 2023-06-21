<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	
<style>

	table, th, td{

		border-collapse: collapse;
		padding : 5px 10px;
	}

	body{
		position:relative;
		font-size:15px;
		padding : 10px;

	}
		
	#content {

		padding: 10 30 10;
		margin-left : 40%;
		margin-top : 20%;
		float:inherit;
		
	}
	
	button {
		margin: 50px;
	}




</style>
</head>
<body>
<div id="content" >
	<form action="login.do" method="post">
		<table>
			<tr>
				<th>ID</th>
				<td><input type="text" name="id"/></td>
			</tr>
			<tr>
				<th>PW</th>
				<td><input type="password" name="password"/></td>
			</tr>
		</table>
		</br></br></br></br>
	<input type="button" value="회원가입" onclick="location.href='join.go'"/>
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	<input type="submit" value="로그인"/>
	</form>
</div>
</body>
<script>
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
</script>
</html>