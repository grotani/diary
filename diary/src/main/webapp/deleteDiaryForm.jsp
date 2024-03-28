<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String diaryDate = request.getParameter("diaryDate");
	System.out.println(diaryDate + "<=일기삭제");
	String title = request.getParameter("title");
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<h1>일기 삭제하기</h1>
	<form method="post" 
		action="/diary/deleteDiaryAction.jsp">
	날짜 :
	<input type="text" name="diaryDate" value="<%=diaryDate %>">
	<br>
	
	<button type="submit">일기 삭제하기</button>
	
	</form>
</body>
</html>