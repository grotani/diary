<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	String 	checkVote = request.getParameter("checkVote");
	String sql = "select lunch_date lunchDate from lunch where lunch_date=?";
	Connection conn = null;
	PreparedStatement stmt =null;
	ResultSet rs = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,checkVote);
	rs = stmt.executeQuery();
	
	if(rs.next()) { 
		response.sendRedirect("/diary/lunchOne.jsp?checkVote="+checkVote+"&cv=x");
	} else { 
		response.sendRedirect("/diary/lunchOne.jsp?checkVote="+checkVote+"&cv=o");

	}
	
%>