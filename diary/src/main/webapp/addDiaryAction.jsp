<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
	// post 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	// 입력값 받아오기
	String diaryDate = request.getParameter("diaryDate");
	String feeling = request.getParameter("feeling");
	String title = request.getParameter("title");
	String weather = request.getParameter("weather");
	String content = request.getParameter("content");
	

	// 디버깅
	System.out.println(diaryDate);
	System.out.println(feeling);
	System.out.println(title);
	System.out.println(weather);
	System.out.println(content);
	
	// DB 입력값 가져오기
	/*
	INSERT INTO diary(diary_date, title, weather, content, update_date, create_date)
	VALUES ('2024-03-22', '진지한 일기장', '흐림', '지지하게 사는 연습', NOW(), NOW() );
	*/
	
	String sql = "INSERT INTO diary(diary_date, feeling, title, weather, content, update_date, create_date) VALUES (?, ?, ?, ?, ?, NOW(), NOW())";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,diaryDate);
	stmt.setString(2,feeling);
	stmt.setString(3,title);
	stmt.setString(4,weather);
	stmt.setString(5,content);
	int row = stmt.executeUpdate();
	
	
	if(row == 1) { 
		System.out.println("다이어리 입력");
		// 일기를 작성하고 돌아갈 페이지
		response.sendRedirect("/diary/diary.jsp");
	} else { 
		System.out.println("다이어리 미입력");
		// 일기 미작성시 
		response.sendRedirect("/diary/addDiaryForm.jsp");
	
	} 
	
	
	
	
%>	

