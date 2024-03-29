<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%
	// 로그인 인증 분기
	String loginMember = (String)(session.getAttribute("loginMember"));
	System.out.println(loginMember + "<=loginMember ");

	if(loginMember == null) { // 로그아웃일때 
		String errMsg = URLEncoder.encode("잘못된 접근 입니다. 로그인 먼저 해주세요", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg);
		return;
	} 
%>
<%
	//로그인 인증 분기 
	// db이름 _ diary.login.my_session => 'OFF' 일때 => 리다이렉트 ("loginForm.jsp")로
	/*
	String sql1 = "select my_session mySession from login";
	
	
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	
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


	String sql2= "SELECT lunch_date lunchDate, menu, update_date updatedate, create_date createdate FROM lunch WHERE lunch_date = CURDATE();";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	stmt2 = conn.prepareStatement(sql2);
	rs2 = stmt2.executeQuery();
	
	
	String 	checkVote = request.getParameter("checkVote");
	if(checkVote == null) { 
		checkVote = "";
	}
	String cv = request.getParameter("cv");
	if(cv == null) {
		cv = "";
	}
	String msg = "";
	if(cv.equals("o")) {
		msg = "투표가 가능합니다.";
	} else if(cv.equals("x")) {
		msg = "이미 투표를 하셨습니다.";
	}
	

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
	
	<%
		if(rs2.next()) { 
	%>
	<div class="container p-5 my-5 border" style="background-size:70%;  background-image: url(/diary/img/flower.jpg)">
	<h1 style="color:#FF5E00">투표상세보기</h1>
	</div>
	<table class="table border">
			<tr>
				<td>lunchDate</td>
				<td><%=rs2.getString("lunchDate") %></td>
			</tr>
			
			<tr>
				<td>menu</td>
				<td><%=rs2.getString("menu") %></td>
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
		<div>
			<a href="/diary/deletelunch.jsp?lunchDate=<%=rs2.getString("lunchDate")%>" class="btn btn-outline-warning"> 삭제하기</a>
			<a href="/diary/statsLunch.jsp?lunchDate=<%=rs2.getString("lunchDate")%>" class="btn btn-outline-warning"> 통계보기</a>
		</div>
	<%
		} else {
	%>
	 
		<h1>투표하기</h1>
		
		<form method="post" action="/diary/checkLunchAction.jsp">
			<div>
				날짜 확인 : <input type="date" name="checkVote" value="<%=checkVote%>">
				<span><%=msg %></span>
			</div>
			<div>
			<button type="submit" class="btn btn-outline-warning">날짜가능 확인</button>
		</div>
			</form>
			
		<form method="get" action="/diary/lunchAction.jsp">
		<table class="table border">
			<tr>
				<td> 날짜 :
				<%
					if(cv.equals("o")) {
				%>
					<input class="rounded btn btn-outline-warning" value="<%=checkVote %>" type="text" name="lunchDate" readonly="readonly">
				<% 		
					} else {
				%>
					<input class="rounded btn btn-outline-warning" value="" type="text" name="lunchDate" readonly="readonly">
					
				<% 		
					}
				%>
				</td>
				</tr>
			
			<tr>
				<td>메뉴 :
					<input type="radio" name="menu" value="한식">한식
					<input type="radio" name="menu" value="중식">중식
					<input type="radio" name="menu" value="양식">양식
					<input type="radio" name="menu" value="일식">일식
					<input type="radio" name="menu" value="기타">기타
				</td>
			</tr>
		</table>	
			<button type="submit" class="btn btn-outline-warning" >투표</button>
		</form>
	<%		
		}
	%>	
	

</body>
</html>