<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>

<%
	//로그인 인증 분기
	String loginMember = (String)(session.getAttribute("loginMember"));
	System.out.println(loginMember + "<=loginMember ");

	if(loginMember == null) { // 로그아웃일때 
		String errMsg = URLEncoder.encode("잘못된 접근 입니다. 로그인 먼저 해주세요", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg);
		return;
	}
%>

<%
	/*
	//로그인 인증 분기 
	// db이름 _ diary.login.my_session => 'OFF' 일때 => 리다이렉트 ("loginForm.jsp")로

	String sql1 = "select my_session mySession from login";
	
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	
	String mySession = null;
	if(rs1.next()) { 
		mySession = rs1.getString("mySession");
		
	}
	if(mySession.equals("OFF")) { 
		String errMsg = URLEncoder.encode("잘못된 접근 입니다. 로그인 먼저 해주세요", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg); // 로그인이 안되었을때 다시 로그인 폼 페이지로 이동합니다.
	
		return; // 코드 진행을 끝내는 return문법 예)메서드 끝낼때 return문 사용
	}
	
	*/
	/*
		SELECT diary_date diarydate, title, weather, content, update_date updatedate, create_date createdate
		FROM diary WHERE diary_date = ;
	*/

	
	String diaryDate = request.getParameter("diaryDate");
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	System.out.println(diaryDate);
	String sql2 = "SELECT diary_date diaryDate ,feeling, title, weather, content, update_date updatedate, create_date createdate FROM diary WHERE diary_date = ?";
	System.out.println(sql2);	
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	stmt2 =  conn.prepareStatement(sql2);
	stmt2.setString(1, diaryDate);
	//디버깅
	System.out.println(stmt2+"상세보기");
	rs2 = stmt2.executeQuery();
	

	// 페이지 카운팅 
	/*String sql3 = "select count(diary_date) from diary";
	PreparedStatement stmt3 = null;
	ResultSet rs3 = null;
	stmt3 = conn.prepareStatement(sql3);
	rs3 = stmt3.executeQuery();
	
	int totalRow = 0;
	if(rs3.next()) { 
		totalRow = rs3.getInt("count(diary_date)");
	}
	System.out.println(totalRow+"<==토탈Row디버깅");
	*/
	
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
		  
		a:link {color:#FF5E00; text-decoration: none;}
		a:visited {color:#FF5E00;}	  
	</style>
</head>

<body class="container single"  style= "margin-top: 100px">	
	<nav class="navbar navbar-expand-sm bg-light  navbar-light">
			<div class="container-fluid">
			<ul class="navbar-nav">
				<li class="nav-item">
					<a class="nav-link" href="/diary/diary.jsp">다이어리 보기</a>
				</li>
				<li class="nav-item">
					<a class="nav-link"  href="/diary/diaryList.jsp">게시판</a>
				</li>	
			</ul>
	</nav>
	<!-- 메인내용 -->
	<div class="container p-5 my-5 border" style="background-size:70%;  background-image: url(/diary/img/flower.jpg)">
		<h1 class = "text-center" style="color:#FF5E00">일기장 상세보기</h1>
	
	<%
		if(rs2.next()) { 
	%>
		<table class="table border">
			<tr>
				<td>diaryDate</td>
				<td><%=rs2.getString("diaryDate") %></td>
			</tr>
			<tr>
				<td>feeling</td>
				<td><%=rs2.getString("feeling") %></td>
			</tr>
			<tr>
				<td>title</td>
				<td><%=rs2.getString("title") %></td>
			</tr>	
			<tr>
				<td>weather</td>
				<td><%=rs2.getString("weather") %></td>				
			</tr>
			<tr>
				<td>content</td>
				<td><%=rs2.getString("content") %></td>				
			</tr>
			<tr>
				<td>updatedate</td>
				<td><%=rs2.getString("updatedate") %></td>				
			</tr>
			<tr>
				<td>createdate</td>
				<td><%=rs2.getString("createdate") %></td>				
			</tr>
		</table>
		
	<% 		
		}
	%>
	<div>
		<a href="/diary/updateDiaryForm.jsp?diaryDate=<%=diaryDate %>"  class="btn btn-outline-warning"> 일기수정</a>
		<a href="/diary/deleteDiaryForm.jsp?diaryDate=<%=diaryDate %>&title=<%=rs2.getString("title") %>" class="btn btn-outline-warning"> 일기삭제</a>
	</div>
	<!-- 댓글 추가기능 -->
	<div>
		<form method="post" action="/diary/addCommentAction.jsp">
			<input type="hidden" name="diaryDate" value="<%=diaryDate%>">
			<textarea class="rounded" rows="2" cols="50" name="memo"></textarea>	
			<button type="submit" class="btn btn-outline-warning" style="color:#FF5E00">댓글입력</button>	
		</form>
	</div>
	
	<!-- 댓글 리스트 -->
	<%
		String sql3= "select comment_no commentNo, memo, create_date createDate from comment where diary_date=?";
		PreparedStatement stmt3 = null;
		ResultSet rs3 = null;
		
		stmt3= conn.prepareStatement(sql3);
		stmt3.setString(1, diaryDate);
		rs3= stmt3.executeQuery();
		
		
	%>
	<table class="table border">
		<%
			while (rs3.next())	{
		%>
			<tr>
				<td><%=rs3.getString("memo") %></td>
				<td><%=rs3.getString("createDate") %></td>
				<td><a href='/diary/deleteComment.jsp?commentNo=<%=rs3.getInt("commentNo")%>&diaryDate=<%=diaryDate%>'>삭제</a></td>
			</tr>
		<% 		
			}
		%>
	</table>
</div>
</body>
</html>