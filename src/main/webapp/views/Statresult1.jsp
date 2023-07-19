<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${full}">
      ${elem}
   </c:if>
   
   <c:if test="${!full}">
      <c:forEach items="${elem}" var="item">
         <ul>
            <li class="title">
               ${item.title}
            </li>
            <li>${item.content}</li>
         </ul>
      </c:forEach>
   </c:if>
</body>
</html>