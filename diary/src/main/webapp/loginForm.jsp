<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.net.*"%>
<%

	
	// 0.로그인 인증 분기  
	// db이름 _ diary.login.my_session => 'on' 일때 => 리다이렉트 ("diary.jsp")로
	/* 이건 db 에서 세션 로그인할때 사용하는 값 sql사용 
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
	if(mySession.equals("ON")) { 
		String loginMsg = URLEncoder.encode("로그인 되었습니다.", "utf-8"); 
		response.sendRedirect("/diary/diary.jsp"); // 로그인이 되었을 때 
		
		return; // 코드 진행을 끝내는 return문법 예)메서드 끝낼때 return문 사용
	}
	*/	
	
	// 로그인(인증 분기) session 사용으로 변경하기 API를 사용 
	// 로그인 성공시 세션에 loginMember 라는 변수를 만들고 값으로 로그인 아이디를 저장한다 
	String loginMember = (String) (session.getAttribute("loginMember"));
	// session.getAttribute() 변수는 찾는 변수가 없으면  null값을 반환한다
	// null이면 로그아웃 상태 , null이 아니면 로그인 상태
	System.out.println(loginMember + "<=loginMember ");
	
	// loginForm 페이지는 로그아웃 상태에서만 출력되는 페이지
	if(loginMember != null) { 
		response.sendRedirect("/diary/diary.jsp"); // 로그인이 되었을 때 
	
		return; 
	}
	
	// 1.요청값 분석
	String errMsg = request.getParameter("errMsg");
	
	
	
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
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
<body class="opacity-75 single" style="background-size: 100%;background-image:url(/diary/img/login.jpg); margin-top: 250px;">
	<div class="container p-5 my-5 border">
	<div class="text-white">
	<h1 class = "text-center" style="color: #FFE400">일기장 로그인 &#128211;</h1>
		<%
			if(errMsg != null) { 
				// 로그인 하지 않았을때 
		%>
			<%=errMsg %>
		<% 		
			} 
		%>
	</div>
	
	<form method="post" action="/diary/loginAction.jsp" >
		<div>
			<div style="color:#FFE400 ">
			아이디 &#128214;:
				<input type="text" name="memberId">
			</div>
			<div style="color:#FFE400 ">
			 비밀번호 &#128274; :
				<input type="password" name="memberPw">
			</div>
			
			<div>
				 <button type="submit" class="btn btn-outline-warning">로그인</button>
			</div>
			
		</div>
		
	</form>
	</div>
</body>
</html>