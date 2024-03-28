<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
	// 요청값 가져오기
	String diaryDate = request.getParameter("diaryDate");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String updatedate = request.getParameter("updatedate");
	
	// 요청값 디버깅 작업
	
	System.out.println(title);
	System.out.println(content);
	System.out.println(updatedate);
	
	// db업데이트 쿼리 
	String sql = "UPDATE diary SET title=?, content=?, update_date=NOW() WHERE diary_date = ?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	int row = 0;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,title);
	stmt.setString(2,content);
	stmt.setString(3,diaryDate);
	
	System.out.println(stmt + "일기수정");

	row = stmt.executeUpdate();
	
	if(row == 1) { 
		response.sendRedirect("/diary/diaryOne.jsp?diaryDate="+diaryDate);
		
	} else { 
		response.sendRedirect("/diary/updateDiaryForm.jsp?diaryDate="+diaryDate);
	}
%>
