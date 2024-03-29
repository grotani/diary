<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%
	// 로그인 인증 분기 받아오기 
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
%>	

<%
	/* 쿼리 가져오기 
	SELECT menu,COUNT(*) 
	FROM lunch
	GROUP BY menu
	ORDER BY COUNT(*) DESC;
	*/
	String sql2= "SELECT menu,COUNT(*)cnt FROM lunch GROUP BY menu";
	PreparedStatement stmt2 = null; 
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	rs2 = stmt2.executeQuery();
	
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
	
	<h1  class = "text-center" style="color:#FF5E00">점심메뉴 통계</h1>
	<%
		double maxHeight = 500; 
		double totalCnt = 0; // 
		while(rs2.next()) { 
			totalCnt = totalCnt + rs2.getInt("cnt");
		}
		rs2.beforeFirst();
	%>
	<div  class = "text-center">
		전체 투표수 :<%=(int)totalCnt %>
	</div>
	<div style="text-align: center;">
		<table border="1" style="margin: auto;" >
			<tr>
				<%
					String[] c = {"#FF0000","#FF5E00","#FFE400","#1DDB16","#0100FF"};
					int i =0;
					while (rs2.next()) {
						int h =(int)(maxHeight*(rs2.getInt("cnt")/totalCnt));				
				%>
					<td style="vertical-align: bottom;">
						<div style="height:<%=h %>px; 
						 			background-color:<%=c[i] %>; 
						 			text-align: center">
							<%=rs2.getInt("cnt")%>
						</div>
					</td>
				<% 		
					i = i+1;
					}
				%>
			</tr>
			<tr>
				<%
					//커서의 위치를 다시 처음으로 
					rs2.beforeFirst();	
					while (rs2.next()) {
				%>
					<td><%=rs2.getString("menu")%></td>
				<% 		
					}
				%>		
			</tr>
		</table>
	
	</div>
	
	
</body>
</html>