<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>

<%
	request.setCharacterEncoding("UTF-8");

	String diaryDate = request.getParameter("diaryDate");
	String memo = request.getParameter("memo");
	
	System.out.println(diaryDate + "<==다이어리 날짜");
	System.out.println(memo + "<==댓글입력");
	
	// DB입력값 
	/*
		INSERT INTO COMMENT(
		diary_date,memo, update_date, create_date
		) VALUES (
		'2024-04-06','댓글',NOW(), NOW());
	*/

	String sql = "INSERT INTO COMMENT (diary_date, memo, update_date, create_date) VALUES (?, ?, NOW(), NOW())";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, diaryDate);
	stmt.setString(2, memo);
	
	
	System.out.println(stmt);

	int row = stmt.executeUpdate();
	if( row == 1) {
		System.out.println("댓글입력완료");
	} else { 
		System.out.println("댓글입력실패");
	}
	// 다이어리 상세보기로 넘어가기 
	response.sendRedirect("/diary/diaryOne.jsp?diaryDate="+diaryDate);
%>
