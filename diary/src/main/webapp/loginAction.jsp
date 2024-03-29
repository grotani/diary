<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>

<%
	// 0.로그인 인증 분기 
	String loginMember = (String)(session.getAttribute("loginMember"));
	//login 로그아웃 상태 , null이 아니면 로그인 상태
	System.out.println(loginMember + "<=loginMember ");
	
	// loginForm 페이지는 로그아웃 상태에서만 출력되는 페이지
	if(loginMember != null) { 
		response.sendRedirect("/diary/diary.jsp"); // 로그인이 되었을 때 
	
		return; 
	}
	// loginMember가 null 이다 -> session 공간에  loginMember변수를 생성하고
%>

<% 		
	// 1.요청값 분석 -> 로그인 성공유무 판단 -> session 에 loginMember변수 생성한다.
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	String sql2 = "SELECT member_id memberId from member where member_id=? and member_pw=?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1,memberId);
	stmt2.setString(2,memberPw);
	rs2 = stmt2.executeQuery();
	
	
	if(rs2.next()) { 
		// 로그인 성공한다 
		System.out.println("로그인 성공");
		
	
		/*
		String sql3 = "update login set my_session='ON', on_date= Now() where my_session='OFF'";
		PreparedStatement stmt3 = conn.prepareStatement(sql3);
		int row = stmt3.executeUpdate();
		System.out.println(row+"<== row");
		*/
		// 로그인 성공시 db값 설정에서 session 변수 셋팅으로 설정 세션에 ID만!! pw 넣으면 안됨 해킹 될 수 있음 
		session.setAttribute("loginMember", rs2.getString("memberId"));
		response.sendRedirect("/diary/diary.jsp");
		
	} else { 
		// 로그인이 실패 
		System.out.println("로그인 실패");
		String errMsg = URLEncoder.encode("아이디와 비밀번호를 확인해주세요.", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg);
		
	} 
		
	
%>
