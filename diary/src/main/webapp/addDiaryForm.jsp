<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%
	//로그인 인증 분기 
	// db이름 _ diary.login.my_session => 'OFF' 일때 => 리다이렉트 ("loginForm.jsp")로
	// Calendar 연도랑 월 받아오기 
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
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg); // 로그인이 안되었을때 다시 로그인 폼페이지로 이동합니다.
	
		return; // 코드 진행을 끝내는 return문법 예)메서드 끝낼때 return문 사용
	}
	
	// 다이어리 상세보기를 위해 페이지 카운팅 diaryOne.jsp로 이동해서 코딩 작성하기 
	/*String sql2 = "select count(diary_date) from diary";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	rs2 = stmt2.executeQuery();
	
	int totalRow = 0;
	if(rs2.next()) { 
		totalRow = rs2.getInt("count(diary_date)");
	}
	System.out.println(totalRow+"<==토탈Row디버깅");
	*/
	
	
	


%>


<%
	String checkDate = request.getParameter("checkDate");
	if(checkDate == null) { 
		checkDate = "";
	}
	String ck = request.getParameter("ck");
	if(ck== null) { 
		ck = "";
	}
	String msg = "";
	if(ck.equals("T")) { 
		msg = "입력이 가능한 날짜입니다.";
	} else if(ck.equals("F")) { 
		msg = "일기가 이미 작성되어 있습니다.";
	}

%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>addDiaryForm</title>
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
	</style>
</head>
<body class="container  my-5 border single" style="background-size:100%;  background-image: url(/diary/img/adddiary.jpg)">
	checkDate : <%=checkDate %><br>
	ck : <%=ck %>
	
	<h1 style="color:#FF5E00 ">일기쓰기 &#128221;</h1>
	<form method="post" action="/diary/checkDateAction.jsp">
		<div>
			날짜 확인 : <input type="date" name="checkDate" value="<%=checkDate%>">
			<span><%=msg %></span>
		</div>
		<div>
			<button type="submit" class="btn btn-outline-warning">날짜가능 확인</button>
		</div>
		<hr>
	</form>
	
	<form method="post" action="/diary/addDiaryAction.jsp">
		<div>
			날짜 :
			<%
				if(ck.equals("T")) {
			%> 
				<input class="rounded btn btn-outline-warning" value="<%=checkDate %>" type="text" name="diaryDate" readonly="readonly">
			<% 		
				} else { 
			%>
				<input class="rounded btn btn-outline-warning" value="<%=checkDate %>" type="text" name="diaryDate" readonly="readonly">
			<% 		
				}
			%>
		</div>
		
		<div>
			기분 : 
			<input type="radio" name="feeling" value="&#128512;">&#128512;
			<input type="radio" name="feeling" value="&#128545;">&#128545;
			<input type="radio" name="feeling" value="&#128567;">&#128567;
			<input type="radio" name="feeling" value="&#128558;">&#128558;
			<input type="radio" name="feeling" value="&#128557;">&#128557;
		</div>
		
		<div>
			제목 : <input class="rounded btn btn-outline-warning" type="text" name="title">
		</div>
		<br>
		<div> 오늘의 날씨 :
			<select  name="weather"  class="btn btn-secondary btn-sm dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
				<option value="맑음">맑음&#9728;</option>
				<option value="흐림">흐림&#127780;</option>
				<option value="비">비&#9730;</option>
				<option value="눈">눈&#10054;</option>	
			</select>
		</div>
		<div>
			<textarea class="rounded btn btn-outline-warning" rows="10" cols="70" name="content"></textarea>
		</div>
		<div>
			<button type="submit" class="btn btn-outline-warning">입력</button>
		</div>
	</form>

</body>
</html>