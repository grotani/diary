<%@page import="java.util.Calendar"%>
<%@page import="java.net.URLEncoder"%>
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
	// 달력 만들기 출력하고자 하는 달력의 년도랑 월 값 가져오기 
	String targetYear = request.getParameter("targetYear");
	String targetMonth = request.getParameter("targetMonth");
	
	Calendar target = Calendar.getInstance();
	
	if(targetYear != null && targetMonth != null) { 
		target.set(Calendar.YEAR, Integer.parseInt(targetYear));
		target.set(Calendar.MONTH, Integer.parseInt(targetMonth));
		
	}
	
	// 시작 공백 개수 
	target.set(Calendar.DATE,1);
	
	int dYear = target.get(Calendar.YEAR);
	int dMonth = target.get(Calendar.MONTH);
	int yoNum = target.get(Calendar.DAY_OF_WEEK);  // 해당 월이 1일의 요일값 
	System.out.println(yoNum+"<= 요일값"); 
	
	int startBlank = yoNum - 1; // 해당 월 시작 공백일의 개수 yoNum-1 이 공백일의 개수  
	int lastDate = target.getActualMaximum(Calendar.DATE);
	System.out.println(lastDate+"<== 당월 마지막날짜");
	
	int countDiv = startBlank + lastDate;
	
	// DB에서 tYear 와  tMonth  에 해당되는 diary목록 추출하기 
	String sql2 = "select diary_date diaryDate, day(diary_date) day, feeling, left(title,5) title from diary where year(diary_date)=? and month(diary_date)=?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;		
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setInt(1, dYear);
	stmt2.setInt(2, dMonth+1);
	System.out.println(stmt2);
	
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
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<style>
	
	.single{
	  font-family: "Single Day", cursive;
	  font-weight: 400;
	  font-style: normal;
	}
	
	
		a:link {color:#FF5E00; text-decoration: none;  }
		a:visited {color:#FF5E00;}
		
		.yo {
			float: left;
			width: 70px; height: 25px;
			border: 2px solid #000000;
			border: 2px solid #BCE9B7;
			border-radius: 10px;
			margin: 5px;
			margin-top : 20px;
			text-align: center;
			color : #000000;
		}
		.cell { 
			float: left;
			background-color: #CEFBC9;
			width: 70px; height: 70px;
			border: 2px solid #AAD7A5;
			border: 2px solid #AAD7A5;
			border-radius: 10px;
			margin: 5px;
			text-align: center;
			
		}
		
		
		.m {
			
			color : #47C83E;
			text-decoration: none;
		
			
		}
		
 			
		
	</style>
</head>

<body class="container single" >
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
	
	<div class="container p-5 my-5 border" style="background-size:70%;  background-image: url(/diary/img/flower.jpg)">
		<h1 class = "text-center" style="color:#FFE400">일기장</h1>
	</div>
	<div class= "d-flex justify-content-end">
		<a href="/diary/logout.jsp" style="color:#FFE400" class="btn btn-outline-warning ml-2">로그아웃</a>
		<a href="/diary/addDiaryForm.jsp"style="color:#FFE400" class="btn btn-outline-warning">일기쓰기</a>
		<a href="/diary/statsLunch.jsp"style="color:#FFE400" class="btn btn-outline-warning">메뉴통계</a>
		<a href="/diary/lunchOne.jsp" style="color:#FFE400" class="btn btn-outline-warning ml-2">점심메뉴 투표</a>
	</div>
	
	
	<!-- 다이어리 달력 보여주기 -->
	<div class="container p-5 my-5 border" style="text-align: center;">
		<h1 style="color:#74A16F; text-align: center;" ><%=dYear %>년 <%=dMonth+1 %>월 &#128197;</h1>
	<div>
		<a href="./diary.jsp?targetYear=<%=dYear%>&targetMonth=<%=dMonth-1%>" class="m">이전달</a>
		<a href="./diary.jsp?targetYear=<%=dYear%>&targetMonth=<%=dMonth+1%>" class="m">다음달</a>
	</div>
	
	<table style="margin: auto;">
		<tr>
			<th class="yo">일</th>
			<th class="yo">월</th>
			<th class="yo">화</th>
			<th class="yo">수</th>
			<th class="yo">목</th>
			<th class="yo">금</th>
			<th class="yo">토</th>
		</tr>	
	
					<tr>
						<%
							for(int i=1; i<=countDiv; i++) {
						%>
								<td class="cell">
									<%
										if(i>startBlank && i<=startBlank+lastDate) {
											if(i%7 == 0) {
									%>
												<span class="text-primary "><%=i-startBlank%></span>
												
									<%			
											} else if(i%7 == 1) {
									%>
												<span class="text-danger "><%=i-startBlank%></span>
									<%																
											}else {
									%>
												<%=i-startBlank%><br>
												
									<%			
										// 현재 날짜(i-startBlank) 의 일기가 rs2 목록에 있는지 비교
											while(rs2.next()) { 
												// 날짜에 일기가 존재한다 
												if(rs2.getInt("day") == (i-startBlank)) { 
									%>
												<div>
													<span><%=rs2.getString("feeling") %></span>
													<a href='/diary/diaryOne.jsp?diaryDate=<%=rs2.getString("diaryDate")%>'>
														<%=rs2.getString("title") %> ... 
													</a>
												</div>
									<% 				
												break;
												}
											}
											}	
											rs2.beforeFirst();
										} else {
									%>
											&nbsp;
									<%
										}
									%>		
								</td>
						<%	
								if(i!=countDiv && i%7 == 0) {
						%>
									</tr><tr>
						<%			
								}
							}
						%>
					</tr>
				</table>
			</div>
	
		
	
</body>
</html>