<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*" %>
<%
	String lunchDate = request.getParameter("lunchDate");
	
	String sql = "delete from lunch where lunch_date = ?";
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, lunchDate);
	int row = 0;
	row=stmt.executeUpdate();
			
	
	if(row == 0) {
		response.sendRedirect("/diary/statsLunch.jsp?lunchDate="+lunchDate);
	} else { 
		response.sendRedirect("/diary/lunchOne.jsp");
	}
%>
