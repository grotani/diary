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
	/* DB로 로그인할때 
	// 로그인 인증 분기 
	// db이름 _ diary.login.my_session => 'OFF' 일때 => 리다이렉트 ("loginForm.jsp")로
	String sql1 = "select my_session mySession from login";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
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
%>	

<%
	// 페이지 
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) { 
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	/*
	if(request.getParameter("rowPerPage") != null) { 
		currentPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	*/
	int startRow = (currentPage-1) * rowPerPage; //1-0 , 2-10 ,3-20 페이지 마다 보여지는 개수  
	
	String serchWord = ""; 
	if(request.getParameter("serchWord") != null) { 
		serchWord = request.getParameter("serchWord");
	}
	/*
		select diary_date diaryDate, title
		from diary 
		where title like ?
		order by diary_date desc
		limit ?, ?
	*/
	String sql2 = "select diary_date diaryDate, title from diary where title like ? order by diary_date desc limit ?, ?";
	Connection conn = null;
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, "%"+serchWord+"%");
	stmt2.setInt(2, startRow);
	stmt2.setInt(3, rowPerPage);
	rs2 = stmt2.executeQuery();
	
	// 전체 행 개수 
	String sql3 = "select count(*)cnt from diary where title like ?";
	PreparedStatement stmt3 = null;
	ResultSet rs3 = null;
	stmt3 = conn.prepareStatement(sql3);
	stmt3.setString(1, "%"+serchWord+"%");
	rs3 = stmt3.executeQuery();
	int totalRow =0;
	if(rs3.next()) {
		totalRow = rs3.getInt("cnt");
	}
	int lastPage = totalRow / rowPerPage;
	if(totalRow %rowPerPage != 0) {
		lastPage = lastPage +1;
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
	a:link {color:#FF5E00; text-decoration: none;}
	a:visited {color:#FF5E00;}
	
	</style>
</head>
<body class="container single">
	<nav class="navbar navbar-expand-sm bg-light  navbar-light">
			<div class="container-fluid">
			<ul class="navbar-nav">
				<li class="nav-item">
					<a class="nav-link" href="/diary/diary.jsp">다이어리 보기</a>
				</li>	
			</ul>
	</nav>
	<div class="container p-5 my-5 border" style="background-size:70%;  background-image: url(/diary/img/flower.jpg)">
		<h1 style="color:#FF5E00">일기 목록</h1>
	</div>
	<table class="table border">
		<tr>
			<th>날짜</th>
			<th>제목</th>
		</tr>
		<%
			while (rs2.next()) { 
		%>
			<tr>
				<td>
				<a href="/diary/diaryOne.jsp?diaryDate=<%=rs2.getString("diaryDate") %>">
				<%=rs2.getString("diaryDate") %>
				</a>
				</td>
				<td><%=rs2.getString("title") %></td>
			</tr>
		<% 		
			}
		%>
	</table>
	<!-- 페이징 버튼 만들기 -->
	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center">
	<%
		if(currentPage >1) {
	%>
		<li class= "page-item">
			<a class="page-link text-danger" href="/diary/diaryList.jsp?currentPage=1">처음페이지</a> 
			</li>
			<li class= "page-item">
				<a class="page-link text-danger" href="/diary/diaryList.jsp?currentPage=<%=currentPage-1%>">이전페이지</a> 
		</li>
	<%		
		} else {
	%>
		<li class="page-item disabled">
			<a class ="page-link text-danger" href="/diary/diaryList.jsp?currentPage=1">처음페이지</a>
				</li>
			<li class="page-item disabled">
				<a class ="page-link text-danger" href="/diary/diaryList.jsp?currentPage=<%=currentPage-1%>">이전페이지</a>
		</li>
	<% 		
		}
		if(currentPage < lastPage) {
	%>
		<li class="page-item">
				<a class ="page-link text-danger" href="/diary/diaryList.jsp?currentPage=<%=currentPage+1%>">다음페이지</a>
		</li>
		<li class="page-item">
			<a class ="page-link text-danger" href="/diary/diaryList.jsp?currentPage=<%=lastPage%>">마지막페이지</a>
		</li>
	<% 		
		}
	%>
	
		</ul>
	</nav>
	<a href="/diary/diaryList.jsp?=currentPage=<%=currentPage-1%>">이전</a>
	<a href="/diary/diaryList.jsp?=currentPage=<%=currentPage+1%>">다음</a>
	
	
	
	<form method="get" action="/diary/diaryList.jsp" >
	<div style="color: #FF5E00 ">
		제목검색 :
		<input type="text" name="serchWord">
		<button type="submit" class="btn btn-outline-warning">검색</button>
	</div>
	</form>
</body>
</html>