<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%
	// my_session  ON => OFF 로 변경 
	

	// 로그인 인증 분기 
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
	
	// 현재값이 OFF아니고 ON이다 => OFF로 변경 후 loginForm Redirect
	String sql2 = "update login set my_session='OFF' , off_date=now() where my_session='ON' ";
	PreparedStatement stmt2 = null;
	stmt2 = conn.prepareStatement(sql2);
	int row = stmt2.executeUpdate();
	System.out.println(row + "<== row 값");
	
	response.sendRedirect("/diary/loginForm.jsp");
	

%>