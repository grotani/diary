<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>  
<%
	String diaryDate = request.getParameter("diaryDate");
	System.out.println(diaryDate + "글수정");
	
	String sql = "SELECT diary_date diaryDate,feeling, title, weather, content, update_date updatedate, create_date createdate FROM diary WHERE diary_date = ?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,diaryDate);
	//디버깅
	System.out.println(stmt + "일기수정하기");
	
	rs = stmt.executeQuery();
	
	if(rs.next()) { 
		
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<!-- 폰트설정 -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Single+Day&display=swap" rel="stylesheet">
	
	<!-- css -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<style>
		.single{
	  font-family: "Single Day", cursive;
	  font-weight: 400;
	  font-style: normal;
	}
	</style>
</head>
<body class="container single">
	<!-- 일기수정 내용 -->
	<div class="container p-5 my-5 border" style="background-size:70%;  background-image: url(/diary/img/flower.jpg)">
	<h1>일기수정</h1>
	</div>
	<form method="post" action="/diary/updateDiaryAction.jsp">
		<table class="table border">
		<tr>
			<td>day</td>
			<td><input type="text" name="diaryDate" value='<%=rs.getString("diaryDate")%>' readonly="readonly"></td>
		</tr>
		<tr>
			<td>feeling</td>
			<td><input type="text" name="feeling" value='<%=rs.getString("feeling")%>' readonly="readonly"></td>
		</tr>
		<tr>
			<td>title</td>
			<td><input type="text" name="title" value='<%=rs.getString("title")%>'></td>
		</tr>
		<tr>
			<td>weather</td>
			<td><input type="text" name="weather" value='<%=rs.getString("weather")%>' readonly="readonly"><td>
		</tr>
		<tr>
			<td>content</td>
			<td><textarea rows="10" cols="70" name="content"><%=rs.getString("content")%></textarea></td>
		</tr>

		<tr>
			<td>createdate</td>
			<td><input type="text" name="createdate" value='<%=rs.getString("createdate")%>' readonly="readonly"></td>
		</tr>
		
		</table>
		<button type="submit" class="btn btn-outline-warning">수정하기</button>
	</form>
	
	
</body>
</html>

<% 
	}
%>
