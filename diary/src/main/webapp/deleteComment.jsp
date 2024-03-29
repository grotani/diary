<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
	
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	String diaryDate = request.getParameter("diaryDate");
	

	
	String sql = "delete from comment where comment_no=?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, commentNo);
	int row = stmt.executeUpdate();
	System.out.println(row + "<=댓글삭제확인");
	
	
	// 삭제되고 보내줄 페이지 ... 다이어리 날짜를 받아와서 보내준다.
	response.sendRedirect("/diary/diaryOne.jsp?diaryDate="+diaryDate);
	
	
	
%>