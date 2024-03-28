<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*"%>
<%
	// post 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	// 입력값
	String lunchDate = request.getParameter("lunchDate");
	String menu = request.getParameter("menu");
	
	System.out.println(menu);
	
	/* 메뉴투표 입력값 
	INSERT INTO lunch(lunch_date, menu, update_date, create_date)
	 VALUES (CURDATE(), '한식',NOW(),NOW());
	*/
	
	String sql = "INSERT INTO lunch(lunch_date, menu, update_date, create_date) VALUES (?, ? ,NOW(), NOW())";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,lunchDate);
	stmt.setString(2,menu);
	int row = stmt.executeUpdate();
	System.out.println(stmt);
	
	if(row == 1) { 
		System.out.println("메뉴 투표");
		//투표하고 갈 페이지 
		response.sendRedirect("/diary/statsLunch.jsp");
	} else { 
		System.out.println("메뉴미투표");
		
		response.sendRedirect("/diary/lunchOne.jsp");
	
	} 
%>