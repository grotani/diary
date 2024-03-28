<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*" %>
<%
	// 요청하기
	String diaryDate = request.getParameter("diaryDate");
	System.out.println(diaryDate);
	
	// 삭제쿼리 
	String sql = "delete from diary where diary_date = ?";
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,diaryDate);
	int row = stmt.executeUpdate();
	
	
	if(row == 0) { 
		response.sendRedirect("/deleteDiaryForm.jsp?diaryDate="+diaryDate);
	} else { 
		response.sendRedirect("/diary/diaryList.jsp");
	}

%>
